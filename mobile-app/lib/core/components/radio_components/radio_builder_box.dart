import 'package:flutter/material.dart';

class RadBuilderBox extends StatelessWidget {
  const RadBuilderBox({
    super.key,
    required this.onTapped,
    required this.child,
    required this.option,
  });
  final String option;
  final ValueChanged<String> onTapped;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => onTapped(option),
        child: child,
      ),
    );
  }
}
