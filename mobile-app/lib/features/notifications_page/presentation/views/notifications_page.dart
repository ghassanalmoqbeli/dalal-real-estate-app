import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/core/utils/service_locator.dart';
import 'package:dallal_proj/core/widgets/custom_app_bar.dart';
import 'package:dallal_proj/features/notifications_page/data/repos/notifications_page_repo_implement.dart';
import 'package:dallal_proj/features/notifications_page/domain/use_cases/fetch_notifications_use_case.dart';
import 'package:dallal_proj/features/notifications_page/domain/use_cases/mark_as_read_use_case.dart';
import 'package:dallal_proj/features/notifications_page/presentation/manager/mark_as_read_cubit/mark_as_read_cubit.dart';
import 'package:dallal_proj/features/notifications_page/presentation/manager/notifications_cubit/notifications_cubit.dart';
import 'package:dallal_proj/features/notifications_page/presentation/views/widgets/notific_body_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificPage extends StatelessWidget {
  const NotificPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => NotificationsCubit(
                fetchNotificationsUseCase: FetchNotificationsUseCase(
                  notificationsPageRepo:
                      getIt.get<NotificationsPageRepoImplement>(),
                ),
                notificationsPageRepo:
                    getIt.get<NotificationsPageRepoImplement>(),
              )..fetchNotifications(token: getMeData()?.uToken ?? ''),
        ),
        BlocProvider(
          create:
              (context) => MarkAsReadCubit(
                MarkAsReadUseCase(
                  notificationsPageRepo:
                      getIt.get<NotificationsPageRepoImplement>(),
                ),
              ),
        ),
      ],
      child: const Scaffold(
        backgroundColor: kWhite,
        appBar: CustomAppBar(title: 'الإشعارات'),
        body: NotificBodyBuilder(),
      ),
    );
  }
}
