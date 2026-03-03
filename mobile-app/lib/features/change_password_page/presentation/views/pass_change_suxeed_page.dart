import 'package:dallal_proj/core/widgets/text_widgets/right_main_title.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/core/widgets/text_widgets/body_text.dart';
import 'package:dallal_proj/core/components/app_btns/col_btn.dart';
import 'package:dallal_proj/core/widgets/page_padding.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/widgets/svg_ico.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class PassChangeSuxeedPage extends StatelessWidget {
  const PassChangeSuxeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagePadding(
        child: Column(
          children: [
            const SvgIco(ico: AssetsData.passChSux),
            const Spacer(flex: 1),
            const RightMainTitle(text: kPassChangeSuxeed, isRight: false),
            const VPItem(tSpc: 20, child: BodyTxt(text: kPassHasBeenChanged)),
            const Spacer(flex: 3),
            ColBtn(
              txt: kGoBackToLogin,
              onPressed: () => context.go(AppRouter.kLoginPage),
            ),
            const Spacer(flex: 5),
          ],
        ),
      ),
    );
  }
}
