// import 'dart:io';
// import 'package:dartz/dartz.dart';
// import 'package:flutterfeed/src/core/error/failure.dart';

// Future<Either<Failure, T>> call<T, R>(
//   Future<R> Function() action, {
//   required T Function(R data) mapper,
// }) async {
//   try {
//     final R data = await action();
//     final T result = mapper(data);
//     return Right(result);
//   } on SocketException {
//     return Left(NetworkError(message: 'No internet connected'));
//   } catch (e) {
//     return Left(UnexpectedFailure(message: 'Something went wrong!'));
//   }
// }
