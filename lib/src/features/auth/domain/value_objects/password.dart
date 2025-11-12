import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:imaginez/src/core/error/value_failure.dart';

class Password extends Equatable {
  final Either<ValueFailure<String>, String> value;

  const Password._(this.value);

  static Password create({required String input}) {
    if (input.isEmpty) {
      return Password._(left(Empty(failedValue: input)));
    }
    if (input.length < 6) {
      return Password._(left(ShortPassword(failedValue: input)));
    }
    if (!RegExp(r'\d').hasMatch(input)) {
      return Password._(left(MissingNumber(failedValue: input)));
    }
    return Password._(right(input));
  }

  bool get isValid => value.isRight();

  @override
  List<Object?> get props => [value];
}
