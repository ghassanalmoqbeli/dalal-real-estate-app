import 'package:dallal_proj/core/components/app_input_fields/bases/base_text_input.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:flutter/material.dart';

class PredictedPriceInput extends StatelessWidget {
  const PredictedPriceInput({super.key, this.price});
  final String? price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18.0),
      child: SizedBox(
        height: 40,
        child: BTextInput(
          textStyle: FStyles.s14w6,
          isEnabled: true,
          onChanged: (value) {},
          onSubmitted: (value) {},
          rdOnly: true,
          txt: price,
          decoration: Themer.txtInput(
            hint: kThereSthWrong,
          ).copyWith(fillColor: kWhite),
        ),
      ),
    );
  }
}
