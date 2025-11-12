// lib/features/authentication/domain/usecases/get_current_user.dart
import 'package:dartz/dartz.dart';
import 'package:imaginez/src/core/error/failure.dart';
import 'package:imaginez/src/features/auth/domain/entity/user.dart';
import 'package:imaginez/src/features/auth/domain/repository/auth_repository.dart';

class GetCurrentUser {
  final AuthRepository repository;
  GetCurrentUser({required this.repository});

  Future<Either<AppError, User?>> call() async => await repository.getCurrentUser();
}
