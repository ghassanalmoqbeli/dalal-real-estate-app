import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/utils/functions/delete_user_login_data.dart';
import 'package:dallal_proj/core/widgets/helpers/show_snack_bar.dart';
import 'package:dallal_proj/core/widgets/loadable_body.dart';
import 'package:dallal_proj/features/more_page/presentation/delete_account_cubit/delete_account_cubit.dart';
import 'package:dallal_proj/features/more_page/presentation/views/widgets/more_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MoreLoadableBodyBuilder extends StatelessWidget {
  const MoreLoadableBodyBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
      listener: (context, state) {
        if (state is DeleteAccountFailure) {
          showAppSnackBar(context, message: state.errMsg);
        }
        if (state is DeleteAccountSuccess) {
          deleteUserLoginData();
          context.go(AppRouter.kPreRegisterPage);
          showAppSnackBar(
            context,
            message: 'تم إرسال طلب حذف حسابك بنجاح',
            backgroundColor: kPrimColG,
          );
        }
      },
      builder: (context, state) {
        return LoadableBody(
          isLoading: state is DeleteAccountLoading,
          child: const MoreBody(),
        );
      },
    );
  }
}
