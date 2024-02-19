import 'package:json_annotation/json_annotation.dart';
import 'package:story/features/auth/domain/entity/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  const UserModel({
    required super.userId,
    required super.name,
    required super.token,
  });

  const UserModel.empty() : super.empty();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
