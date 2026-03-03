class RegisterModel {
  String name, bDate, phone, passWord;
  String? whatsApp;

  RegisterModel(
    this.name,
    this.bDate,
    this.phone,
    this.passWord,
    this.whatsApp,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'password': passWord,
    'whatsapp': whatsApp,
    'date_of_birth': bDate,
  };
}
