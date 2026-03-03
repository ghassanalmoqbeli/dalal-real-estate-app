import 'package:dallal_proj/core/components/radio_components/h_radio_form.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/material.dart';

class CrAdvHelper {
  static String getLastWord(String title) {
    List<String> words = title.trim().split(' ');
    return words.isNotEmpty ? words.last : '';
  }

  static HRadioForm radCrAdv(
    ValueNotifier<String> selectedOpt,
    Function(String)? onTapped,
    OptionsListModel olModel,
  ) {
    return HRadioForm(
      onTapped: onTapped,
      selectedOpt: selectedOpt,
      olModel: olModel,
      titleStyle: FStyles.s16w4,
    );
  }
}
