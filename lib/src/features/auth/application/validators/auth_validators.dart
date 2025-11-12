import 'package:imaginez/src/core/error/value_failure.dart';
import 'package:imaginez/src/features/auth/domain/value_objects/password.dart';
import 'package:imaginez/src/features/auth/domain/value_objects/email_address.dart';
import 'package:imaginez/src/features/auth/domain/value_objects/name.dart';

String? mapPasswordError(Password? password) => password?.value.fold((failure) {
    if (failure is Empty) return 'Password is required';
    if (failure is ShortPassword) {
      return 'Password must be at least 6 characters';
    }
    if (failure is MissingNumber) {
      return 'Password must contain a number';
    }
    return 'Invalid password';
  }, (_) => null);

String? mapEmailError(EmailAddress? email) => email?.value.fold((failure) => 'Invalid email format', (_) => null);

String? mapNameError(Name? name) => name?.value.fold(
    (failure) => 'Name must be at least 2 characters',
    (_) => null,
  );
