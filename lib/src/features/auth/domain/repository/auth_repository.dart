import 'package:dartz/dartz.dart';
import 'package:imaginez/src/core/error/failure.dart';
import 'package:imaginez/src/features/auth/data/models/user_model.dart';
import 'package:imaginez/src/features/auth/domain/entity/user.dart';

abstract class AuthRepository {
  Future<Either<AppError, User>> signInWithGoogle();
  Future<void> signOut();
  Future<Either<AppError, User?>> getCurrentUser();
  Stream<User?> get authStateChanges;
  Future<Either<AppError, UserModel>> saveUser({required User user});
}
