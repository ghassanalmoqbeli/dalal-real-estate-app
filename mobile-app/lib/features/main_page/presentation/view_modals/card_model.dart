class CardModel {
  final String title, location, propertyType, price, img;
  final String? likes;
  final DateTime? date;

  const CardModel({
    required this.title,
    required this.location,
    required this.propertyType,
    required this.price,
    required this.img,
    required this.likes,
    required this.date,
  });
}
