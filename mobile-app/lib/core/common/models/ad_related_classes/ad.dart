class Ad {
  String id;
  String userId;
  String? adminId;
  String type;
  String offerType;
  String title;
  String? description;
  String city;
  String? locationText;
  String? googleMapUrl;
  // dynamic latitude;
  // dynamic longitude;
  String price;
  String currency;
  String negotiable;
  String area;
  String? extraDetails;
  String? rooms;
  String? livingRooms;
  String? bathrooms;
  String? kitchens;
  String? floors;
  String? status;
  String? rejectReason;
  String createdAt;
  String? updatedAt;

  Ad({
    required this.id,
    required this.userId,
    this.adminId,
    required this.type,
    required this.offerType,
    required this.title,
    this.description,
    required this.city,
    required this.locationText,
    this.googleMapUrl,
    // this.latitude,
    // this.longitude,
    required this.price,
    required this.currency,
    required this.negotiable,
    required this.area,
    this.extraDetails,
    this.rooms,
    this.livingRooms,
    this.bathrooms,
    this.kitchens,
    this.floors,
    this.status,
    this.rejectReason,
    required this.createdAt,
    this.updatedAt,
  });

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
    id: json['id'] as String,
    userId: json['user_id'] as String,
    adminId: json['admin_id'] as String?,
    type: json['type'] as String,
    offerType: json['offer_type'] as String,
    title: json['title'] as String,
    description: json['description'] as String?,
    city: json['city'] as String,
    locationText: json['location_text'] as String?,
    googleMapUrl: json['google_map_url'] as String?,
    // latitude: json['latitude'] as dynamic,
    // longitude: json['longitude'] as dynamic,
    price: json['price'] as String,
    currency: json['currency'] as String,
    negotiable: json['negotiable'] as String,
    area: json['area'] as String,
    extraDetails: json['extra_details'] as String?,
    rooms: json['rooms'] as String?,
    livingRooms: json['living_rooms'] as String?,
    bathrooms: json['bathrooms'] as String?,
    kitchens: json['kitchens'] as String?,
    floors: json['floors'] as String?,
    status: json['status'] as String?,
    rejectReason: json['reject_reason'] as String?,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'admin_id': adminId,
    'type': type,
    'offer_type': offerType,
    'title': title,
    'description': description,
    'city': city,
    'location_text': locationText,
    'google_map_url': googleMapUrl,
    // 'latitude': latitude,
    // 'longitude': longitude,
    'price': price,
    'currency': currency,
    'negotiable': negotiable,
    'area': area,
    'extra_details': extraDetails,
    'rooms': rooms,
    'living_rooms': livingRooms,
    'bathrooms': bathrooms,
    'kitchens': kitchens,
    'floors': floors,
    'status': status,
    'reject_reason': rejectReason,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
