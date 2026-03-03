import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/widgets/helpers/show_snack_bar.dart';
import 'package:dallal_proj/core/widgets/loadable_body.dart';
import 'package:dallal_proj/features/change_password_page/presentation/manager/change_password_cubit/change_password_cubit.dart';
import 'package:dallal_proj/features/change_password_page/presentation/views/widgets/change_pass_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordLoadablePageBodyBuilder extends StatelessWidget {
  const ChangePasswordLoadablePageBodyBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordFailure) {
          showAppSnackBar(context, message: state.error);
        }
        if (state is ChangePasswordSuccess) {
          context.go(AppRouter.kPassChangedSuxeed);
        }
      },
      builder: (context, state) {
        return LoadableBody(
          isLoading: state is ChangePasswordLoading,
          child: const ChangePassBody(),
        );
      },
    );
  }
}
