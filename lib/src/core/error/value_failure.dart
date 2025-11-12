import 'package:equatable/equatable.dart';

abstract class ValueFailure<T> extends Equatable {
  final T failedValue;
  const ValueFailure({required this.failedValue});

  @override
  List<Object?> get props => [failedValue];
}

class Empty<T> extends ValueFailure<T> {
  const Empty({required super.failedValue});
}

class InvalidEmail<T> extends ValueFailure<T> {
  const InvalidEmail({required super.failedValue});
}

class ShortPassword<T> extends ValueFailure<T> {
  const ShortPassword({required super.failedValue});
}

class MissingNumber<T> extends ValueFailure<T> {
  const MissingNumber({required super.failedValue});
}

class InvalidName<T> extends ValueFailure<T> {
  const InvalidName({required super.failedValue});
}
