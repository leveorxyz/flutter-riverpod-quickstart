// ignore_for_file: cascade_invocations

import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserProfileModel extends Equatable {
  const UserProfileModel({
    required this.userName,
    required this.accesToken,
    required this.refreshToken,
  });
  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      userName: (map['userName'] ?? '') as String,
      accesToken: (map['accesToken'] ?? '') as String,
      refreshToken: (map['refreshToken'] ?? '') as String,
    );
  }
  factory UserProfileModel.init() => const UserProfileModel(
        accesToken: '',
        refreshToken: '',
        userName: '',
      );
  factory UserProfileModel.fromJson(String source) =>
      UserProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);
  final String userName;
  final String accesToken;
  final String refreshToken;

  @override
  List<Object> get props => [userName, accesToken, refreshToken];

  UserProfileModel copyWith({
    String? userName,
    String? accesToken,
    String? refreshToken,
  }) {
    return UserProfileModel(
      userName: userName ?? this.userName,
      accesToken: accesToken ?? this.accesToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userName': userName});
    result.addAll({'accesToken': accesToken});
    result.addAll({'refreshToken': refreshToken});

    return result;
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'UserProfileModel(userName: $userName, accesToken: $accesToken, refreshToken: $refreshToken)';
}
