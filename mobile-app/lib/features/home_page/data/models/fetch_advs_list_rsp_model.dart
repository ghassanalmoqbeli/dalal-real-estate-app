import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';

class FetchAdvsListRspModel extends RspAuth {
  String? fetchStatus, fetchMessage;
  List<ShowDetailsEntity>? advList;

  FetchAdvsListRspModel({this.fetchStatus, this.fetchMessage, this.advList})
    : super(status: fetchStatus, message: fetchMessage);

  // factory FetchAdvsListRspModel.fromJson(Map<String, dynamic> json) => LoginRspModel(
  //   logStatus: json['status'] as String?,
  //   logMessage: json['message'] as String?,
  //   userData:
  //       json['data'] is Map<String, dynamic>
  //           ? UserData.fromJson(json['data'])
  //           : null,
  //   verified: json['need_verification'] as bool?,
  // );

  // Map<String, dynamic> toJson() => {'phone': phone, 'password': password};
}
