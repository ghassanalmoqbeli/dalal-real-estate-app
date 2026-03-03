import 'package:dallal_proj/core/components/app_bottom_sheets/bottom_sheet_holder.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/filter_b_s/filter_funcs.dart';
import 'package:dallal_proj/core/components/app_btns/col_btn.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/core/widgets/text_widgets/r_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showLoginRequiredBottomSheet(BuildContext context) {
  Fltr.callBottomSheet(
    context,
    child: BSFormHolder(
      form: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
            child: Center(
              child: RText(
                'عذراً يجب عليك تسجيل الدخول أولاً للتفاعل مع التطبيق والتمتع بكافة خدماته',
                TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  height: 2.30,
                ),
                tOvrFlw: TextOverflow.visible,
                txtAlign: TextAlign.center,
              ),
            ),
          ),
          VPItem(
            bSpc: 30,
            child: SizedBox(
              height: 50,
              child: ColBtn(
                txt: 'الذهاب لصفحة تسجيل الدخول',
                onPressed: () {
                  context.go(AppRouter.kLoginPage);
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
