import 'package:imaginez/src/features/auth/domain/entity/user.dart';
import 'package:imaginez/src/features/auth/domain/repository/auth_repository.dart';

class ObserveAuthState {
  final AuthRepository repository;
  ObserveAuthState({required this.repository});

  Stream<User?> call() => repository.authStateChanges;
}
