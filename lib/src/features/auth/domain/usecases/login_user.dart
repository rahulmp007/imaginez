import 'package:dartz/dartz.dart';
import 'package:imaginez/src/core/error/failure.dart';
import 'package:imaginez/src/features/auth/domain/entity/user.dart';
import 'package:imaginez/src/features/auth/domain/repository/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;
  LoginUser({required this.repository});

  Future<Either<AppError, User>> call({
    required String email,
    required String password,
  }) async => repository.signInWithGoogle();
}
