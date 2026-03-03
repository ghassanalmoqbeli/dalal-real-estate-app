import 'package:dallal_proj/features/login_page/domain/entities/loggedin_user_entity.dart';

bool isLoggedin(LoggedinUserEntity? userData) {
  if (userData != null) return true;
  return false;
}
