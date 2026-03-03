import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:dallal_proj/core/components/app_input_fields/pass_fields/pass_field.dart';
import 'package:dallal_proj/core/components/app_input_fields/phone_field/phone_field.dart';
import 'package:dallal_proj/features/login_page/presentation/views/widgets/log_to_reg_leading_line.dart';
import 'package:dallal_proj/features/preregister/presentation/views/widgets/login_btn.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/core/widgets/text_widgets/text_link.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/widgets/inf_comp.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class LoginBodyForm extends StatelessWidget {
  const LoginBodyForm({
    super.key,
    required this.phoneController,
    required this.passController,
    required this.vizibNotifier,
    this.phOnChanged,
    this.passonChanged,
    this.logOnPressed,
  });
  final TextEditingController phoneController;
  final TextEditingController passController;
  final ValueNotifier<bool> vizibNotifier;
  final dynamic Function(String)? phOnChanged;
  final Function(String)? passonChanged;
  final Function()? logOnPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        VPItem(
          bSpc: 16,
          child: InfComp(
            title: kPhoneNumber,
            child: PhoneField(
              onChanged: phOnChanged,
              phoneController: phoneController,
            ),
          ),
        ),
        VPItem(
          bSpc: 16,
          child: InfComp(
            title: kPassword,
            child: PassField(
              controller: passController,
              visibilityNotifier: vizibNotifier,
              onChanged: passonChanged,
            ),
          ),
        ),
        TextLink(
          text: kDidForgetPass,
          onTap: () => GoRouter.of(context).push(AppRouter.kVerificationPage),
        ),
        VPItem(
          tSpc: 70,
          bSpc: 30,
          child: LoginBtn(
            onPressed: logOnPressed,
            size: const XBSize(width: 367, height: 58),
          ),
        ),
        const LogToRegLeadingLine(),
        const Spacer(),
      ],
    );
  }
}
