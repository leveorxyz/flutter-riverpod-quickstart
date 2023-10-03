import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';

class ApiFailure extends Equatable {
  final ErrorResponse error;
  final int statusCode;
  final Response? response;
  const ApiFailure({
    required this.error,
    required this.statusCode,
    this.response,
  });
  ApiFailure copyWith({
    ErrorResponse? error,
    int? statusCode,
    Response? response,
  }) {
    return ApiFailure(
      error: error ?? this.error,
      statusCode: statusCode ?? this.statusCode,
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [error, statusCode, response];
}
