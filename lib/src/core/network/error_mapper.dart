// lib/core/network/error_mapper.dart

import 'package:imaginez/src/core/error/failure.dart';
import 'package:imaginez/src/core/network/error_handler.dart';
import 'package:imaginez/src/core/network/response_code.dart';
import 'package:imaginez/src/core/network/response_message.dart';

extension ErrorMapper on ApiStatus {
  AppError toAppError({String? technicalMessage, StackTrace? stackTrace}) {
    switch (this) {
      case ApiStatus.SUCCESS:
      case ApiStatus.NO_CONTENT:
        return UnknownError(
          message: 'success',
          technicalMessage: technicalMessage,
        );

      case ApiStatus.BAD_REQUEST:
        return ValidationError(
          message: ResponseMessage.BAD_REQUEST,
          code: ResponseCode.BAD_REQUEST,
          technicalMessage: technicalMessage,
        );
      case ApiStatus.UN_PROCESSABLE_DATA:
        return ValidationError(
          message: ResponseMessage.UN_PROCESSABLE_DATA,
          code: ResponseCode.UN_PROCESSABLE_DATA,
          technicalMessage: technicalMessage,
        );

      case ApiStatus.FORBIDDEN:
        return AuthError(
          message: ResponseMessage.FORBIDDEN,
          code: ResponseCode.FORBIDDEN,
          technicalMessage: technicalMessage,

          requiresUserAction: true,
        );

      case ApiStatus.UNAUTHORISED:
        return AuthError(
          message: ResponseMessage.UNAUTHORISED,
          code: ResponseCode.UNAUTHORISED,
          technicalMessage: technicalMessage,

          shouldRetry: true,
          requiresUserAction: true,
        );

      case ApiStatus.NOT_FOUND:
        return ServerError(
          message: ResponseMessage.NOT_FOUND,
          code: ResponseCode.NOT_FOUND,
          technicalMessage: technicalMessage,
        );

      case ApiStatus.INTERNAL_SERVER_ERROR:
        return ServerError(
          message: ResponseMessage.INTERNAL_SERVER_ERROR,
          code: ResponseCode.INTERNAL_SERVER_ERROR,
          technicalMessage: technicalMessage,
        );
      case ApiStatus.BAD_GATEWAY:
        return ServerError(
          message: ResponseMessage.BAD_GATEWAY,
          code: ResponseCode.BAD_GATEWAY,
          technicalMessage: technicalMessage,
        );
      case ApiStatus.SERVICE_UNAVAILABLE:
        return ServerError(
          message: ResponseMessage.SERVICE_UNAVAILABLE,
          code: ResponseCode.SERVICE_UNAVAILABLE,
          technicalMessage: technicalMessage,
        );
      case ApiStatus.NOT_IMPLEMENTED:
        return ServerError(
          message: ResponseMessage.NOT_IMPLEMENTED,
          code: ResponseCode.NOT_IMPLEMENTED,
          technicalMessage: technicalMessage,
        );

      case ApiStatus.CONNECT_TIMEOUT:
        return NetworkError(
          message: ResponseMessage.CONNECT_TIMEOUT,
          code: ResponseCode.CONNECT_TIMEOUT,
          technicalMessage: technicalMessage,
        );
      case ApiStatus.RECEIVE_TIMEOUT:
        return NetworkError(
          message: ResponseMessage.RECEIVE_TIMEOUT,
          code: ResponseCode.RECEIVE_TIMEOUT,
          technicalMessage: technicalMessage,
        );
      case ApiStatus.SEND_TIMEOUT:
        return NetworkError(
          message: ResponseMessage.SEND_TIMEOUT,
          code: ResponseCode.SEND_TIMEOUT,
          technicalMessage: technicalMessage,
        );
      case ApiStatus.NO_INTERNET_CONNECTION:
        return NetworkError(
          message: ResponseMessage.NO_INTERNET_CONNECTION,
          code: ResponseCode.NO_INTERNET_CONNECTION,
          technicalMessage: technicalMessage,
        );

      case ApiStatus.CACHE_ERROR:
        return CacheError(
          message: ResponseMessage.CACHE_ERROR,
          code: ResponseCode.CACHE_ERROR,
          technicalMessage: technicalMessage,
        );

      case ApiStatus.CANCEL:
        return UnknownError(
          message: 'Request was cancelled',
          code: ResponseCode.CANCEL,
          technicalMessage: technicalMessage,
        );

      case ApiStatus.DEFAULT:
        return UnknownError(
          code: ResponseCode.DEFAULT,
          technicalMessage: technicalMessage,
        );
    }
  }
}
