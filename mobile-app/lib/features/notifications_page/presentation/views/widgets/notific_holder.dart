import 'package:dallal_proj/core/components/app_cards/property_card/items/card_details/card_date_txt.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_col.dart';
import 'package:dallal_proj/features/notifications_page/data/models/notification_model.dart';
import 'package:dallal_proj/features/notifications_page/presentation/views/widgets/notific_out_line.dart';
import 'package:dallal_proj/features/notifications_page/presentation/views/widgets/notific_text_holder.dart';
import 'package:flutter/material.dart';

class NotificHolder extends StatelessWidget {
  const NotificHolder({super.key, required this.notification});
  final NotificationModel notification;

  DateTime? _parseDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return null;
    try {
      return DateTime.parse(dateStr);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final date = _parseDate(notification.createdAt) ?? DateTime.now();
    final isUnread = notification.isUnread;

    return Align(
      alignment: Alignment.centerRight,
      child: Stack(
        children: [
          NotificOutLine(
            isUnread: isUnread,
            child: TwoItmCol(
              cXAlign: CrossAxisAlignment.end,
              topChild: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (notification.title != null &&
                      notification.title!.isNotEmpty)
                    Expanded(
                      child: Text(
                        notification.title!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  CardDateTxt(date: date, fHeight: 0.8),
                ],
              ),
              btmChild: NotificTextHolder(
                notificText: notification.message ?? '',
              ),
            ),
          ),
          // Unread indicator dot
          if (isUnread)
            Positioned(
              top: 12,
              right: 28,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: kPrimColG,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
