// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:imaginez/src/features/auth/domain/entity/user.dart';
import 'package:imaginez/src/features/auth/domain/value_objects/email_address.dart';
import 'package:imaginez/src/features/auth/domain/value_objects/name.dart';
import 'package:imaginez/src/features/auth/domain/value_objects/password.dart';

class SignupState extends Equatable {
  final Name? fullname;
  final EmailAddress? email;
  final Password? password;
  final bool? showPassword;
  final User? user;
  final bool isSubmitting;
  final String? errorMessage;

  const SignupState({
    this.fullname,
    this.email,
    this.password,
    this.showPassword = false,
    this.user,
    this.isSubmitting = false,
    this.errorMessage,
  });

  bool get isPasswordVisible => showPassword ?? false;
  bool get isEmailValid => email?.isValid ?? false;
  bool get isPasswordValid => password?.isValid ?? false;
  bool get isNameValid => fullname?.isValid ?? false;
  bool get canSubmit =>
      isEmailValid && isPasswordValid && isNameValid && !isSubmitting;

  SignupState copyWith({
    Name? fullname,
    EmailAddress? email,
    Password? password,
    bool? showPassword,
    User? user,
    bool? isSubmitting,
    String? errorMessage,
  }) => SignupState(
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      password: password ?? this.password,
      showPassword: showPassword ?? this.showPassword,
      user: user ?? this.user,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage ?? this.errorMessage,
    );

  factory SignupState.initial() => const SignupState(
    
  );

  @override
  List<Object?> get props => [
    fullname,
    email,
    password,
    user,
    showPassword,
    isSubmitting,
    errorMessage,
  ];

  @override
  bool? get stringify => true;
}
