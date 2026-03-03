import 'package:dallal_proj/core/common/models/ad_related_classes/ad.dart';
import 'package:dallal_proj/core/common/models/ad_related_classes/adv_owner.dart';
import 'package:dallal_proj/core/common/models/ad_related_classes/adv_statistics.dart';
import 'package:dallal_proj/core/common/models/ad_related_classes/featured_info.dart';
import 'package:dallal_proj/core/common/models/ad_related_classes/media.dart';
import 'package:dallal_proj/core/common/models/ad_related_classes/user_interaction.dart';
import 'package:dallal_proj/core/constants/app_defs.dart';
import 'package:dallal_proj/core/utils/functions/get_city_value.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';

class AdvData extends ShowDetailsEntity {
  Ad ad;
  AdvOwner owner;
  List<Media>? media;
  String? mainImage;
  bool? isFeatured;
  FeaturedInfo? featuredInfo;
  AdvStatistics? statistics;
  UserInteraction userInteraction;

  AdvData({
    required this.ad,
    required this.owner,
    this.media,
    this.mainImage,
    this.isFeatured,
    this.featuredInfo,
    this.statistics,
    required this.userInteraction,
  }) : super(
         area: ad.area,
         city: DictHelper.translate(kCTs, ad.city), //ad.city,
         fName: owner.name,
         isNegot: (ad.negotiable == '0') ? false : true,
         isPended: (ad.status == 'pending') ? true : false,
         offerType: DictHelper.translate(kOTs, ad.offerType), //ad.offerType,
         phoneNum: owner.phone,
         userId: owner.id,
         whatsNum: owner.whatsapp ?? owner.phone,
         bthCount: ad.bathrooms,
         extraDetails: ad.extraDetails,
         flrCount: ad.floors,
         halCount: ad.livingRooms,
         kchCount: ad.kitchens,
         linkToPhone: 'tel:967${owner.phone}',
         linkToSms: null,
         linkToWhatsApp: 'https://wa.me/${owner.whatsapp}',
         mapLink: ad.googleMapUrl,
         pfp: owner.profileImage,
         pkgExpTime: featuredInfo?.endDate,
         romCount: ad.rooms,
         pkgType: null,
         location: ad.locationText ?? '',
         advId: ad.id, //'${ad?.currency ?? 'YER'}',
         dateDet: ad.createdAt,
         imgs: media!.isNotEmpty ? media : null, // '$mainImage',
         isFavedDet: userInteraction.favorited,
         isLikedDet: userInteraction.liked,
         isMineDet: userInteraction.isOwner,
         isPrem: isFeatured ?? false,
         likes: statistics!.likesCount.toString(),
         priceDet: '${ad.currency} - ${ad.price}',
         sectionDet: DictHelper.translate(kPTs, ad.type), // ad.type,
         status:
             (ad.status == 'published')
                 ? true
                 : (ad.status == 'pending')
                 ? null
                 : false,
         titleDet: ad.title,
         refuseReason: ad.rejectReason,
       );

  // }):super(advId: ad.id,area: ad.area,city: ,dateDet: ,fName: ,isFavedDet: ,isLikedDet: ,isMineDet: ,isNegot: ,isPended: ,isPrem: ,likes: ,location: ,offerType: ,phoneNum: ,priceDet: ,sectionDet: ,titleDet: ,userId: ,whatsNum: ,bthCount: ,extraDetails: ,flrCount: ,halCount: ,imgs: ,kchCount: ,linkToPhone: ,linkToSms: ,linkToWhatsApp: ,mapLink: ,pfp: ,pkgExpTime: ,pkgType: ,romCount: ,status: ad.status,);

