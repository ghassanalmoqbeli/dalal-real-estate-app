import 'package:dallal_proj/core/components/app_cards/package_card/frame_ico_line.dart';
import 'package:dallal_proj/core/components/app_cards/package_card/package_card_box.dart';
import 'package:dallal_proj/core/components/app_cards/package_card/price_ico_line.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/core/widgets/text_widgets/body_text.dart';
import 'package:dallal_proj/core/widgets/text_widgets/r_text.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/material.dart';

class PckgCard extends StatelessWidget {
  const PckgCard({
    super.key,
    required this.cWidth,
    required this.pckgModel,
    this.cardType = PackageCardType.multi,
    this.onTap,
  });
  final PckgInfModel pckgModel;
  final PackageCardType cardType;
  final double cWidth;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final bool isSingle = cardType == PackageCardType.single;
    return PckgCardBox(
      onTap: onTap,
      padding: cardType.padding,
      cWidth: cWidth,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                RText('$kPackage ${pckgModel.type.name}', cardType.titleStyle),
                const Spacer(flex: 1),
                Image.asset(
                  pckgModel.type.img,
                  height: cardType.imgSize,
                  width: cardType.imgSize,
                ),
                Spacer(flex: isSingle ? 2 : 3),
                PriceIcoLine(
                  type: pckgModel.type,
                  icoSize: cardType.icoSize,
                  style: cardType.detsStyle,
                ),
                Spacer(flex: isSingle ? 1 : 2),
                FrameIcoLine(
                  type: pckgModel.type,
                  icoSize: cardType.icoSize,
                  style: cardType.detsStyle,
                ),
                Spacer(flex: isSingle ? 2 : 3),
                if (isSingle) WidH.respSep(context),
                if (isSingle) const Spacer(),
                if (isSingle)
                  BodyTxt(
                    text: '$kStartDate${pckgModel.startDateStr}',
                    style: cardType.detsStyle,
                  ),
                if (isSingle) const Spacer(),
                if (isSingle)
                  BodyTxt(
                    text: '$kEndDate${pckgModel.endDateStr}',
                    style: cardType.detsStyle,
                  ),
                if (isSingle) const Spacer(),
                if (isSingle)
                  BodyTxt(
                    text: '$kRemaining${pckgModel.remainingDays} $kDay',
                    style: cardType.dtStyle,
                  ),
                if (isSingle) const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PckgCard2 extends StatelessWidget {
  const PckgCard2({
    super.key,
    required this.cWidth,
    required this.pckgModel,
    this.cardType = PackageCardType.multi,
  });
  final PckgInfModel pckgModel;
  final PackageCardType cardType;
  final double cWidth;

  @override
  Widget build(BuildContext context) {
    final bool isSingle = cardType == PackageCardType.single;
    return PckgCardBox(
      padding: cardType.padding,
      cWidth: cWidth,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                RText('$kPackage ${pckgModel.type.name}', cardType.titleStyle),
                const Spacer(flex: 1),
                Image.asset(
                  pckgModel.type.img,
                  height: cardType.imgSize,
                  width: cardType.imgSize,
                ),
                Spacer(flex: isSingle ? 2 : 3),
                PriceIcoLine(
                  type: pckgModel.type,
                  icoSize: cardType.icoSize,
                  style: cardType.detsStyle,
                ),
                Spacer(flex: isSingle ? 1 : 2),
                FrameIcoLine(
                  type: pckgModel.type,
                  icoSize: cardType.icoSize,
                  style: cardType.detsStyle,
                ),
                Spacer(flex: isSingle ? 2 : 3),
                if (isSingle) WidH.respSep(context),
                if (isSingle) const Spacer(),
                if (isSingle)
                  BodyTxt(
                    text: '$kStartDate${pckgModel.startDateStr}',
                    style: cardType.detsStyle,
                  ),
                if (isSingle) const Spacer(),
                if (isSingle)
                  BodyTxt(
                    text: '$kEndDate${pckgModel.endDateStr}',
                    style: cardType.detsStyle,
                  ),
                if (isSingle) const Spacer(),
                if (isSingle)
                  BodyTxt(
                    text: '$kRemaining${pckgModel.remainingDays} $kDay',
                    style: cardType.dtStyle,
                  ),
                if (isSingle) const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
