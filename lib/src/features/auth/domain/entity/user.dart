// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uuid;
  final String email;
  final String displayName;
  final String photoUrl;
  final bool isEmailVerified;

  const User({
    required this.uuid,
    required this.email,
    required this.displayName,
    required this.photoUrl,
    required this.isEmailVerified,
  });

  @override
  List<Object?> get props => [
    uuid,
    displayName,
    email,
    photoUrl,
    isEmailVerified,
  ];
}
