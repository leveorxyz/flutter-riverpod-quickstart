// ignore_for_file: cascade_invocations

import 'dart:convert';

import 'package:equatable/equatable.dart';

class SplashState extends Equatable {
  const SplashState({
    required this.isLoggedIn,
    required this.errorText,
  });

  factory SplashState.init() =>
      const SplashState(errorText: '', isLoggedIn: false);

  factory SplashState.fromMap(Map<String, dynamic> map) {
    return SplashState(
      isLoggedIn: (map['isLoggedIn'] ?? false) as bool,
      errorText: (map['errorText'] ?? '') as String,
    );
  }

  factory SplashState.fromJson(String source) =>
      SplashState.fromMap(json.decode(source) as Map<String, dynamic>);
  final bool isLoggedIn;
  final String errorText;

  @override
  List<Object> get props => [isLoggedIn, errorText];

  SplashState copyWith({
    bool? isLoggedIn,
    String? errorText,
  }) {
    return SplashState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      errorText: errorText ?? this.errorText,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result
      ..addAll({'isLoggedIn': isLoggedIn})
      ..addAll({'errorText': errorText});

    return result;
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'SplashState(isLoggedIn: $isLoggedIn, errorText: $errorText)';
}
