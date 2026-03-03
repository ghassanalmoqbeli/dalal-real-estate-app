import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/core/widgets/helpers/show_snack_bar.dart';
import 'package:dallal_proj/core/widgets/loadable_body.dart';
import 'package:dallal_proj/features/my_account_page/data/models/user_profile/user_profile.dart';
import 'package:dallal_proj/features/my_account_page/presentation/manager/delete_adv_cubit/delete_adv_cubit.dart';
import 'package:dallal_proj/features/my_account_page/presentation/manager/user_profile_cubit/user_profile_cubit.dart';
import 'package:dallal_proj/features/my_account_page/presentation/views/widgets/my_account_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAccountLoadableBodyBuilder extends StatelessWidget {
  const MyAccountLoadableBodyBuilder({super.key, required this.userProfile});
  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    var user = getMeData();
    return BlocConsumer<DeleteAdvCubit, DeleteAdvState>(
      listener: (context, state) {
        if (state is DeleteAdvFailure) {
          showAppSnackBar(context, message: 'فشل حذف الإعلان ياغالي');
        }
        if (state is DeleteAdvSuccess) {
          BlocProvider.of<UserProfileCubit>(
            context,
          ).fetchUserProfile(user!.uToken);
          showAppSnackBar(
            context,
            message: 'نجح حذف الإعلان ياغالي',
            backgroundColor: kPrimColG,
          );
        }
      },
      builder: (context, state) {
        return LoadableBody(
          isLoading: state is DeleteAdvLoading,
          child: MyAccountBody(userProfile: userProfile),
        );
      },
    );
  }
}
