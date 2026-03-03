class AdvertisementApiResponse {
  final String status;
  final String message;
  final String id;

  AdvertisementApiResponse({
    required this.status,
    required this.message,
    required this.id,
  });

  // Factory constructor to create instance from JSON
  factory AdvertisementApiResponse.fromJson(Map<String, dynamic> json) {
    return AdvertisementApiResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      id: json['data']?['id']?.toString() ?? '',
    );
  }

  // Convert to Map (if needed for storage/serialization)
  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'id': id};
  }

  @override
  String toString() {
    return 'AdvertisementApiResponse(status: $status, message: $message, id: $id)';
  }
}
