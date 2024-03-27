import 'package:hive/hive.dart';

part 'user_credentials.g.dart';

@HiveType(typeId: 0)
class UserCredentials {
  @HiveField(0)
  String? email;

  @HiveField(1)
  String? password;

  @HiveField(2)
  String? username;

  @HiveField(3)
  String? name;

  @HiveField(4)
  String? phoneNumber;

  @HiveField(5)
  String? imagePath;

  UserCredentials({
    required this.email,
    required this.password,
    required this.username,
    required this.name,
    required this.phoneNumber,
    this.imagePath
  });
}
