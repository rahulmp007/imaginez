import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imaginez/src/features/auth/domain/usecases/logout_user.dart';
import 'package:imaginez/src/features/auth/domain/usecases/save_user.dart';
import 'package:imaginez/src/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:imaginez/src/features/auth/presentation/bloc/login/login_event.dart';
import 'package:imaginez/src/features/auth/presentation/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SignInWithGoogle signInWithGoogle;
  final SaveUser saveUser;
  final LogoutUser logoutUser;
  LoginBloc({
    required this.signInWithGoogle,
    required this.saveUser,
    required this.logoutUser,
  }) : super(const LoginState()) {
    on<GoogleLoginRequested>(onLogin);
    on<ClearError>(onClearError);
  }

  FutureOr<void> onLogin(GoogleLoginRequested event, emit) async {
    final result = await signInWithGoogle();
    emit(const LoginState(isSigningIn: true));

    await result.fold(
      (appError) {
        emit(
          state.copyWith(isSigningIn: false, errorMessage: appError.message),
        );
      },
      (user) async {
        log('app user : $user');

        emit(state.copyWith(isSigningIn: false, user: user, clearError: true));

        // final saveUserResult = await saveUser(user: user);

        // await saveUserResult.fold(
        //   (failure) async {
        //     await logoutUser();
        //     emit(
        //       state.copyWith(isSigningIn: false, user: null, clearError: true),
        //     );
        //   },
        //   (result) {
        //     emit(
        //       state.copyWith(isSigningIn: false, user: user, clearError: true),
        //     );
        //   },
        // );
      },
    );
  }

  FutureOr<void> onClearError(event, emit) {
    emit(state.copyWith(clearError: true));
  }
}
