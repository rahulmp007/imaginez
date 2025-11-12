// features/auth/domain/usecases/google_sign_in_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:imaginez/src/core/error/failure.dart';
import 'package:imaginez/src/features/auth/domain/entity/user.dart';
import 'package:imaginez/src/features/auth/domain/repository/auth_repository.dart';

class SignInWithGoogle {
  final AuthRepository repository;

  SignInWithGoogle({required this.repository});

  Future<Either<AppError, User>> call() async => await repository.signInWithGoogle();
}
