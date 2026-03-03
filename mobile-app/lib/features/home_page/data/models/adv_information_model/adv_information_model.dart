import 'package:dallal_proj/core/common/models/ad_related_classes/adv_owner.dart';
import 'package:dallal_proj/core/constants/app_defs.dart';
import 'package:dallal_proj/core/utils/functions/get_city_value.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';

import '../../../../../core/common/models/ad_related_classes/ad.dart';
import '../../../../../core/common/models/ad_related_classes/featured_info.dart';
import '../../../../../core/common/models/ad_related_classes/media.dart';
import '../../../../../core/common/models/ad_related_classes/adv_statistics.dart';
import '../../../../../core/common/models/ad_related_classes/user_interaction.dart';

class AdvInformationModel extends ShowDetailsEntity {
  Ad ad;
  AdvOwner advUser;
  List<Media>? media;
  String? mainImage;
  bool? isFeatured;
  FeaturedInfo? featuredInfo;
  AdvStatistics? statistics;
  UserInteraction userInteraction;

  AdvInformationModel({
    required this.ad,
    required this.advUser,
    this.media,
    this.mainImage,
    this.isFeatured,
    this.featuredInfo,
    required this.statistics,
    required this.userInteraction,
  }) : super(
         area: ad.area,
         city: DictHelper.translate(kCTs, ad.city), //getCityValue(ad.city),
         fName: advUser.name,
         isNegot: (ad.negotiable == '0') ? false : true,
         isPended: (ad.status == 'pending') ? true : false,
         offerType: DictHelper.translate(kOTs, ad.offerType),
         phoneNum: advUser.phone,
         userId: advUser.id,
         whatsNum: advUser.whatsapp ?? advUser.phone,
         bthCount: ad.bathrooms,
         extraDetails: ad.extraDetails,
         flrCount: ad.floors,
         halCount: ad.livingRooms,
         kchCount: ad.kitchens,
         linkToPhone: 'tel:967${advUser.phone}',
         linkToSms: null,
         linkToWhatsApp: 'https://wa.me/967${advUser.whatsapp}',
         mapLink: ad.googleMapUrl,
         pfp: advUser.profileImage,
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
         sectionDet: DictHelper.translate(kPTs, ad.type),
         status:
             (ad.status == 'published')
                 ? true
                 : (ad.status == 'pending')
                 ? null
                 : false,
         titleDet: ad.title,
       );

  factory AdvInformationModel.fromJson(Map<String, dynamic> json) {
    return AdvInformationModel(
      ad: Ad.fromJson(json['ad'] as Map<String, dynamic>),
      // (json['ad'] is Map<String, dynamic>)
      //     ? Ad.fromJson(json['ad'])
      //     : null,
      // json['ad'] == null
      //     ? null
      //     : Ad.fromJson(json['ad'] as Map<String, dynamic>),
      advUser: AdvOwner.fromJson(json['owner'] as Map<String, dynamic>),
      // (json['user'] is Map<String, dynamic>?)
      //     ? User.fromJson(json['user'])
      //     : null,
      // json['user'] == null
      //     ? null
      //     : User.fromJson(json['user'] as Map<String, dynamic>),
      media:
          (json['media'] is List<dynamic>?)
              ? (json['media'] as List<dynamic>?)
                  ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
                  .toList()
              : <Media>[],
      mainImage: null, //json['main_image'] as String?,
      isFeatured: (json['is_featured'] as bool?) ?? false,
      featuredInfo:
          (json['featured_info'] is Map<String, dynamic>)
              ? FeaturedInfo.fromJson(
                json['featured_info'] as Map<String, dynamic>,
              )
              : null,
      // json['featured_info'] == null
      //     ? null
      //     : FeaturedInfo.fromJson(
      //       json['featured_info'] as Map<String, dynamic>,
      //     ),
      statistics: //json['statistics'],
          (json['statistics'] is Map<String, dynamic>?)
              ? AdvStatistics.fromJson(
                json['statistics'] as Map<String, dynamic>,
              )
              : null,
      // json['statistics'] == null
      //     ? null
      //     : Statistics.fromJson(json['statistics'] as Map<String, dynamic>),
      userInteraction: UserInteraction.fromJson(
        json['user_interaction'] as Map<String, dynamic>,
      ),
      // (json['user_interaction'] is Map<String, dynamic>?)
      //     ? UserInteraction.fromJson(json['user_interaction'])
      //     : null,
      // json['user_interaction'] == null
      //     ? null
      //     : UserInteraction.fromJson(
      //       json['user_interaction'] as Map<String, dynamic>,
      //     ),
    );
  }

  Map<String, dynamic> toJson() => {
    'ad': ad.toJson(),
    'user': advUser.toJson(),
    'media': media?.map((e) => e.toJson()).toList(),
    'main_image': mainImage,
    'is_featured': isFeatured,
    'featured_info': featuredInfo?.toJson(),
    'statistics': statistics?.toJson(),
    'user_interaction': userInteraction.toJson(),
  };
}
