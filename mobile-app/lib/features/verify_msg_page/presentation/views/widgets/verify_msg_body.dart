import 'package:dallal_proj/core/components/app_btns/col_btn.dart';
import 'package:dallal_proj/core/components/app_input_fields/verification_input/verification_code_field_box.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/widgets/helpers/show_snack_bar.dart';
import 'package:dallal_proj/features/verification_page/presentation/views/widgets/resend_text_widget.dart';
import 'package:dallal_proj/features/verify_msg_page/data/models/verify_model.dart';
import 'package:dallal_proj/features/verify_msg_page/presentation/manager/get_otp_code_cubit/get_otp_code_cubit.dart';
import 'package:dallal_proj/features/verify_msg_page/presentation/manager/resend_otp_code_cubit/resend_otp_code_cubit.dart';
import 'package:dallal_proj/features/verify_msg_page/presentation/manager/verify_otp_code_cubit/verify_otp_code_cubit.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/widgets/text_widgets/body_text.dart';
import 'package:dallal_proj/core/widgets/text_widgets/right_main_title.dart';
import 'package:dallal_proj/core/components/app_input_fields/verification_input/multi_code_fields.dart';

class VerifyMsgBody extends StatefulWidget {
  const VerifyMsgBody({super.key, required this.vMsgModel});
  final VerifyMsgViewModel vMsgModel;

  @override
  State<VerifyMsgBody> createState() => _VerifyMsgBodyState();
}

class _VerifyMsgBodyState extends State<VerifyMsgBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  late String verfCode;
  late String inputtedCode;
  late String verfCodeNotific;
  String sendOTPNotificationTest(String verifiCode) =>
      'Your Verification Code is: $verifiCode';

  @override
  void initState() {
    verfCode = '';
    inputtedCode = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetOtpCodeCubit, GetOtpCodeState>(
      listener: (context, state) {
        if (state is GetOtpCodeSuccess) {
          showAppSnackBar(
            context,
            message: sendOTPNotificationTest(state.otpCode),
            backgroundColor: kPrimColG,
            duration: const Duration(minutes: 2),
            showClose: true,
          );
          verfCode = state.otpCode;
        }
        if (state is GetOtpCodeFailure) {
          showAppSnackBar(context, message: state.errMsg);
        }
      },
      builder: (context, state) {
        if (state is GetOtpCodeLoading) {
          return const Center(
            child: CircularProgressIndicator(color: kPrimColG),
          );
        }
        return BlocConsumer<VerifyOtpCodeCubit, VerifyOtpCodeState>(
          listener: (context, state) {
            if (state is VerifyOtpCodeSuccess) {
              showAppSnackBar(
                context,
                message: 'تم التحقق بنجاح',
                backgroundColor: kPrimColG,
                duration: const Duration(seconds: 5),
              );
              (widget.vMsgModel.type == VerifyMsgType.resetPass)
                  ? GoRouter.of(context).push(
                    AppRouter.kResetPassPage,
                    extra: widget.vMsgModel.phone,
                  )
                  : (widget.vMsgModel.type == VerifyMsgType.logUsr ||
                      widget.vMsgModel.type == VerifyMsgType.verifyUser)
                  ? context.go(AppRouter.kLoginPage)
                  : GoRouter.of(context).pop();
            }
            if (state is VerifyOtpCodeFailure) {
              showAppSnackBar(context, message: state.errMsg);
            }
          },
          builder: (context, state) {
            if (state is VerifyOtpCodeLoading) {
              return const Center(
                child: CircularProgressIndicator(color: kPrimColG),
              );
            }
            return BlocConsumer<ResendOtpCodeCubit, ResendOtpCodeState>(
              listener: (context, state) {
                if (state is ResendOtpCodeSuccess) {
                  showAppSnackBar(
                    context,
                    message: state.response.message ?? 'Woooooooooooooof',
                    backgroundColor: kPrimColG,
                    duration: const Duration(seconds: 3),
                  );
                  BlocProvider.of<GetOtpCodeCubit>(
                    context,
                  ).getOtpCodeMsg(widget.vMsgModel.phone);
                }
                if (state is ResendOtpCodeFailure) {
                  showAppSnackBar(context, message: state.errMSg);
                }
              },
              builder: (context, state) {
                if (state is ResendOtpCodeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: kPrimColG),
                  );
                }
                return Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Spacer(flex: 1),
                      const RightMainTitle(text: kInputCode),
                      const Spacer(flex: 2),
                      const BodyTxt(text: kVrfyMsgBodyTxt),
                      const Spacer(flex: 3),
                      MultiCodeFields(
                        cLen: 5,
                        childBuilder: (
                          onChanged,
                          controller,
                          fNode,
                          codeLength,
                        ) {
                          void onChangeds(String value, int index) {
                            if (value.isNotEmpty && index < codeLength - 1) {
                              fNode[index + 1].requestFocus();
                            }
                            if (value.isEmpty && index > 0) {
                              fNode[index - 1].requestFocus();
                            }

                            inputtedCode = controller.map((c) => c.text).join();
                          }

                          return VrfCodeFieldBox(
                            codeLength: codeLength,
                            onChange: onChangeds,
                            controllers: controller,
                            focusNodes: fNode,
                          );
                        },
                        onCompleted: (v) {},
                      ),
                      const Spacer(flex: 2),
                      ResendTextWidget(
                        onTapResend: () {
                          BlocProvider.of<ResendOtpCodeCubit>(
                            context,
                          ).resendOtp(widget.vMsgModel.phone);
                        },
                        onTapWhatsApp: () {
                          GoRouter.of(context).pop();
                          GoRouter.of(context).push(
                            AppRouter.kVerifyMsgPage,
                            extra: widget.vMsgModel,
                          );
                        },
                      ),
                      const Spacer(flex: 2),
                      ColBtn(
                        txt: kConfirmCode,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (verfCode == inputtedCode) {
                              BlocProvider.of<VerifyOtpCodeCubit>(
                                context,
                              ).verifyOtp(
                                VerifyModel(
                                  widget.vMsgModel.phone,
                                  inputtedCode,
                                ),
                              );
                            } else {
                              showAppSnackBar(
                                context,
                                message: 'Wrong Verification Code',
                              );
                            }
                            // submit logic
                          }
                        },
                      ),
                      const Spacer(flex: 9),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
