class AdvertisementRequestModel {
  final String userToken;
  final List<String> imagesBase64;
  final String title;
  final String offerType;
  final String city;
  final String type;
  final String locationText;
  final String price;
  final String currency;
  final bool negotiable;
  final String area;
  final String? googleMapUrl;
  final String? extraDetails;
  final String? rooms;
  final String? livingRooms;
  final String? bathrooms;
  final String? kitchens;
  final int? floors;
  final double? latitude;
  final double? longitude;

  AdvertisementRequestModel({
    required this.userToken,
    required this.imagesBase64,
    required this.title,
    required this.offerType,
    required this.city,
    required this.type,
    required this.locationText,
    required this.price,
    required this.currency,
    required this.negotiable,
    required this.area,
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

  // Separate method to convert images to JSON
  Map<String, dynamic> toJsonImages() {
    return {'images': imagesBase64};
  }

  // Main toJson method for the entire request
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    // Always include these fields
    data['type'] = type;
    data['offer_type'] = offerType;
    data['city'] = city;
    data['title'] = title;
    data['location_text'] = locationText;
    data['price'] = price;
    data['currency'] = currency;
    data['negotiable'] = negotiable ? '1' : '0';
    data['area'] = area;

    // Optional fields (only include if not null)
    if (googleMapUrl != null && googleMapUrl!.isNotEmpty) {
      data['google_map_url'] = googleMapUrl;
    } else {
      data['google_map_url'] = 'https://www.base64-image.de/';
    }

    if (extraDetails != null && extraDetails!.isNotEmpty) {
      data['extra_details'] = extraDetails;
    }

    if (rooms != null) {
      data['rooms'] = rooms.toString();
    }

    if (livingRooms != null) {
      data['living_rooms'] = livingRooms.toString();
    }

    if (bathrooms != null) {
      data['bathrooms'] = bathrooms.toString();
    }

    if (kitchens != null) {
      data['kitchens'] = kitchens.toString();
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

  // Helper method to parse the parts string (rooms, bathrooms, etc.)
  static Map<String, int?> parsePartsString(String partsString) {
    if (partsString.length != 4) {
      return {
        'rooms': null,
        'living_rooms': null,
        'bathrooms': null,
        'kitchens': null,
      };
    }

    return {
      'rooms': int.tryParse(partsString[0]),
      'living_rooms': int.tryParse(partsString[1]),
      'bathrooms': int.tryParse(partsString[2]),
      'kitchens': int.tryParse(partsString[3]),
    };
  }
}
