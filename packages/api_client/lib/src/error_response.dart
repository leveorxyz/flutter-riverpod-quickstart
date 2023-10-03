class ErrorResponse {
  String? message;
  String? errors;

  ErrorResponse({
    this.errors,
    this.message,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      errors: json["errors"],
      message: json["message"],
    );
  }
}
