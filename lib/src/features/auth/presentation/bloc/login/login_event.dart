// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class LoginEvent {}

class GoogleLoginRequested extends LoginEvent {}

class LogoutRequested extends LoginEvent {}

class ClearError extends LoginEvent {}
