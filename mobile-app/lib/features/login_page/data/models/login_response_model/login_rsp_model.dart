import 'package:dallal_proj/core/utils/rsp_auth.dart';
import 'package:dallal_proj/features/login_page/data/models/login_response_model/user_data.dart';
import 'package:dallal_proj/features/login_page/domain/entities/loggedin_user_entity.dart';

class LoginRspModel extends RspAuth {
  String? logStatus, logMessage;
  String? phone, password;
  LoggedinUserEntity? userData;
  bool? verified;

  LoginRspModel({
    this.logStatus,
    this.logMessage,
    this.phone,
    this.password,
    this.userData,
    this.verified,
  }) : super(status: logStatus, message: logMessage);

  factory LoginRspModel.fromJson(Map<String, dynamic> json) => LoginRspModel(
    logStatus: json['status'] as String?,
    logMessage: json['message'] as String?,
    userData:
        json['data'] is Map<String, dynamic>
            ? UserData.fromJson(json['data'])
            : null,
    verified: json['need_verification'] as bool?,
  );

  Map<String, dynamic> toJson() => {'phone': phone, 'password': password};
}
