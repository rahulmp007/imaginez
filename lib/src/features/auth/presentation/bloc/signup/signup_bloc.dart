// import 'dart:async';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:prompthub/src/features/auth/domain/usecases/signup_user.dart';
// import 'package:prompthub/src/features/auth/domain/value_objects/email_address.dart';
// import 'package:prompthub/src/features/auth/domain/value_objects/name.dart';
// import 'package:prompthub/src/features/auth/domain/value_objects/password.dart';
// import 'package:prompthub/src/features/auth/presentation/bloc/signup/signup_event.dart';
// import 'package:prompthub/src/features/auth/presentation/bloc/signup/signup_state.dart';

// class SignupBloc extends Bloc<SignupEvent, SignupState> {
//   final SignupUser signupUser;

//   SignupBloc({required this.signupUser}) : super(SignupState()) {
//     on<SignupRequested>(onSignUp);
//     on<TogglePasswordVisibility>(onTogglePasswordVisibility);
//     on<PasswordChanged>(onPasswordChanged);
//     on<NameChanged>(onNameChanged);
//     on<EmailChanged>(onEmailChanged);
//   }

//   FutureOr<void> onTogglePasswordVisibility(
//     TogglePasswordVisibility event,
//     Emitter<SignupState> emit,
//   ) {
//     emit(state.copyWith(showPassword: !state.isPasswordVisible));
//   }

//   FutureOr<void> onPasswordChanged(
//     PasswordChanged event,
//     Emitter<SignupState> emit,
//   ) {
//     Password password = Password.create(input: event.value);
//     emit(state.copyWith(password: password, errorMessage: null));
//   }

//   FutureOr<void> onNameChanged(NameChanged event, Emitter<SignupState> emit) {
//     Name name = Name.create(input: event.value);
//     emit(state.copyWith(fullname: name, errorMessage: null));
//   }

//   FutureOr<void> onEmailChanged(EmailChanged event, Emitter<SignupState> emit) {
//     EmailAddress email = EmailAddress.create(input: event.value);
//     emit(state.copyWith(email: email, errorMessage: null));
//   }

//   FutureOr<void> onSignUp(
//     SignupRequested event,
//     Emitter<SignupState> emit,
//   ) async {
//     if (!state.canSubmit) {
//       return;
//     }

//     if (!state.isEmailValid || !state.isPasswordValid || !state.isNameValid) {
//       emit(state.copyWith(errorMessage: 'Please make sure form is valid'));
//       return;
//     }

//     emit(state.copyWith(isSubmitting: true));
//     final result = await signupUser(
//       name: event.name,
//       email: event.email,
//       password: event.password,
//     );

//     result.fold(
//       (failure) =>
//           emit(SignupState(isSubmitting: false, errorMessage: failure.message)),
//       (user) => emit(
//         SignupState(isSubmitting: false, user: user, errorMessage: null),
//       ),
//     );
//   }
// }
