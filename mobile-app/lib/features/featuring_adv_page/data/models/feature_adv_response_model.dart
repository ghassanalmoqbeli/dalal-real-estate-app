import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:intl/intl.dart';

class PackageActivationResponse {
  final String status;
  final String? message;
  final PackageActivationData data;

  PackageActivationResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PackageActivationResponse.fromJson(Map<String, dynamic> json) {
    return PackageActivationResponse(
      status: json['status'] as String,
      message: json['message'] as String?,
      data: PackageActivationData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data.toJson()};
  }
}

class PackageActivationData extends PckgInfModel {
  final String featuredId;
  final String adId;
  final String packageId;
  final DateTime startedDate;

  PackageActivationData({
    required this.featuredId,
    required this.adId,
    required this.packageId,
    required this.startedDate,
  }) : super(type: _getPackageType(packageId), startDate: startedDate);

  factory PackageActivationData.fromJson(Map<String, dynamic> json) {
    return PackageActivationData(
      featuredId: json['featured_id'] as String,
      adId: json['ad_id'] as String,
      packageId: json['package_id'] as String,
      startedDate: WidH.str2date(json['start_date']),
    );
  }

  Map<String, dynamic> toJson() {
    final dateFormat = DateFormat('yyyy-MM-dd');
    return {
      'featured_id': featuredId,
      'ad_id': adId,
      'package_id': packageId,
      'start_date': dateFormat.format(startDate),
      'end_date': dateFormat.format(endDate),
    };
  }

  static PackageType _getPackageType(String packageId) {
    switch (packageId) {
      case '24':
        return PackageType.fund;
      case '25':
        return PackageType.special;
      case '26':
        return PackageType.golden;
      default:
        return PackageType.fund;
    }
  }
}
