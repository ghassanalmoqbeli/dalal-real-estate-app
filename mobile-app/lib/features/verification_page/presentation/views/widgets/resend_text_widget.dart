import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/text_widgets/link_text_span.dart';
import 'package:flutter/material.dart';

class ResendTextWidget extends StatelessWidget {
  final void Function()? onTapResend;
  final void Function()? onTapWhatsApp;

  const ResendTextWidget({super.key, this.onTapResend, this.onTapWhatsApp});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: FStyles.s14W5,
        children: [
          const TextSpan(text: kDidntGetCode),
          linkTextSpan(context: context, text: kReSend, onTap: onTapResend),
          const TextSpan(text: kOr),
          linkTextSpan(
            context: context,
            text: kReSendOnWhatsApp,
            onTap: onTapWhatsApp,
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
