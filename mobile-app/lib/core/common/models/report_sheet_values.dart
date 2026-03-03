import 'package:dallal_proj/features/details_page/data/models/report_req_model.dart';

class ReportSheetValues {
  String adID;
  String reason;
  String? description;

  ReportSheetValues({
    required this.adID,
    required this.reason,
    this.description,
  });

  ReportReqModel toReportReqModel(String token) {
    return ReportReqModel(
      adID: adID,
      reason: reason,
      description: description,
      token: token,
    );
  }

  // Reset all values
  // void reset() {
  //   searchQuery = null;
  //   propertyTypes.clear();
  //   offerTypes.clear();
  //   city = null;
  //   minPrice = null;
  //   maxPrice = null;
  //   currency = null;
  //   minArea = null;
  //   maxArea = null;
  //   sortBy = null;
  //   featuredOnly = 0;
  // }
}
