import 'package:dartz/dartz.dart';
import 'package:imaginez/src/core/error/failure.dart';
import 'package:imaginez/src/features/auth/data/models/user_model.dart';
import 'package:imaginez/src/features/auth/domain/entity/user.dart';
import 'package:imaginez/src/features/auth/domain/repository/auth_repository.dart';

class SaveUser {
  final AuthRepository repository;
  SaveUser({required this.repository});

  Future<Either<AppError, UserModel>> call({required User user}) async {
    return await repository.saveUser(user: user);
  }
}
