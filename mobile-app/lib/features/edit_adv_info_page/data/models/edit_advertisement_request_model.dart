import 'package:dallal_proj/core/constants/app_defs.dart';
import 'package:dallal_proj/core/utils/functions/get_city_value.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';

class EditAdvertisementRequestModel {
  final ShowDetailsEntity currentDetails;
  final String userToken;
  final String advertisementId;
  final String? title;
  final String? offerType;
  final String? city;
  final String? type;
  final String? locationText;
  final String? price;
  final String? currency;
  final dynamic negotiable;
  final String? area;
  final String? googleMapUrl;
  final String? extraDetails;
  final String? rooms;
  final String? livingRooms;
  final String? bathrooms;
  final String? kitchens;
  final int? floors;
  final double? latitude;
  final double? longitude;

  EditAdvertisementRequestModel({
    required this.currentDetails,
    required this.userToken,
    required this.advertisementId,
    this.title,
    this.offerType,
    this.city,
    this.type,
    this.locationText,
    this.price,
    this.currency,
    this.negotiable,
    this.area,
    this.googleMapUrl,
    this.extraDetails,
    this.rooms,
    this.livingRooms,
    this.bathrooms,
    this.kitchens,
    this.floors,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = advertisementId;

    if (title != null && title!.isNotEmpty) {
      data['title'] = title;
    }

    if (offerType != null && offerType!.isNotEmpty) {
      data['offer_type'] = offerType;
    }

    if (city != null && city!.isNotEmpty) {
      data['city'] = DictHelper.translate(kOTsRev, city!);
    }

    if (type != null && type!.isNotEmpty) {
      data['type'] = type;
    }

    if (locationText != null && locationText!.isNotEmpty) {
      data['location_text'] = locationText;
    }

    if (price != null && price!.isNotEmpty) {
      data['price'] = price; // MATCH: 'price'
    }

    if (currency != null && currency!.isNotEmpty) {
      data['currency'] = currency;
    }

    if (negotiable != null) {
      if (negotiable is bool) {
        data['negotiable'] = negotiable! ? '1' : '0';
      }
      if (negotiable is String && negotiable != '') {
        if (negotiable == 'نعم') {
          data['negotiable'] = '1';
        } else if (negotiable == 'لا') {
          data['negotiable'] = '0';
        } else {
          data['negotiable'] = negotiable;
        }
      }
    }

    if (area != null && area!.isNotEmpty) {
      data['area'] = area;
    }

    if (googleMapUrl != null) {
      data['google_map_url'] =
          googleMapUrl!.isNotEmpty
              ? googleMapUrl
              : 'https://www.base64-image.de/';
    } else {
      data['google_map_url'] = 'https://www.base64-image.de/';
    }

    if (extraDetails != null && extraDetails!.isNotEmpty) {
      data['extra_details'] = extraDetails;
    }

    if (rooms != null && rooms!.isNotEmpty) {
      data['rooms'] = rooms;
    }

    if (livingRooms != null && livingRooms!.isNotEmpty) {
      data['living_rooms'] = livingRooms;
    }

    if (bathrooms != null && bathrooms!.isNotEmpty) {
      data['bathrooms'] = bathrooms;
    }

    if (kitchens != null && kitchens!.isNotEmpty) {
      data['kitchens'] = kitchens;
    }

    if (floors != null) {
      data['floors'] = floors.toString();
    }

    if (latitude != null && longitude != null) {
      data['latitude'] = latitude.toString();
      data['longitude'] = longitude.toString();
    }

    return data;
  }
}
