import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/widgets/named_logo.dart';
import 'package:dallal_proj/features/preregister/presentation/views/widgets/prp_text.dart';
import 'package:dallal_proj/features/preregister/presentation/views/widgets/reg_log_btns.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PreRegisterBody extends StatelessWidget {
  const PreRegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(flex: 7),
        const NamedLogo(isBlack: true),
        const Spacer(flex: 4),
        const PrpText(),
        const Spacer(flex: 4),
        RegLogBtns(
          onLogin: () => GoRouter.of(context).push(AppRouter.kLoginPage),
          onRegister: () => GoRouter.of(context).push(AppRouter.kRegisterPage),
          onGuest: () => context.go(AppRouter.kMainPage),
        ),
        const Spacer(flex: 8),
      ],
    );
  }
}
