import 'package:dallal_proj/core/widgets/text_widgets/r_text.dart';
import 'package:flutter/material.dart';

class NotificTextWidget extends StatelessWidget {
  const NotificTextWidget({super.key, required this.notificText});

  final String notificText;

  @override
  Widget build(BuildContext context) {
    return RText(
      notificText,
      const TextStyle(height: 1.25),
      txtAlign: TextAlign.right,
    );
  }
}
