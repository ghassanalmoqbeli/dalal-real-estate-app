class Query {
  String? search;
  List<String>? propertyType;
  List<dynamic>? offerType;
  dynamic city;
  int? minPrice;
  dynamic maxPrice;
  dynamic currency;
  dynamic minArea;
  dynamic maxArea;
  String? sortBy;
  dynamic featuredOnly;

  Query({
    this.search,
    this.propertyType,
    this.offerType,
    this.city,
    this.minPrice,
    this.maxPrice,
    this.currency,
    this.minArea,
    this.maxArea,
    this.sortBy,
    this.featuredOnly,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
    search: json['search'] as String?,
    propertyType:
        (json['property_type'] is List<dynamic>)
            ? List<String>.from(
              (json['property_type'] as List<dynamic>).map(
                (e) => e?.toString() ?? '',
              ),
            )
            : <String>[],
    // propertyType:
    //     (json['property_type'] is List<dynamic>?)
    //         ? (json['property_type'] as List<dynamic>?)
    //             ?.map((e) => e.toString())
    //             .toList()
    //         : <String>[], // json['property_type'] as List<String>?,
    offerType: json['offer_type'] as List<dynamic>?,
    city: json['city'] as dynamic,
    minPrice: json['min_price'] as int?,
    maxPrice: json['max_price'] as dynamic,
    currency: json['currency'] as dynamic,
    minArea: json['min_area'] as dynamic,
    maxArea: json['max_area'] as dynamic,
    sortBy: json['sort_by'] as String?,
    featuredOnly: json['featured_only'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'search': search,
    'property_type': propertyType,
    'offer_type': offerType,
    'city': city,
    'min_price': minPrice,
    'max_price': maxPrice,
    'currency': currency,
    'min_area': minArea,
    'max_area': maxArea,
    'sort_by': sortBy,
    'featured_only': featuredOnly,
  };
}
