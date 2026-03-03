import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/core/widgets/helpers/show_snack_bar.dart';
import 'package:dallal_proj/features/login_page/data/models/login_req_model.dart';
import 'package:dallal_proj/features/login_page/presentation/manager/login_user_cubit/login_user_cubit.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/material.dart';
import 'package:dallal_proj/features/login_page/presentation/views/widgets/login_body_form.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final ValueNotifier<bool> _visibilityNotifier = ValueNotifier(true);
  late String phoneNum;
  late String password;

  @override
  void initState() {
    phoneNum = '';
    password = '';
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passController.dispose();
    _visibilityNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginUserCubit, LoginUserState>(
      listener: (context, state) {
        if (state is LoginUserSuccess) {
          showAppSnackBar(
            context,
            message: 'تم تسجيل الدخول بنجاح ياغالي',
            backgroundColor: kPrimColG,
          );
          if (isntNull(state.loggedUserEntiy.uProfileImage)) {
            context.go(AppRouter.kMainPage);
          } else {
            context.go(AppRouter.kAddPfpPage);
          }
        }
        if (state is LoginUserUnVerified) {
          showAppSnackBar(
            context,
            message: state.errMsg,
            backgroundColor: kPrimColG,
          );
          context.go(
            AppRouter.kVerifyMsgPage,
            extra: VerifyMsgViewModel(
              phone: phoneNum,
              pass: password,
              type: VerifyMsgType.logUsr,
            ),
          );
        }
        if (state is LoginUserFailure) {
          showAppSnackBar(context, message: state.errMsg);
        }
      },
      builder: (context, state) {
        if (state is LoginUserLoading) {
          return SizedBox(
            height: Funcs.respHieght(fract: 0.39, context: context),
            child: const Center(
              child: CircularProgressIndicator(color: kPrimColG),
            ),
          );
        }
        return Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: LoginBodyForm(
            phoneController: _phoneController,
            passController: _passController,
            vizibNotifier: _visibilityNotifier,
            phOnChanged: (number) {
              phoneNum = number;
            },
            passonChanged: (value) {
              password = value;
            },
            logOnPressed: () {
              if (formKey.currentState!.validate()) {
                BlocProvider.of<LoginUserCubit>(
                  context,
                ).loginUser(LoginReqModel(phoneNum, password));
              }
            },
          ),
        );
      },
    );
  }
}
