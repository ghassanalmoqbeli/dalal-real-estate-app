import 'package:dallal_proj/core/components/app_cards/package_card/package_card.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/core/widgets/text_widgets/body_text.dart';
import 'package:dallal_proj/core/widgets/text_widgets/right_main_title.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/cupertino.dart';

class PackageDetailsBody extends StatelessWidget {
  const PackageDetailsBody({super.key, required this.package});
  final PckgInfModel package;

  @override
  Widget build(BuildContext context) {
    final double cSize = Funcs.respWidth(fract: 0.75, context: context);
    return Column(
      children: [
        const Spacer(flex: 2),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: RightMainTitle(text: kUrAdvIsFeatured),
        ),
        const Spacer(flex: 1),
        const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: BodyTxt(tAln: WidH.tra, text: kUrPckgIs),
          ),
        ),
        const Spacer(),
        AspectRatio(
          aspectRatio: cSize / 425,
          child: PckgCard(
            cWidth: cSize,
            pckgModel: package,
            cardType: PackageCardType.single,
          ),
        ),
        const Spacer(flex: 7),
      ],
    );
  }
}
