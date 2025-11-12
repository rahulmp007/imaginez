import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:imaginez/src/core/error/value_failure.dart';

class Name extends Equatable {
  final Either<ValueFailure<String>, String> value;

  const Name._(this.value);

  static Name create({required String input}) {
    final trimmed = input.trim();
    if (trimmed.isEmpty || trimmed.length < 2) {
      return Name._(left(InvalidName(failedValue: trimmed)));
    }
    return Name._(right(trimmed));
  }

  bool get isValid => value.isRight();

  @override
  List<Object?> get props => [value];
}
