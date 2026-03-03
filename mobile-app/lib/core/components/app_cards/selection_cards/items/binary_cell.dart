import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:flutter/material.dart';

class BinaryCell extends StatelessWidget {
  const BinaryCell({
    super.key,
    required this.topCell,
    required this.bottomCell,
  });
  final Widget topCell, bottomCell;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          topCell,
          SizedBox(height: Funcs.respHieght(fract: 0.025, context: context)),
          bottomCell,
        ],
      ),
    );
  }
}
