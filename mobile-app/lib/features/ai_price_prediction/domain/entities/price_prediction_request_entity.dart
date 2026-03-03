/// Entity representing a request to predict property price.
class PricePredictionRequestEntity {
  final String city;
  final String areaName;
  final String propertyType;
  final String dealType;
  final int areaM2;
  final int rooms;
  final int baths;
  final int floors;

  const PricePredictionRequestEntity({
    required this.city,
    required this.areaName,
    required this.propertyType,
    required this.dealType,
    required this.areaM2,
    required this.rooms,
    required this.baths,
    required this.floors,
  });
}
