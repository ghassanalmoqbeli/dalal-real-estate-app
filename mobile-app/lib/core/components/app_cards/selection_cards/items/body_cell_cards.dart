import 'package:dallal_proj/core/widgets/helpers/s_bx.dart';
import 'package:dallal_proj/core/components/app_cards/selection_cards/items/binary_cell.dart';
import 'package:flutter/material.dart';

class BodyCellCards extends StatelessWidget {
  const BodyCellCards({
    super.key,
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.bottomRight,
  });
  final Widget topLeft, topRight, bottomLeft, bottomRight;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BinaryCell(topCell: topLeft, bottomCell: bottomLeft),
        SBx.rWsbx(0.044, context),
        BinaryCell(topCell: topRight, bottomCell: bottomRight),
      ],
    );
  }
}

// SizedBox(width: Funcs.respWidth(fract: 0.044, context: context)),
