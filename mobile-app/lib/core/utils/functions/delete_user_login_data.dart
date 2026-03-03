import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/features/login_page/domain/entities/loggedin_user_entity.dart';
import 'package:hive/hive.dart';

void deleteUserLoginData() {
  var box = Hive.box<LoggedinUserEntity?>(kMeDataBox);
  box.delete('me');
}
