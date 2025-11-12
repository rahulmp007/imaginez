import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:imaginez/src/core/error/value_failure.dart';

class EmailAddress extends Equatable {
  final Either<ValueFailure<String>, String> value;

  const EmailAddress._(this.value);

  static EmailAddress create({required String input}) {
    final trimmed = input.trim();
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (input.isEmpty) {
      return EmailAddress._(left(Empty(failedValue: input)));
    } else if (emailRegex.hasMatch(trimmed)) {
      return EmailAddress._(right(trimmed));
    } else {
      return EmailAddress._(left(InvalidEmail(failedValue: trimmed)));
    }
  }

  bool get isValid => value.isRight();

  @override
  List<Object?> get props => [value];
}
