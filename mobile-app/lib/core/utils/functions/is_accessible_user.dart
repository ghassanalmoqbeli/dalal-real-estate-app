import 'package:dallal_proj/core/utils/functions/get_me_data.dart';

bool isAccessibleUser() {
  final user = getMeData();
  if (user != null) {
    return true;
  }
  return false;
}
