import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/text_widgets/link_text_span.dart';
import 'package:flutter/material.dart';

class EmbTextLink extends StatelessWidget {
  const EmbTextLink({
    super.key,
    required this.postOwner,
    required this.userComment,
  });
  final String postOwner;
  final String userComment;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: WidH.trd,
      child: Text.rich(
        TextSpan(
          style: FStyles.s10w4,
          children: [
            linkTextSpan(
              context: context,
              onTap: () {},
              text: '$postOwner , ',
              style: FsC.colStG(FStyles.s10w4),
            ),
            TextSpan(text: userComment),
          ],
        ),
        textAlign: WidH.tra,
      ),
    );
  }
}

// text:
//     '، ما هي الخطوات التالية التي يجب اتخاذها؟، ما هي الخطوات التالية التي يجب اتخاذها؟، ما هي الخطوات التالية التي يجب اتخاذها؟، ما هي الخطوات التالية التي يجب اتخاذها؟، ما هي الخطوات التالية التي يجب اتخاذهايجب اتخاذها؟، ما هي الخطوات التالية التي يجب اتخاذهايجب اتخاذها؟، ما هي الخطوات التالية التي يجب اتخاذهايجب اتخاذها؟، ما هي الخطوات التالية التي يجب اتخاذهايجب اتخاذها؟، ما هي الخطوات التالية التي يجب اتخاذهايجب اتخاذها؟، ما هي الخطوات التالية التي يجب اتخاذهايجب اتخاذها؟، ما هي الخطوات التالية التي يجب اتخاذهايجب اتخاذها؟، ما هي الخطوات التالية التي يجب اتخاذهايجب اتخاذها؟، ما هي الخطوات التالية التي يجب اتخاذهايجب اتخاذها؟، ما هي الخطوات التالية التي يجب اتخاذهايجب اتخاذها؟، ما هي الخطوات التالية التي يجب اتخاذها؟',
