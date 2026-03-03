import 'package:dallal_proj/core/entities/adv_card_entity/adv_card_entity.dart';
import 'package:dallal_proj/core/entities/media_entity/media_entity.dart';

class ShowDetailsEntity extends AdvCardEntity {
  final String advId;
  final String? pkgType;
  final String? pkgExpTime;
  final List<MediaEntity>? imgs;
  final String dateDet;
  final String titleDet;
  final String city;
  final String location;
  final String priceDet;
  final String sectionDet;
  final String area;
  final String offerType;
  final String? mapLink;
  final String? flrCount;
  final String? romCount;
  final String? halCount;
  final String? bthCount;
  final String? kchCount;
  final bool isNegot;
  final String likes;
  final bool isMineDet;
  final bool? status;
  final bool isLikedDet;
  final bool isFavedDet;
  final bool isPrem;
  final bool isPended;
  final String userId;
  final String? pfp;
  final String? extraDetails;
  final String fName;
  final String phoneNum;
  final String whatsNum;
  final String? linkToWhatsApp;
  final String? linkToPhone;
  final String? linkToSms;
  final String? refuseReason;

  ShowDetailsEntity({
    this.refuseReason,
    required this.likes,
    this.imgs,
    required this.userId,
    required this.fName,
    required this.phoneNum,
    required this.whatsNum,
    required this.advId,
    this.pkgType,
    this.pkgExpTime,
    required this.city,
    required this.offerType,
    this.mapLink,
    required this.isNegot,
    this.extraDetails,
    this.linkToWhatsApp,
    this.linkToPhone,
    this.linkToSms,
    required this.isMineDet,
    required this.dateDet,
    required this.area,
    this.flrCount,
    this.romCount,
    this.halCount,
    this.bthCount,
    this.kchCount,
    required this.sectionDet,
    this.status,
    required this.isLikedDet,
    required this.isFavedDet,
    required this.isPrem,
    this.pfp,
    required this.titleDet,
    required this.priceDet,
    required this.location,
    required this.isPended,
  }) : super(
         title: titleDet,
         img: (imgs != null) ? imgs.first.mediaUrl : null,
         isMine: isMineDet,
         isFaved: isFavedDet,
         isLiked: isLikedDet,
         isPremium: isPrem,
         adress: '$city - $location',
         advCardId: advId,
         advStatus: status,
         date: dateDet,
         likesCount: likes,
         price: priceDet,
         section: sectionDet,
       );
}
