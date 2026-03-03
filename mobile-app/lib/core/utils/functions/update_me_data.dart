import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/features/login_page/domain/entities/loggedin_user_entity.dart';
import 'package:hive/hive.dart';

void updateUserData({String? name, String? whatsapp, String? profileImage}) {
  var box = Hive.box<LoggedinUserEntity?>(kMeDataBox);
  final current = box.get('me');

  if (current != null) {
    final updated = LoggedinUserEntity(
      uToken: current.uToken, // untouched
      uId: current.uId, // untouched
      uName: name ?? current.uName,
      uPhone: current.uPhone, // untouched
      uWhatsapp: whatsapp ?? current.uWhatsapp,
      uProfileImage: profileImage ?? current.uProfileImage,
    );

    box.put('me', updated);
  }
}
