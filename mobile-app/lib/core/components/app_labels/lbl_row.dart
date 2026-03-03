import 'package:flutter/material.dart';

class LblRow extends StatelessWidget {
  const LblRow({super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: children,
    );
  }
}
