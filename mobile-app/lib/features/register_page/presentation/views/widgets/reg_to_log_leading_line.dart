import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/text_widgets/text_link.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegToLogLeadingLine extends StatelessWidget {
  const RegToLogLeadingLine({super.key});

  @override
  Widget build(BuildContext context) {
    return TwoItmRow(
      mXAlign: MainAxisAlignment.center,
      leftChild: TextLink(
        text: kLogin,
        onTap: () => GoRouter.of(context).push(AppRouter.kLoginPage),
      ),
      rightChild: Text(kAlreadyHaveAccount, style: FStyles.s14W4),
    );
  }
}
