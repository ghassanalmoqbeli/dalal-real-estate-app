import 'package:dallal_proj/core/components/app_btns/col_btn.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/widgets/helpers/show_snack_bar.dart';
import 'package:dallal_proj/features/login_page/data/models/login_req_model.dart';
import 'package:dallal_proj/features/reset_password_page/presentation/manager/reset_password_cubit/reset_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dallal_proj/core/widgets/inf_comp.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/widgets/text_widgets/body_text.dart';
import 'package:dallal_proj/core/widgets/text_widgets/right_main_title.dart';
import 'package:dallal_proj/core/components/app_input_fields/pass_fields/pass_field.dart';
import 'package:dallal_proj/core/components/app_input_fields/pass_fields/confirm_pass_field.dart';

class ResetPasswordBody extends StatefulWidget {
  const ResetPasswordBody({super.key, required this.phone});
  final String phone;

  @override
  State<ResetPasswordBody> createState() => _ResetPasswordBodyState();
}

class _ResetPasswordBodyState extends State<ResetPasswordBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final ValueNotifier<bool> _isConfirmPassVisible = ValueNotifier(true);
  final ValueNotifier<bool> _isNewPassVisible = ValueNotifier(true);
  late String passwrd;

  @override
  void dispose() {
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    passwrd = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          showAppSnackBar(
            context,
            message: state.response.message ?? 'تم تغيير كلمة المرور بنجاح',
            backgroundColor: kPrimColG,
          );
          context.go(AppRouter.kPassChangedSuxeed);
        }
        if (state is ResetPasswordFailure) {
          showAppSnackBar(context, message: state.errMsg);
        }
      },
      builder: (context, state) {
        if (state is ResetPasswordLoading) {
          return const Center(
            child: CircularProgressIndicator(color: kPrimColG),
          );
        }
        return Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              const Spacer(flex: 1),
              const RightMainTitle(text: kResetPassMainTitle),
              //'إعادة تعيين كلمة المرور',
              const Spacer(flex: 3),
              const BodyTxt(text: kWriteSthURemember),
              // 'من فضلك اكتب شيئا سوف تتذكره.',
              const Spacer(flex: 2),
              InfComp(
                title: kNewPass,
                child: PassField(
                  controller: _newPassController,
                  visibilityNotifier: _isNewPassVisible,
                  onChanged: (pass) {
                    passwrd = pass;
                  },
                ),
              ),
              const Spacer(flex: 1),
              InfComp(
                title: kConfirmNewPass,
                child: ConfirmPassField(
                  visibilityNotifier: _isConfirmPassVisible,
                  confirmController: _confirmPassController,
                  originalController: _newPassController,
                ),
              ),
              const Spacer(flex: 4),
              ColBtn(
                txt: kReset,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<ResetPasswordCubit>(
                      context,
                    ).resetPassword(LoginReqModel(widget.phone, passwrd));
                  }
                },
              ),
              const Spacer(flex: 9),
            ],
          ),
        );
      },
    );
  }
}
