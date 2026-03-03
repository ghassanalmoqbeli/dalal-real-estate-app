import 'package:dallal_proj/constants.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/log_required_b_s/show_log_required_b_s.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/utils/functions/delete_user_login_data.dart';
import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/core/utils/functions/is_loggedin.dart';
import 'package:dallal_proj/core/utils/functions/save_advs_list.dart';
import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/features/more_page/presentation/delete_account_cubit/delete_account_cubit.dart';
import 'package:dallal_proj/features/more_page/presentation/views/widgets/items/box_holder.dart';
import 'package:dallal_proj/features/more_page/presentation/views/widgets/items/form_bars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SmallForm extends StatelessWidget {
  const SmallForm({super.key});

  @override
  Widget build(BuildContext context) {
    final sPace = WidH.respSep(context, fract: 1);

    return BoxHolder(
      fixedSizeFraction: kMSFormFractMedium,
      aspect: kMFormWidthMedium / kMSFormHeight,
      children: [
        FBars.changePass(() {
          var user = getMeData();
          if (isLoggedin(user)) {
            GoRouter.of(context).push(AppRouter.kChangePassPage);
          } else {
            showLoginRequiredBottomSheet(context);
          }
        }),
        sPace,
        FBars.logOut(() {
          deleteAdvsList(kFeaturedAdvBox);
          deleteAdvsList(kAllAdvBox);
          deleteUserLoginData();
          context.go(AppRouter.kPreRegisterPage);
        }),
        sPace,
        FBars.delAcc(() {
          var user = getMeData();

          if (isLoggedin(user)) {
            BlocProvider.of<DeleteAccountCubit>(context).deleteAccount();
          } else {
            showLoginRequiredBottomSheet(context);
          }
        }),
      ],
    );
  }
}

///for small form sizes recommendation:
////////////////// (abMedium) Guess-Working Sizes
///fixedSizeFraction:
///          0.17, //aspect of form height to screen height mSFormHeight / mScRespHeight,
///      aspect:
///          mFormWidth / 143,
///         //mFormWidth = 382
//////////////////
////////////////// (subMedium) standard
///fixedSizeFraction:
///          0.14925, //aspect of form height to screen height mSFormHeight / mScRespHeight,
///      aspect:
///          mFormWidth / 143,
///         //mFormWidth = 410
//////////////////

// fixedSizeFraction:
//     kMSFormFractMedium, //0.17, //0.14925, //0.17, //aspect of form height to screen height mSFormHeight / mScRespHeight,
// aspect:
//     //410ss /
//     kMFormWidthMedium /
//     kMSFormHeight, //mFormWidth / mSFormHeight, //aspect of form width to form height
