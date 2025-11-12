import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:imaginez/src/core/error/failure.dart';
import 'package:imaginez/src/core/network/api_client.dart';
import 'package:imaginez/src/core/network/api_constants.dart';
import 'package:imaginez/src/core/network/error_handler.dart';
import 'package:imaginez/src/features/auth/data/models/user_model.dart';
import 'package:imaginez/src/features/auth/domain/entity/user.dart' as domain;

abstract class AuthRemoteDataSource {
  Future<UserModel> signInWithGoogle();
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
  Stream<UserModel?> get authStateChanges;
  Future saveUser({required domain.User user});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final ApiClient _client;

  AuthRemoteDataSourceImpl({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
    required ApiClient client,
  }) : _firebaseAuth = firebaseAuth,
       _googleSignIn = googleSignIn,
       _client = client;

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      log('🔄 Repository: Starting Google sign-in...');
      await _googleSignIn.initialize();

      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);

      final currentUser = userCredential.user;

      log('currentUser : $currentUser');
      if (userCredential.user == null) {
        throw const AuthError(
          message: 'Sign-in failed. No user returned.',
          authErrorCode: 'auth/no-user-returned',
          shouldRetry: true,
        );
      }

      return UserModel(
        displayName: currentUser?.displayName ?? '',
        uuid: currentUser?.uid ?? '',
        email: currentUser?.email ?? '',
        photoUrl: currentUser?.photoURL ?? '',
        isEmailVerified: currentUser?.emailVerified ?? false,
      );
    } on GoogleSignInException catch (e) {
      log('GoogleSignInException : $e');
      throw AuthError(
        message: 'Operation cancelled by user',
        authErrorCode: FirebaseAuthErrorCode.popupClosedByUser.value,
      );
    } catch (error) {
      log('catching error : $error');
      throw UnknownError(
        message: 'Unexpected error during Google sign-in',
        technicalMessage: error.toString(),
      );
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
    } catch (error) {
      throw UnknownError(
        message: 'Failed to sign out',
        technicalMessage: error.toString(),
      );
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      return user != null
          ? UserModel(
              displayName: user.displayName ?? '',
              uuid: user.uid,
              email: user.email ?? '',
              photoUrl: user.photoURL ?? '',
              isEmailVerified: user.emailVerified,
            )
          : null;
    } catch (error) {
      throw UnknownError(
        message: 'Failed to get current user',
        technicalMessage: error.toString(),
      );
    }
  }

  @override
  Stream<UserModel?> get authStateChanges =>
      _firebaseAuth.authStateChanges().map(
        (u) => UserModel(
          uuid: u?.uid ?? '',
          email: u?.email ?? '',
          displayName: u?.displayName ?? '',
          photoUrl: u?.photoURL ?? '',
          isEmailVerified: u?.emailVerified ?? false,
        ),
      );

  @override
  Future saveUser({required domain.User user}) async {
    return await _client.post(
      url: '${ApiConstants.baseUrl}/${ApiConstants.saveUser}',
      data: {
        'name': user.displayName,
        'email': user.email,
        'googleId': user.uuid,
        'avatar': user.photoUrl,
      },
    );
  }
}
