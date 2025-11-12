import 'package:equatable/equatable.dart';
import 'package:imaginez/src/features/auth/domain/entity/user.dart';

class LoginState extends Equatable {
  final bool isSigningIn;
  final User? user;
  final String? errorMessage;
  final int? errorId;

  const LoginState({
    this.isSigningIn = false,
    this.user,
    this.errorMessage,
    this.errorId,
  });

  LoginState copyWith({
    bool? isSigningIn,
    User? user,
    String? errorMessage,
    bool clearError = false,
  }) => LoginState(
      isSigningIn: isSigningIn ?? this.isSigningIn,
      user: user ?? this.user,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      errorId: clearError ? null : DateTime.now().millisecondsSinceEpoch,
    );

  factory LoginState.initial() => const LoginState();

  @override
  List<Object?> get props => [isSigningIn, user, errorMessage, errorId];

  @override
  bool get stringify => true;
}
