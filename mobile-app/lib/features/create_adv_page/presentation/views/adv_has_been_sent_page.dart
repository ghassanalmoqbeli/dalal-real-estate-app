import 'package:dallal_proj/core/components/app_btns/col_btn.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/widgets/page_padding.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/core/widgets/text_widgets/body_text.dart';
import 'package:dallal_proj/core/widgets/text_widgets/right_main_title.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdvHasBeenSentPage extends StatelessWidget {
  const AdvHasBeenSentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagePadding(
        child: Column(
          children: [
            VPItem(tSpc: 40, child: Image.asset(AssetsData.crAdvCompletedGif)),
            const RightMainTitle(text: kCrAdvSentSuxss, isRight: false),
            const VPItem(
              tSpc: 20,
              child: BodyTxt(text: kCrAdvThx, tAln: TextAlign.right),
            ),
            const VPItem(
              tSpc: 20,
              child: BodyTxt(text: kCrAdvUrAdUnderRev, tAln: TextAlign.right),
            ),
            const Spacer(flex: 1),
            VPItem(
              bSpc: 40,
              child: ColBtn(
                txt: 'الذهاب إلى الصفحة الرئيسية',
                onPressed: () {
                  context.go(AppRouter.kMainPage);
                },
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
