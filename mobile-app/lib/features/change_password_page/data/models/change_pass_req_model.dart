class ChangePassReqModel {
  final String token;
  final String currentPass;
  final String newPass;

  ChangePassReqModel({
    required this.token,
    required this.currentPass,
    required this.newPass,
  });

  Map<String, dynamic> toJson() => {
    'current_password': currentPass,
    'new_password': newPass,
    'confirm_password': newPass,
  };
}
