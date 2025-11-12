import 'package:imaginez/src/features/auth/domain/repository/auth_repository.dart';

class LogoutUser {
  final AuthRepository repository;
  LogoutUser({required this.repository});

  Future<void> call() async => await repository.signOut();
}
