// lib/features/auth/data/mappers/user_mapper.dart
import 'package:imaginez/src/features/auth/data/models/user_model.dart';
import 'package:imaginez/src/features/auth/domain/entity/user.dart';

class UserMapper {
  static UserModel fromEntity(User entity) => UserModel(
      uuid: entity.uuid,
      displayName: entity.displayName,
      email: entity.email,
      photoUrl: entity.photoUrl,
      isEmailVerified: entity.isEmailVerified,
    );

  static User toEntity(UserModel model) => User(
      uuid: model.uuid,
      displayName: model.displayName,
      email: model.email,
      photoUrl: model.photoUrl,
      isEmailVerified: model.isEmailVerified,
    );
}
