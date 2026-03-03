import 'package:dallal_proj/features/notifications_page/presentation/views/widgets/notific_text_widget.dart';
import 'package:flutter/material.dart';

class NotificTextHolder extends StatelessWidget {
  const NotificTextHolder({super.key, required this.notificText});

  final String notificText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 25, left: 25, top: 4, bottom: 10),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: NotificTextWidget(notificText: notificText),
    );
  }
}
