enum ApiErrorCode {
  mustValidEmail,
  emailAlreadyTaken,
  userNotFound,
  invalidPassword,
  errorNetwork,
  unknown,
}

class ApiException implements Exception {
  final ApiErrorCode code;
  final int? statusCode;

  ApiException(this.code, {this.statusCode});
}
