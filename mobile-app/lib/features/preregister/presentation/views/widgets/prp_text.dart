import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/text_widgets/dynamic_text.dart';
import 'package:flutter/material.dart';

class PrpText extends StatelessWidget {
  const PrpText({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicText(
      txt: kPrpTxt,
      txtAlign: TextAlign.right,
      style: FStyles.s16w6h175,
      hPadding: Funcs.respWidth(fract: 0.007, context: context),
    );
  }
}

// Padding(
//   padding: EdgeInsets.symmetric(
//     horizontal: Funcs.respWidth(fract: 0.007, context: context),
//   ),
//   child: RText(
//     'لتتمكن من نشر إعلانك العقاري، يرجى تسجيل الدخول أو إنشاء حساب جديد!\nسجل الآن وابدأ بعرض عقاراتك بسهولة وسرعة.',
//     FStyles.s16w6h175,
//     txtAlign: TextAlign.right,
//   ),
// );
