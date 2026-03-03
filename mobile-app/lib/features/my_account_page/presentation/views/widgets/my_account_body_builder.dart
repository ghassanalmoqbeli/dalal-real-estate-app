import 'package:dallal_proj/core/components/app_btns/col_btn.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/core/widgets/text_widgets/r_text.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_col.dart';
import 'package:dallal_proj/features/my_account_page/presentation/manager/user_profile_cubit/user_profile_cubit.dart';
import 'package:dallal_proj/features/my_account_page/presentation/views/widgets/my_account_loadable_body_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyAccountBodyBuilder extends StatelessWidget {
  const MyAccountBodyBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileCubit, UserProfileState>(
      builder: (context, state) {
        if (state is UserProfileSuccess) {
          // state.userProfile
          return MyAccountLoadableBodyBuilder(userProfile: state.userProfile);
        }
        if (state is UserProfileGuestMode) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TwoItmCol(
                btmChild: VPItem(
                  tSpc: 40,
                  child: ColBtn(
                    txt: 'الذهاب لصفحة تسجيل الدخول',
                    onPressed: () {
                      context.go(AppRouter.kLoginPage);
                    },
                  ),
                ),
                topChild: const RText(
                  txtAlign: TextAlign.center,
                  'سجل الدخول الآن وابدأ اعداد ملفك الشخصي!',
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        }
        if (state is UserProfileFailure) {
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
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator(color: kPrimColG));
      },
    );
  }
}
