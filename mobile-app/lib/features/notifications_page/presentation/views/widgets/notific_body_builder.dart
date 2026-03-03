import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/widgets/text_widgets/r_text.dart';
import 'package:dallal_proj/features/notifications_page/presentation/manager/notifications_cubit/notifications_cubit.dart';
import 'package:dallal_proj/features/notifications_page/presentation/views/widgets/notific_list_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificBodyBuilder extends StatelessWidget {
  const NotificBodyBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        if (state is NotificationsSuccess) {
          if (state.notifications.isEmpty) {
            return const Center(
              child: RText(
                'لا توجد إشعارات',
                TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            );
          }
          return NotificListBuilder(
            notifications: state.notifications,
            unreadCount: state.unreadCount,
          );
        }

        if (state is NotificationsLoadingMore) {
          return Column(
            children: [
              Expanded(
                child: NotificListBuilder(
                  notifications: state.notifications,
                  unreadCount: state.unreadCount,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(color: kPrimColG),
              ),
            ],
          );
        }

        if (state is NotificationsFailure) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: RText(
                    'خطأ ما قد حدث!',
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    state.errMsg,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Retry fetching notifications
                    context.read<NotificationsCubit>().fetchNotifications(
                      token: '', // Will be filled from user data
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: kPrimColG),
                  child: const Text(
                    'إعادة المحاولة',
                    style: TextStyle(color: kWhite),
                  ),
                ),
              ],
            ),
          );
        }

        // Loading state
        return const Center(child: CircularProgressIndicator(color: kPrimColG));
      },
    );
  }
}
