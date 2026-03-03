import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/core/widgets/text_widgets/text_link.dart';
import 'package:dallal_proj/core/components/app_btns/col_btn.dart';
import 'package:dallal_proj/features/change_password_page/data/models/change_pass_req_model.dart';
import 'package:dallal_proj/features/change_password_page/presentation/manager/change_password_cubit/change_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dallal_proj/core/widgets/inf_comp.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/widgets/text_widgets/body_text.dart';
import 'package:dallal_proj/core/widgets/text_widgets/right_main_title.dart';
import 'package:dallal_proj/core/components/app_input_fields/pass_fields/pass_field.dart';
import 'package:dallal_proj/core/components/app_input_fields/pass_fields/confirm_pass_field.dart';

class ChangePassBody extends StatefulWidget {
  const ChangePassBody({super.key});

  @override
  State<ChangePassBody> createState() => _ChangePassBodyState();
}

class _ChangePassBodyState extends State<ChangePassBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController _currPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final ValueNotifier<bool> _isCurrPassVisible = ValueNotifier(true);
  final ValueNotifier<bool> _isNewPassVisible = ValueNotifier(true);
  final ValueNotifier<bool> _isConfirmPassVisible = ValueNotifier(true);

  @override
  void dispose() {
    _currPassController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    _isCurrPassVisible.dispose();
    _isConfirmPassVisible.dispose();
    _isNewPassVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: [
          const Spacer(flex: 3),
          const RightMainTitle(text: kChangePass),
          const Spacer(flex: 1),
          const Align(
            alignment: Alignment.centerRight,
            child: BodyTxt(text: kWriteSthURemember),
          ),
          const Spacer(flex: 3),
          InfComp(
            title: kCurrentPass,
            child: PassField(
              onChanged: (value) {
                // Handle password change
              },
              controller: _currPassController,
              visibilityNotifier: _isCurrPassVisible,
            ),
          ),
          const Spacer(flex: 1),
          Align(
            alignment: Alignment.centerRight,
            child: TextLink(
              text: kDidForgetPass,
              onTap:
                  () => GoRouter.of(context).push(AppRouter.kVerificationPage),
            ),
          ),

          const Spacer(flex: 2),
          InfComp(
            title: kNewPass,
            child: PassField(
              visibilityNotifier: _isNewPassVisible,
              controller: _newPassController,
            ),
          ),
          const Spacer(flex: 2),
          InfComp(
            title: kConfirmNewPass,
            child: ConfirmPassField(
              visibilityNotifier: _isConfirmPassVisible,
              confirmController: _confirmPassController,
              originalController: _newPassController,
            ),
          ),
          const Spacer(flex: 5),
          ColBtn(
            txt: kReset,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                var user = getMeData();
                BlocProvider.of<ChangePasswordCubit>(context).changePassword(
                  ChangePassReqModel(
                    token: user!.uToken!,
                    currentPass: _currPassController.text,
                    newPass: _newPassController.text,
                  ),
                );
              }
            },
          ),
          const Spacer(flex: 8),
        ],
      ),
    );
  }
}
