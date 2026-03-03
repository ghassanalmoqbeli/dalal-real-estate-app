class VerifyModel {
  String phone, code;

  VerifyModel(this.phone, this.code);

  Map<String, dynamic> toJson() => {'phone': phone, 'code': code};
}
