import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/components/app_btns/svg_btn.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class BackAppBarBtn extends StatelessWidget {
  const BackAppBarBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgBtn(
      onPressed: () {
        if (Navigator.canPop(context)) {
          GoRouter.of(context).pop();
        } else {
          context.go(AppRouter.kPreRegisterPage);
        }
      },
      svg: AssetsData.backArrow,
      ht: 32,
      wth: 32,
    );
  }
}
