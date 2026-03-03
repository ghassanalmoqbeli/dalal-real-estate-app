import 'package:dallal_proj/core/constants/app_texts.dart';

class FVHelper {
  static String? reqField(String? value, {String? errMsg}) =>
      isEmpT(value) ? errMsg ?? kFillFieldFirst : null;

  static String? reqPassField(String? value) =>
      isEmpty(value)
          ? kFillFieldFirst
          : (value!.length < 8)
          ? kPassFewChar
          : null;

  static String? confPassField(String? value, String? original) =>
      isEmpty(value)
          ? kFillFieldFirst
          : (value != original)
          ? kDiffrntPasses
          : null;

  static bool isEmpty(String? value) =>
      (value == null || value.isEmpty) ? true : false;

  static bool isEmpT(String? value) =>
      (value == null || value.trim().isEmpty) ? true : false;
}
