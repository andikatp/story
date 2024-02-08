import 'package:story/core/utils/typedef.dart';
import 'package:story/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.userId,
    required super.name,
    required super.token,
  });

  const UserModel.empty() : super.empty();

  factory UserModel.fromJson(ResultMap json) {
    return UserModel(
      userId: json['userId'] as String,
      name: json['name'] as String,
      token: json['token'] as String,
    );
  }

  ResultMap toJson() => {
        'userId': userId,
        'name': name,
        'token': token,
      };
}
