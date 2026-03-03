// Add this to your models or create a new file
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/features/sections_page/data/models/filter_req_model.dart';

class FilterSheetValues {
  String? searchQuery;
  List<String> propertyTypes;
  List<String> offerTypes;
  String? city;
  num? minPrice;
  num? maxPrice;
  String? currency;
  num? minArea;
  num? maxArea;
  String? sortBy;
  int? featuredOnly;

  FilterSheetValues({
    this.searchQuery,
    List<String>? propertyTypes,
    List<String>? offerTypes,
    this.city,
    this.minPrice,
    this.maxPrice,
    this.currency,
    this.minArea,
    this.maxArea,
    this.sortBy,
    this.featuredOnly = 0,
  }) : propertyTypes = propertyTypes ?? [],
       offerTypes = offerTypes ?? [];

  // Map Arabic sort options to API values
  static const Map<String, String> _sortByToApiMap = {
    kLowestPriceOPtion: 'price_asc',
    kHighestPriceOPtion: 'price_desc',
    kOldestOPtion: 'oldest',
    kNewestOPtion: 'newest',
  };

  // Map API values back to Arabic for display
  static const Map<String, String> _apiToSortByMap = {
    'price_asc': kLowestPriceOPtion,
    'price_desc': kHighestPriceOPtion,
    'oldest': kOldestOPtion,
    'newest': kNewestOPtion,
  };

  // Convert Arabic sortBy to API value
  String? get sortByApiValue {
    if (sortBy == null) return null;
    return _sortByToApiMap[sortBy] ?? sortBy;
  }

  // Convert API sortBy to Arabic display value
  static String? apiToDisplaySortBy(String? apiValue) {
    if (apiValue == null) return null;
    return _apiToSortByMap[apiValue] ?? apiValue;
  }

  // Convert to FilterReqModel
  FilterReqModel toFilterReqModel({String? token}) {
    return FilterReqModel(
      q: searchQuery,
      propertyType: propertyTypes.isNotEmpty ? propertyTypes : null,
      offerType: offerTypes.isNotEmpty ? offerTypes : null,
      city: city,
      minPrice: minPrice,
      maxPrice: maxPrice,
      currency: currency,
      minArea: minArea,
      maxArea: maxArea,
      sortBy: sortByApiValue, // Use API value instead of Arabic
      featuredOnly: featuredOnly,
      token: token,
    );
  }

  // Reset all values
  void reset() {
    searchQuery = null;
    propertyTypes = [];
    offerTypes = [];
    city = null;
    minPrice = null;
    maxPrice = null;
    currency = null;
    minArea = null;
    maxArea = null;
    sortBy = null;
    featuredOnly = 0;
  }
}
