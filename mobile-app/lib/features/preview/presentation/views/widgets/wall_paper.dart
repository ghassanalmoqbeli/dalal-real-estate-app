import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:flutter/material.dart';

class WallPaper extends StatelessWidget {
  const WallPaper({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(decoration: Themer.wallPaper(), child: child);
  }
}