  factory AdvData.fromJson(Map<String, dynamic> json) => AdvData(
    ad: Ad.fromJson(json['ad'] as Map<String, dynamic>),

    // ad:
    //     json['ad'] == null
    //         ? null
    //         : Ad.fromJson(json['ad'] as Map<String, dynamic>),
    owner:
    // json['owner'] == null
    //     ? null
    //     : AdvOwner.fromJson(json['owner'] as Map<String, dynamic>),
    AdvOwner.fromJson(json['owner'] as Map<String, dynamic>),
    media:
        (json['media'] is List<dynamic>?)
            ? (json['media'] as List<dynamic>?)
                ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
                .toList()
            : <Media>[],
    // media: json['media'] as List<dynamic>?,
    mainImage: json['main_image'] as String?,
    isFeatured: json['is_featured'] as bool?,
    // featuredInfo: json['featured_info'] as dynamic,
    featuredInfo:
        (json['featured_info'] is Map<String, dynamic>)
            ? FeaturedInfo.fromJson(
              json['featured_info'] as Map<String, dynamic>,
            )
            : null,
    statistics:
        json['statistics'] == null
            ? null
            : AdvStatistics.fromJson(
              json['statistics'] as Map<String, dynamic>,
            ),
    userInteraction:
    // json['user_interaction'] == null
    //     ? null
    //     : UserInteraction.fromJson(
    //       json['user_interaction'] as Map<String, dynamic>,
    //     ),
    UserInteraction.fromJson(json['user_interaction'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'ad': ad.toJson(),
    'owner': owner.toJson(),
    'media': media,
    'main_image': mainImage,
    'is_featured': isFeatured,
    'featured_info': featuredInfo,
    'statistics': statistics?.toJson(),
    'user_interaction': userInteraction.toJson(),
  };
}

class AdvData2 extends ShowDetailsEntity {
  Ad ad;
  AdvOwner owner;
  List<Media>? media;
  String? mainImage;
  bool? isFeatured;
  FeaturedInfo? featuredInfo;
  AdvStatistics? statistics;
  UserInteraction userInteraction;

  AdvData2({
    required this.ad,
    required this.owner,
    this.media,
    this.mainImage,
    this.isFeatured,
    this.featuredInfo,
    this.statistics,
    required this.userInteraction,
  }) : super(
         area: ad.area,
         city: DictHelper.translate(kCTs, ad.city), //ad.city,
         fName: owner.name,
         isNegot: (ad.negotiable == '0') ? false : true,
         isPended: (ad.status == 'pending') ? true : false,
         offerType: DictHelper.translate(kOTs, ad.offerType), //ad.offerType,
         phoneNum: owner.phone,
         userId: owner.id,
         whatsNum: owner.whatsapp ?? owner.phone,
         bthCount: ad.bathrooms,
         extraDetails: ad.extraDetails,
         flrCount: ad.floors,
         halCount: ad.livingRooms,
         kchCount: ad.kitchens,
         linkToPhone: 'tel:967${owner.phone}',
         linkToSms: null,
         linkToWhatsApp: 'https://wa.me/${owner.whatsapp}',
         mapLink: ad.googleMapUrl,
         pfp: owner.profileImage,
         pkgExpTime: featuredInfo?.endDate,
         romCount: ad.rooms,
         pkgType: null,
         location: ad.locationText ?? '',
         advId: ad.id, //'${ad?.currency ?? 'YER'}',
         dateDet: ad.createdAt,
         imgs: media!.isNotEmpty ? media : null, // '$mainImage',
         isFavedDet: userInteraction.favorited,
         isLikedDet: userInteraction.liked,
         isMineDet: userInteraction.isOwner,
         isPrem: isFeatured ?? false,
         likes: statistics!.likesCount.toString(),
         priceDet: '${ad.currency} - ${ad.price}',
         sectionDet: DictHelper.translate(kPTs, ad.type), // ad.type,
         status:
             (ad.status == 'published')
                 ? true
                 : (ad.status == 'pending')
                 ? null
                 : false,
         titleDet: ad.title,
         refuseReason: ad.rejectReason,
       );

  // }):super(advId: ad.id,area: ad.area,city: ,dateDet: ,fName: ,isFavedDet: ,isLikedDet: ,isMineDet: ,isNegot: ,isPended: ,isPrem: ,likes: ,location: ,offerType: ,phoneNum: ,priceDet: ,sectionDet: ,titleDet: ,userId: ,whatsNum: ,bthCount: ,extraDetails: ,flrCount: ,halCount: ,imgs: ,kchCount: ,linkToPhone: ,linkToSms: ,linkToWhatsApp: ,mapLink: ,pfp: ,pkgExpTime: ,pkgType: ,romCount: ,status: ad.status,);

  factory AdvData2.fromJson(Map<String, dynamic> json) => AdvData2(
    ad: Ad.fromJson(json['ad'] as Map<String, dynamic>),

    // ad:
    //     json['ad'] == null
    //         ? null
    //         : Ad.fromJson(json['ad'] as Map<String, dynamic>),
    owner:
    // json['owner'] == null
    //     ? null
    //     : AdvOwner.fromJson(json['owner'] as Map<String, dynamic>),
    AdvOwner.fromJson(json['user'] as Map<String, dynamic>),
    media:
        (json['media'] is List<dynamic>?)
            ? (json['media'] as List<dynamic>?)
                ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
                .toList()
            : <Media>[],
    // media: json['media'] as List<dynamic>?,
    mainImage: json['main_image'] as String?,
    isFeatured: json['is_featured'] as bool?,
    // featuredInfo: json['featured_info'] as dynamic,
    featuredInfo:
        (json['featured_info'] is Map<String, dynamic>)
            ? FeaturedInfo.fromJson(
              json['featured_info'] as Map<String, dynamic>,
            )
            : null,
    statistics:
        json['statistics'] == null
            ? null
            : AdvStatistics.fromJson(
              json['statistics'] as Map<String, dynamic>,
            ),
    userInteraction:
    // json['user_interaction'] == null
    //     ? null
    //     : UserInteraction.fromJson(
    //       json['user_interaction'] as Map<String, dynamic>,
    //     ),
    UserInteraction.fromJson(json['user_interaction'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'ad': ad.toJson(),
    'owner': owner.toJson(),
    'media': media,
    'main_image': mainImage,
    'is_featured': isFeatured,
    'featured_info': featuredInfo,
    'statistics': statistics?.toJson(),
    'user_interaction': userInteraction.toJson(),
  };
}
