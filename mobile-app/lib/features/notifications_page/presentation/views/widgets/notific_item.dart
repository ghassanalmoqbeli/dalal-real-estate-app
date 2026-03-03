import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/features/notifications_page/data/models/notification_model.dart';
import 'package:dallal_proj/features/notifications_page/presentation/manager/mark_as_read_cubit/mark_as_read_cubit.dart';
import 'package:dallal_proj/features/notifications_page/presentation/manager/notifications_cubit/notifications_cubit.dart';
import 'package:dallal_proj/features/notifications_page/presentation/views/widgets/notific_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificItem extends StatelessWidget {
  const NotificItem({super.key, required this.notification});
  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return BlocListener<MarkAsReadCubit, MarkAsReadState>(
      listener: (context, state) {
        if (state is MarkAsReadSuccess &&
            state.notificationId == notification.id) {
          // Update the notification cubit locally
          context.read<NotificationsCubit>().markNotificationAsReadLocally(
            notification.id!,
          );
        }
        if (state is MarkAllAsReadSuccess) {
          context.read<NotificationsCubit>().markAllAsReadLocally();
        }
      },
      child: GestureDetector(
        onTap: () {
          if (notification.isUnread) {
            final token = getMeData()?.uToken ?? '';
            context.read<MarkAsReadCubit>().markAsRead(
              token: token,
              notificationId: notification.id!,
            );
          }
          // You can add navigation to notification details here if needed
        },
        child: NotificHolder(notification: notification),
      ),
    );
  }
}
