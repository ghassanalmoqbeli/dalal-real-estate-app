import 'package:flutter/material.dart';

class AbsorbWidget extends StatelessWidget {
  const AbsorbWidget({super.key, required this.onlyIf, required this.child});
  final bool onlyIf;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: onlyIf,
      child: Opacity(opacity: onlyIf ? 0.5 : 1.0, child: child),
    );
  }
}
