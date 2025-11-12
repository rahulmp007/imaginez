// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class SignupEvent {}

class SignupRequested extends SignupEvent {
  final String name;
  final String email;
  final String password;

  SignupRequested({
    required this.name,
    required this.email,
    required this.password,
  });
}

class NameChanged extends SignupEvent {
  final String value;
  NameChanged({required this.value});
}

class EmailChanged extends SignupEvent {
  final String value;
  EmailChanged({required this.value});
}

class PasswordChanged extends SignupEvent {
  final String value;
  PasswordChanged({required this.value});
}

class TogglePasswordVisibility extends SignupEvent {}
