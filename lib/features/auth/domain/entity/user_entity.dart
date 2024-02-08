import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.userId,
    required this.name,
    required this.token,
  });

  const UserEntity.empty() : this(userId: '1', name: '', token: '');

  final String userId;
  final String name;
  final String token;

  @override
  List<String?> get props => [userId];
}
