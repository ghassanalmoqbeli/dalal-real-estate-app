import 'package:dallal_proj/core/components/app_bottom_sheets/a_i_b_s/ai_bs_form_title/s_i_g_text.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AiBsFormTitle extends StatelessWidget {
  const AiBsFormTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const SIGText(
      text: kPredictPriceAiBtn,
      gradient: LinearGradient(colors: kAIFormTitleColors),
      tSpc: 10,
      bSpc: 10,
      lSpc: 10,
    );
  }
}
