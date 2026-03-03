import 'package:hive/hive.dart';

part 'loggedin_user_entity.g.dart';

@HiveType(typeId: 0)
class LoggedinUserEntity {
  @HiveField(0)
  final String? uToken;
  @HiveField(1)
  final String? uId;
  @HiveField(2)
  final String? uName;
  @HiveField(3)
  final String? uPhone;
  @HiveField(4)
  final String? uWhatsapp;
  @HiveField(5)
  final String? uProfileImage;
  LoggedinUserEntity({
    this.uToken,
    this.uId,
    this.uName,
    this.uPhone,
    this.uWhatsapp,
    this.uProfileImage,
  });
}
