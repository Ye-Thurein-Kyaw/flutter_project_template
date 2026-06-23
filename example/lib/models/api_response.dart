enum HttpStatusCode {
  success(200),
  badRequest(400),
  unauthorized(401),
  forbidden(403),
  notFound(404),
  requestTimeout(408),
  unprocessableEntity(422),
  internalServerError(500),
  badGateway(502),
  serviceUnavailable(503),
  networkError(0), // No internet or connectivity issue
  unknownError(-1); // Unknown error

  final int code;
  const HttpStatusCode(this.code);

  // Convert from status code to ApiStatus
  static HttpStatusCode fromCode(int code) {
    return HttpStatusCode.values.firstWhere(
          (status) => status.code == code,
      orElse: () => HttpStatusCode.unknownError,
    );
  }
}

class ApiResponse {
  final dynamic data;
  final HttpStatusCode statusCode;
  final String message;

  ApiResponse({required this.statusCode,  this.message = '', this.data});
}