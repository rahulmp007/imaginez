class ResponseMessage {
  static const String SUCCESS = 'Success';
  static const String NO_CONTENT = 'No content available';
  static const String BAD_REQUEST = 'Bad request, please try again';
  static const String FORBIDDEN = 'Forbidden request';
  static const String UNAUTHORISED = 'Unauthorized access';
  static const String NOT_FOUND = 'Requested resource not found';
  static const String INTERNAL_SERVER_ERROR = 'Server error, please try later';
  static const String CONNECT_TIMEOUT =
      'Connection timed out. Please try again.';
  static const String CANCEL = 'Request was cancelled';
  static const String RECEIVE_TIMEOUT = 'Server took too long to respond.';
  static const String SEND_TIMEOUT = 'Request timed out while sending data.';
  static const String CACHE_ERROR = 'Cache error occurred';
  static const String NO_INTERNET_CONNECTION = 'No internet connection';
  static const String UN_PROCESSABLE_DATA = 'Invalid data format';
  static const String NOT_IMPLEMENTED = 'Feature not implemented';
  static const String BAD_GATEWAY = 'Bad gateway';
  static const String SERVICE_UNAVAILABLE = 'Service currently unavailable';
  static const String DEFAULT = 'Something went wrong';
}
