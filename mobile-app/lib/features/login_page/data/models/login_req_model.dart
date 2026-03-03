class LoginReqModel {
  String phone, password;

  LoginReqModel(this.phone, this.password);

  Map<String, dynamic> toJson() => {'phone': phone, 'password': password};
}
