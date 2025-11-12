// lib/features/authentication/data/repositories/auth_repository_impl.dart
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:imaginez/src/core/error/failure.dart';
import 'package:imaginez/src/features/auth/data/data_sources/auth_remote_source.dart';
import 'package:imaginez/src/features/auth/data/data_sources/auth_local_source.dart';
import 'package:imaginez/src/features/auth/data/mappers/user_mapper.dart';
import 'package:imaginez/src/features/auth/data/models/user_model.dart';
import 'package:imaginez/src/features/auth/domain/entity/user.dart';
import 'package:imaginez/src/features/auth/domain/repository/auth_repository.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource api;
  final AuthLocalDataSource local;
  AuthRepositoryImpl({required this.api, required this.local});

  @override
  Future<Either<AppError, User>> signInWithGoogle() async {
    try {
      final data = await api.signInWithGoogle();
      await local.cacheUser(user: data);
      return Right(UserMapper.toEntity(data));
    } catch (e) {
      if (e is AuthError) {
        return Left(e);
      } else {
        return const Left(UnknownError());
      }
    }
  }

  @override
  Future<Either<AppError, void>> signOut() async {
    try {
      await api.signOut();
      await local.clearUser();
      return const Right(null);
    } catch (e) {
      return const Left(UnknownError());
    }
  }

  @override
  Future<Either<AppError, User?>> getCurrentUser() async {
    try {
      final User? currentUser = await local.getCachedUser();
      if (kDebugMode) {
        log('cached user : ${currentUser.toString()}');
      }
      return Right(currentUser);
    } catch (e) {
      return const Left(UnknownError());
    }
  }

  @override
  Stream<User?> get authStateChanges => api.authStateChanges.map(
    (u) => User(
      uuid: u?.uuid ?? '',
      email: u?.email ?? '',
      displayName: u?.displayName ?? '',
      photoUrl: u?.photoUrl ?? '',
      isEmailVerified: u?.isEmailVerified ?? false,
    ),
  );

  @override
  Future<Either<AppError, UserModel>> saveUser({required User user}) async {
    try {
      return Right(await api.saveUser(user: user));
    } catch (e) {
      if (e is AuthError) {
        return Left(e);
      } else {
        return const Left(UnknownError());
      }
    }
  }
}
