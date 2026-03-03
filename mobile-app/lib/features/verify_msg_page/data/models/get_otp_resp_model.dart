import 'package:dallal_proj/core/utils/rsp_auth.dart';

class GetOtpRespModel extends RspAuth {
  String? otpStatus, otpMessage, otpCode;

  GetOtpRespModel({this.otpStatus, this.otpMessage, this.otpCode})
    : super(status: otpStatus, message: otpMessage);

  factory GetOtpRespModel.fromJson(Map<String, dynamic> json) =>
      GetOtpRespModel(
        otpStatus: json['status'] as String?,
        otpMessage: json['message'] as String?,
        otpCode: json['debug_otp'] as String?,
      );
}
