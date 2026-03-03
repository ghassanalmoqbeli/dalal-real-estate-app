import 'package:dallal_proj/core/components/shimmer_widgets/shimmer_wrapper.dart';
import 'package:dallal_proj/core/widgets/svg_ico.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/h_p_item.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:flutter/material.dart';

class RightIcoLineShimmer extends StatelessWidget {
  const RightIcoLineShimmer({
    super.key,
    required this.icoPath,
    this.itSpc,
    this.icoHt,
    this.icoWth,
    this.color,
  });
  final String icoPath;
  final Color? color;
  final double? itSpc, icoHt, icoWth;
  @override
  Widget build(BuildContext context) {
    return TwoItmRow(
      mXAlign: MainAxisAlignment.end,
      leftChild: HPItem(
        rSpc: itSpc ?? 5,
        child: ShimmerWrapper(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            height: 7,
            child: Container(color: Colors.green[100]),
          ),
        ),
      ),
      rightChild: SvgIco(
        ico: icoPath,
        ht: icoHt ?? 13,
        wth: icoWth ?? 13,
        color: color,
      ),
    );
  }
}
