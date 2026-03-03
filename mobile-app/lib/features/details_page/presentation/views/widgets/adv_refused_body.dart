import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_refused_body_items/header_attatch_text.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_refused_body_items/header_text.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_refused_body_items/refusal_msg.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_refused_body_items/text_clarify.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/bottom_sheet_btns.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/widgets/svg_ico.dart';
import 'package:flutter/material.dart';

class AdvRefusedBody extends StatelessWidget {
  const AdvRefusedBody({super.key, required this.detailsEntity});
  final ShowDetailsEntity detailsEntity;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: Funcs.respHieght(fract: 0.85, context: context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            const SvgIco(ico: AssetsData.refusedSvg, wth: 126.6, ht: 126.6),
            const Spacer(flex: 1),
            const HeaderText(),
            const Spacer(flex: 2),
            const HeaderAttatchText(),
            const Spacer(flex: 2),
            RefusalMsg(refuseReason: detailsEntity.refuseReason),

            const Spacer(flex: 10),
            const TextClarify(),
            const Spacer(flex: 2),
            BottomSheetBtns(
              rBtnTxt: 'حذف الإعلان',
              lBtnTxt: 'تعديل الإعلان',
              onTapR: () {
                Navigator.of(context).pop(true);
              },
              onTapL: () {
                Navigator.of(context).pop(false);
              },
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
