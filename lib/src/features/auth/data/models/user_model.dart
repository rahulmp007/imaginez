// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  final String uuid;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String displayName;

  @HiveField(3)
  final String photoUrl;

  @HiveField(4)
  final bool isEmailVerified;

  
  UserModel({
    required this.uuid,
    required this.email,
    required this.displayName,
    required this.photoUrl,
    required this.isEmailVerified,
  });
}
