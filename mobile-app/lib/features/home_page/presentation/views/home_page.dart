import 'package:dallal_proj/core/components/app_bottom_sheets/log_required_b_s/show_log_required_b_s.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/home_body.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/home_app_bar/home_app_bar.dart';
import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/core/widgets/unfocus_ontap.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/features/notifications_page/presentation/manager/unread_count_cubit/unread_count_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return UnfocusOntap(
      child: BlocBuilder<UnreadCountCubit, UnreadCountState>(
        builder: (context, state) {
          // Check hasUnread from state or fallback to cubit's current count
          final hasUnread =
              state is UnreadCountSuccess
                  ? state.unreadCount > 0
                  : context.read<UnreadCountCubit>().currentUnreadCount > 0;
          return Scaffold(
            appBar: HomeAppBar(
              hasUnread: hasUnread,
              notifOnPressed: () async {
                var user = getMeData();
                if (user == null) {
                  showLoginRequiredBottomSheet(context);
                } else {
                  // Navigate and refresh unread count when returning
                  await GoRouter.of(context).push(AppRouter.kNotificPage);
                  // Refresh unread count after returning from notifications page
                  if (context.mounted) {
                    context.read<UnreadCountCubit>().getUnreadCount(
                      user.uToken ?? '',
                    );
                  }
                }
              },
              favOnPressed: () {
                var user = getMeData();
                if (user == null) {
                  showLoginRequiredBottomSheet(context);
                } else {
                  GoRouter.of(
                    context,
                  ).pushNamed(AppRouter.kFavoritePage, extra: user.uToken);
                }
              },
            ),
            body: const HomeBody(),
          );
        },
      ),
    );
  }
}
