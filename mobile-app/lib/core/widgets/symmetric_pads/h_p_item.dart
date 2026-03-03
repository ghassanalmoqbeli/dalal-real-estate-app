import 'package:flutter/material.dart';

class HPItem extends StatelessWidget {
  const HPItem({super.key, required this.child, this.rSpc = 0, this.lSpc = 0});

  final Widget child;
  final double rSpc, lSpc;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [SizedBox(width: lSpc), child, SizedBox(width: rSpc)],
    );
  }
}
