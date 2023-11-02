import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'profile_model.g.dart';

@HiveType(typeId: 0)
class ProfileModel extends Equatable {
  const ProfileModel({
    required this.username,
    required this.password,
  });

  @HiveField(0)
  final String username;
  @HiveField(1)
  final String password;

  @override
  List<Object?> get props => [username, password];
}
