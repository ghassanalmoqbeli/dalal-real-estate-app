import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/widgets/helpers/show_snack_bar.dart';
import 'package:dallal_proj/core/widgets/text_widgets/body_text.dart';
import 'package:dallal_proj/core/widgets/inf_comp.dart';
import 'package:dallal_proj/core/components/app_input_fields/phone_field/phone_field.dart';
import 'package:dallal_proj/core/widgets/text_widgets/right_main_title.dart';
import 'package:dallal_proj/core/components/app_btns/col_btn.dart';
import 'package:dallal_proj/features/verification_page/presentation/manager/send_otp_code_cubit/send_otp_code_cubit.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VerificationBody extends StatefulWidget {
  const VerificationBody({super.key});

  @override
  State<VerificationBody> createState() => _VerificationBodyState();
}

class _VerificationBodyState extends State<VerificationBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController _phoneController = TextEditingController();
  late String phoneNum;

  @override
  void initState() {
    phoneNum = '';
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendOtpCodeCubit, SendOtpCodeState>(
      listener: (context, state) {
        if (state is SendOtpCodeSuccess) {
          showAppSnackBar(
            context,
            message: state.response.message ?? 'تم ارسال رمز التحقق بنجاح',
            backgroundColor: kPrimColG,
          );
          GoRouter.of(context).push(
            AppRouter.kVerifyMsgPage,
            extra: VerifyMsgViewModel(
              phone: phoneNum,
              type: VerifyMsgType.resetPass,
            ),
          );
        }
        if (state is SendOtpCodeFailure) {
          showAppSnackBar(context, message: state.errMsg);
        }
      },
      builder: (context, state) {
        if (state is SendOtpCodeLoading) {
          return const Center(
            child: CircularProgressIndicator(color: kPrimColG),
          );
        }
        return Form(
          key: formKey,
          child: Column(
            children: [
              const Spacer(flex: 1),
              const RightMainTitle(text: kForgetPass),
              const Spacer(flex: 1),
              const BodyTxt(text: kVerificBodyTxt),
              const Spacer(flex: 1),
              InfComp(
                title: kPhoneNumber,
                child: PhoneField(
                  onChanged: (phone) {
                    phoneNum = phone;
                  },
                  phoneController: _phoneController,
                ),
              ),
              const Spacer(flex: 3),
              ColBtn(
                txt: kSndVrfiCode,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<SendOtpCodeCubit>(
                      context,
                    ).sendOtpCode(phoneNum);
                  }
                },
              ),
              const Spacer(flex: 11),
            ],
          ),
        );
      },
    );
  }
}
