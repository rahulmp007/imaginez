// lib/core/error/failure.dart

import 'package:equatable/equatable.dart';

/// Base class for all application-level errors
abstract class AppError extends Equatable {
  final String message;
  final int? code;
  final String? technicalMessage;

  const AppError({required this.message, this.code, this.technicalMessage});

  @override
  List<Object?> get props => [message, code, technicalMessage];

  @override
  bool? get stringify => true;
}

/// Represents no internet, DNS failure, or timeout
class NetworkError extends AppError {
  const NetworkError({
    required super.message,
    super.code,
    super.technicalMessage,
  });
}

/// Represents invalid server response or server-side exception
class ServerError extends AppError {
  const ServerError({
    required super.message,
    super.code,
    super.technicalMessage,
  });
}

/// Represents invalid user input or failed validation
class ValidationError extends AppError {
  const ValidationError({
    required super.message,
    super.code,
    super.technicalMessage,
  });
}

/// Represents authentication or authorization issues
class AuthError extends AppError {
  final String? authErrorCode;
  final bool shouldRetry;
  final bool requiresUserAction;
  const AuthError({
    required super.message,
    super.code,
    super.technicalMessage,
    this.authErrorCode,
    this.shouldRetry = false,
    this.requiresUserAction = false,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    authErrorCode,
    shouldRetry,
    requiresUserAction,
  ];
}

/// Represents local storage / cache / database failures
class CacheError extends AppError {
  const CacheError({
    required super.message,
    super.code,
    super.technicalMessage,
  });
}

/// Represents an unknown or unhandled error
class UnknownError extends AppError {
  const UnknownError({
    super.message = 'Something went wrong',
    super.code,
    super.technicalMessage,
  });
}
