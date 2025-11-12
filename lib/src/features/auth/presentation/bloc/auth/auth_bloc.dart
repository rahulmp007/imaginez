import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imaginez/src/features/auth/domain/entity/user.dart';
import 'package:imaginez/src/features/auth/domain/usecases/auth_user_changed..dart';
import 'package:imaginez/src/features/auth/domain/usecases/get_current_user.dart';
import 'package:imaginez/src/features/auth/domain/usecases/logout_user.dart';
import 'package:imaginez/src/features/auth/domain/usecases/save_user.dart';
import 'package:imaginez/src/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:imaginez/src/features/auth/presentation/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogoutUser logoutUser;
  final GetCurrentUser getCurrentUser;
  final ObserveAuthState observeAuthState;

  StreamSubscription<User?>? _authStreamSubscription;

  AuthBloc({
    required this.getCurrentUser,
    required this.logoutUser,
    required this.observeAuthState,
  }) : super(AuthInitial()) {
    on<LogoutRequested>(onLogout);
    on<CheckAuthStatus>(onCheckAuthStatus);
    on<AuthUserChanged>(_onAuthUserChanged);
  }

  void _onAuthUserChanged(AuthUserChanged event, Emitter<AuthState> emit) {
    _authStreamSubscription?.cancel();
    _authStreamSubscription = observeAuthState().listen(
      (user) => add(AuthUserChanged(user)),
    );
  }

  Future onLogout(LogoutRequested event, emit) async {
    await logoutUser();
    emit(Unauthenticated());
  }

  Future onCheckAuthStatus(CheckAuthStatus event, emit) async {
    emit(AuthLoading());

    final result = await getCurrentUser();

    log('current user : $result');

    result.fold((failure) => emit(Unauthenticated()), (user) {
      return user != null
          ? emit(Authenticated(user: user))
          : emit(Unauthenticated());
    });
  }

  @override
  Future<void> close() {
    if (_authStreamSubscription != null) {
      _authStreamSubscription?.cancel();
    }
    return super.close();
  }
}
