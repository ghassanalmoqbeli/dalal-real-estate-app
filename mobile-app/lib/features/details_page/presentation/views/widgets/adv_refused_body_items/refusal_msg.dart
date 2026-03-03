import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/desc_holder_items/v_desc_item.dart';
import 'package:flutter/material.dart';

class RefusalMsg extends StatelessWidget {
  const RefusalMsg({super.key, this.refuseReason});
  final String? refuseReason;

  @override
  Widget build(BuildContext context) {
    return VDescItem(
      head: kHead,
      body: '',
      tail: refuseReason ?? 'لا يوجد سبب',
      hStyle: FStyles.s18w6,
      bStyle: FStyles.s18w4,
      tStyle: FStyles.s18w4,
    );
  }
}
