import 'package:dallal_proj/core/widgets/inf_comp.dart';
import 'package:flutter/material.dart';

class AdvDBTitledItem extends StatelessWidget {
  const AdvDBTitledItem({
    super.key,
    this.title = '',
    required this.child,
    this.titleRightPadding = 16,
  });
  final String title;
  final Widget child;
  final double titleRightPadding;
  @override
  Widget build(BuildContext context) {
    return InfComp(
      txtRightPadding: titleRightPadding,
      spacing: 15,
      title: title,
      child: child,
    );
  }
}
