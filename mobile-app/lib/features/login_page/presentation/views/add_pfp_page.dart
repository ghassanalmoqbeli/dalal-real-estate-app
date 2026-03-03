import 'dart:developer';

import 'package:dallal_proj/core/components/app_btns/white_btn.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/core/widgets/helpers/show_snack_bar.dart';
import 'package:dallal_proj/core/widgets/loadable_body.dart';
import 'package:dallal_proj/features/login_page/data/models/set_profile_req_model.dart';
import 'package:dallal_proj/features/login_page/domain/entities/loggedin_user_entity.dart';
import 'package:dallal_proj/features/login_page/presentation/manager/set_profile_picture_cubit/set_profile_picture_cubit.dart';
import 'package:dallal_proj/features/login_page/presentation/views/add_profile_item.dart.dart';
import 'package:flutter/material.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/widgets/text_widgets/r_text.dart';
import 'package:dallal_proj/core/widgets/text_widgets/right_main_title.dart';
import 'package:dallal_proj/core/components/app_btns/col_btn.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/page_padding.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddPfpPage extends StatefulWidget {
  const AddPfpPage({super.key});

  @override
  State<AddPfpPage> createState() => _AddPfpPageState();
}

class _AddPfpPageState extends State<AddPfpPage> {
  String? _base64Image = '';
  final LoggedinUserEntity? _user = getMeData();
  _setImage(String? base64Image) {
    setState(() {
      _base64Image = base64Image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagePadding(
        child: BlocConsumer<SetProfileCubit, SetProfileState>(
          listener: (context, state) {
            if (state is SetProfileFailure) {
              showAppSnackBar(context, message: state.errMsg);
            }
            if (state is SetProfileSuccess) {
              context.go(AppRouter.kMainPage);
              showAppSnackBar(
                context,
                message: 'تم تحديث الملف الشخصي بنجاح',
                backgroundColor: kPrimColG,
              );
            }
          },
          builder: (context, state) {
            return LoadableBody(
              isLoading: state is SetProfileLoading,
              child: AddPfpBody(
                userName: _user!.uName!,
                onImageChanged: (base64Image) {
                  _setImage(base64Image);
                  log(
                    'Profile image selected: ${base64Image?.substring(0, 20)}...',
                  );
                },
                onContinuePressed: () {
                  BlocProvider.of<SetProfileCubit>(
                    context,
                  ).setProfile(UserProfileModel(profileImage: _base64Image));
                },
                onSkipPressed: () => context.go(AppRouter.kMainPage),
              ),
            );
          },
        ),
      ),
    );
  }
}

class AddPfpBody extends StatelessWidget {
  const AddPfpBody({
    super.key,
    required this.userName,
    required this.onImageChanged,
    this.onContinuePressed,
    this.onSkipPressed,
  });
  final String userName;
  final void Function(String?)? onImageChanged;
  final void Function()? onContinuePressed;
  final void Function()? onSkipPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 3),
        RightMainTitle(
          text: '$kWelcSB ${userName.split(' ').first} ! \n $kWelc',
          isRight: false,
        ),
        const Spacer(flex: 1),
        AddProfileItem(size: 150, onImageChanged: onImageChanged),
        const Spacer(flex: 1),
        RText(kAddPfp, FStyles.s20w6),
        const Spacer(flex: 3),
        ColBtn(txt: kContinue, onPressed: onContinuePressed),
        const Spacer(flex: 1),
        WhiteBtn(txt: kSkip, onPressed: onSkipPressed),
        const Spacer(flex: 3),
      ],
    );
  }
}
