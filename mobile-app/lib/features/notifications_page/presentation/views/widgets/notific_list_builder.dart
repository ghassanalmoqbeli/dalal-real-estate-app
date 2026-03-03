import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/features/notifications_page/data/models/notification_model.dart';
import 'package:dallal_proj/features/notifications_page/presentation/manager/notifications_cubit/notifications_cubit.dart';
import 'package:dallal_proj/features/notifications_page/presentation/views/widgets/notific_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificListBuilder extends StatefulWidget {
  const NotificListBuilder({
    super.key,
    required this.notifications,
    required this.unreadCount,
  });

  final List<NotificationModel> notifications;
  final int unreadCount;

  @override
  State<NotificListBuilder> createState() => _NotificListBuilderState();
}

class _NotificListBuilderState extends State<NotificListBuilder> {
  late ScrollController scrollController;
  NotificationsCubit? _notificationsCubit;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Save reference to cubit for safe access in dispose
    _notificationsCubit ??= context.read<NotificationsCubit>();
    // Start SSE for real-time notifications
    _startSSE();
  }

  void _startSSE() {
    final token = getMeData()?.uToken;
    if (token != null && token.isNotEmpty) {
      _notificationsCubit?.startSSEStream(token: token);
    }
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      // Load more notifications when user scrolls near the end
      final state = _notificationsCubit?.state;
      if (state is! NotificationsLoadingMore) {
        final token = getMeData()?.uToken ?? '';
        _notificationsCubit?.fetchNotifications(
          token: token,
          loadMore: true,
          offset: widget.notifications.length,
        );
      }
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    // Stop SSE when leaving the page (using saved reference)
    _notificationsCubit?.stopSSEStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        final token = getMeData()?.uToken ?? '';
        await context.read<NotificationsCubit>().fetchNotifications(
          token: token,
        );
      },
      child: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemCount: widget.notifications.length,
        itemBuilder: (context, index) {
          final notification = widget.notifications[index];
          return NotificItem(notification: notification);
        },
      ),
    );
  }
}
