import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';

class PHelper {
  static bool isYemComp(TextEditingController txtCont) {
    if (!txtCont.text.startsWith(kYeMobile) &&
        !txtCont.text.startsWith(kYeMobile2) &&
        !txtCont.text.startsWith(kMTN) &&
        !txtCont.text.startsWith(kSabaPhone) &&
        !txtCont.text.startsWith(kY)) {
      return true;
    }
    return false;
  }

  static bool areDigitsOnly(TextEditingController txtCont) {
    if (txtCont.text.contains(RegExp(kRegex), 1)) {
      return true;
    }
    return false;
  }

  static bool isCmplt(TextEditingController txtCont) {
    if (txtCont.text.length == 9) {
      return false;
    }
    return true;
  }

  static bool isYemNum(String? txt) {
    if (txt == null || txt.startsWith(kYemKey)) return true;

    return false;
  }

  static bool initValid(
    String txt,
    TextEditingController textcont,
    String? txt2,
  ) {
    if (txt.isEmpty || textcont.text.isEmpty || txt2 == null) {
      return true;
    }
    return false;
  }

  static Widget buildErrorText(FormFieldState<String> fieldState) {
    if (!fieldState.hasError) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 14),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          fieldState.errorText!,
          textAlign: TextAlign.left,
          style: FsC.colSt(FStyles.s12w4, kRed0A),
        ),
      ),
    );
  }

  static String? validatePhone({
    required bool validatorEnabled,
    required String completeNumber,
    required TextEditingController controller,
    required String? value,
  }) {
    if (!validatorEnabled) return null;
    if (initValid(completeNumber, controller, value)) return kFillFieldFirst;
    // if (!isYemNum(value)) return kErrChangeCountry;
    if (isYemComp(controller)) return kErrWrongYemNum;
    if (areDigitsOnly(controller)) {
      if (isCmplt(controller)) return kErrCompletePhone;
      return null;
    }
    return kErrOnlyNumPls;
  }

  static style() => PickerDialogStyle(backgroundColor: kWhite);
  static deco(bool hasError) =>
      hasError
          ? Themer.customErrorInput()
          : Themer.custInputDeco(hintText: kPhoneNumHint);
  static ddd() => const BoxDecoration(
    border: Border(right: BorderSide(color: kBlack38, width: 0.5)),
  );
}
