import 'package:hive/hive.dart';

part 'adv_card_entity.g.dart';

@HiveType(typeId: 1)
class AdvCardEntity {
  @HiveField(0)
  final String? img;
  @HiveField(1)
  final String? advCardId;
  @HiveField(2)
  final String? date;
  @HiveField(3)
  final String? title;
  @HiveField(4)
  final String? adress;
  @HiveField(5)
  final String? section;
  @HiveField(6)
  final bool? advStatus;
  @HiveField(7)
  final String? price;
  @HiveField(8)
  final String? likesCount;
  @HiveField(9)
  final bool isPremium;
  @HiveField(10)
  final bool isMine;
  @HiveField(11)
  final bool isLiked;
  @HiveField(12)
  final bool isFaved;
  // final bool? state;
  AdvCardEntity({
    required this.isMine,
    required this.isLiked,
    required this.isFaved,
    this.advStatus,
    this.advCardId,
    this.img,
    this.date,
    this.title,
    this.adress,
    this.section,
    this.price,
    this.likesCount,
    required this.isPremium,
  });
}
