import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/features/notifications_page/presentation/views/widgets/notific_helper.dart';
import 'package:flutter/material.dart';

class NotificOutLine extends StatelessWidget {
  const NotificOutLine({super.key, required this.child, this.isUnread = false});

  final Widget child;
  final bool isUnread;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2, bottom: 4),
      margin: const EdgeInsets.only(right: 20, left: 20, top: 7, bottom: 10),
      decoration: NtfHelper.notificOutLine(
        bgColor: isUnread ? kPrimColG.withValues(alpha: 0.05) : kWhiteT6,
      ),
      child: child,
    );
  }
}
