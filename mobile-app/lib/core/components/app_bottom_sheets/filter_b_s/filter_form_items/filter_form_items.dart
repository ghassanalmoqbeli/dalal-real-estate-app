import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:flutter/material.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/filter_b_s/filter_funcs.dart';

class FilterFormItems extends StatelessWidget {
  const FilterFormItems({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VPItem(tSpc: 10, bSpc: 10, child: Fltr.filterTitle(kFiltering)),
        VPItem(bSpc: 25, child: WidH.respSep(context)),

        //I guess we can put children[0], directly
        (children[0] is SizedBox)
            ? const SizedBox()
            : VPItem(bSpc: 10, child: children[0]),
        //I guess we can put children[0], directly
        //
        VPItem(bSpc: 25, child: children[1]),
        WidH.respSep(context, fract: 0.6),
        VPItem(tSpc: 5, bSpc: 5, child: children[2]),
        children[3],
        VPItem(tSpc: 5, bSpc: 10, child: children[4]),
        WidH.respSep(context, fract: 0.6),
        VPItem(tSpc: 10, child: children[5]),
        VPItem(tSpc: 10, bSpc: 10, child: children[6]),
        WidH.respSep(context),
        VPItem(tSpc: 30, bSpc: 32, child: children[7]),
      ],
    );
  }
}
