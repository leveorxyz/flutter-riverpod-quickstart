import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:riverpod_ddd/features/login_page/domain/user_profile_model.dart';

class LoginState extends Equatable {
  LoginState({
    required this.isLoading,
    required this.userProfileModel,
  });
  factory LoginState.fromMap(Map<String, dynamic> map) {
    return LoginState(
      isLoading: (map['isLoading'] ?? false) as bool,
      userProfileModel: UserProfileModel.fromMap(
        map['userProfileModel'] as Map<String, dynamic>,
      ),
    );
  }

  factory LoginState.fromJson(String source) =>
      LoginState.fromMap(json.decode(source) as Map<String, dynamic>);

  factory LoginState.init() => LoginState(
        isLoading: false,
        userProfileModel: UserProfileModel.init(),
      );

  final bool isLoading;
  final UserProfileModel? userProfileModel;

  @override
  List<Object?> get props => [isLoading, userProfileModel];

  LoginState copyWith({
    bool? isLoading,
    UserProfileModel? userProfileModel,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      userProfileModel: userProfileModel ?? this.userProfileModel,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{}
      ..addAll({'isLoading': isLoading})
      ..addAll({'userProfileModel': userProfileModel?.toMap()});

    return result;
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'LoginState(isLoading: $isLoading, userProfileModel: $userProfileModel)';
}
