import 'package:equatable/equatable.dart';
import 'package:imaginez/src/features/auth/domain/entity/user.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckAuthStatus extends AuthEvent {}

class LogoutRequested extends AuthEvent {}

class AuthUserChanged extends AuthEvent {
  final User? user;
  AuthUserChanged(this.user);

  @override
  List<Object?> get props => [user];
}
