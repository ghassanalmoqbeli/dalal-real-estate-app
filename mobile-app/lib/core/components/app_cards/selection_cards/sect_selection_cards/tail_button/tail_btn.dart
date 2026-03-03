import 'package:dallal_proj/core/widgets/svg_ico.dart';
import 'package:dallal_proj/core/components/app_cards/selection_cards/sect_selection_cards/tail_button/tail_btn_txt.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/material.dart';

class TailTextBtn extends StatelessWidget {
  const TailTextBtn({
    super.key,
    required this.advCountSuffix,
    required this.onTap,
    this.advCount = '150',
    required this.svgModel,
    this.textWidget,
  });

  final void Function()? onTap;
  final String advCount;
  final String advCountSuffix;
  final SvgModel svgModel;
  final Widget? textWidget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          const Spacer(flex: 1),
          SvgIco(ico: svgModel.img, ht: svgModel.height, wth: svgModel.width),
          const Spacer(flex: 15),
          SizedBox(
            width: 25,
            height: 29,
            child: TailBtnText(txt: advCountSuffix),
          ),
          const Spacer(flex: 1),
          TailBtnText(txt: advCount),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
