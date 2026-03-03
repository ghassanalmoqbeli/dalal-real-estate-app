import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:dallal_proj/core/components/app_btns/tcon_btn.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_header_sect/i_v_ico.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_header_sect/i_v_text.dart';
import 'package:flutter/material.dart';

class CardLikesBtnShimmer extends StatelessWidget {
  const CardLikesBtnShimmer({
    super.key,
    // required this.isLikedNotifier,
    required this.likesCount,
    required this.isLiked,
    this.radius,
    // this.onTap,
    this.mXAlign,
    required this.btnSize,
  });
  final String likesCount;
  // final ValueNotifier<bool> isLikedNotifier;
  final bool isLiked;
  final double? radius;
  // final void Function()? onTap;
  final MainAxisAlignment? mXAlign;
  final XBSize btnSize;

  @override
  Widget build(BuildContext context) {
    // return ValueListenableBuilder<bool>(
    // valueListenable: isLikedNotifier,
    // builder: (context, isVLiked, _) {
    return TconBtn(
      btnSize: btnSize,
      onTap: () {},
      // () {
      //   isLikedNotifier.value = !isVLiked;
      //   if (onTap != null) onTap!(); // optional external tap logic
      // },
      radius: radius,
      leftChild: IVIco(
        isActv: isLiked,
        ico: AssetsData.likeSvg,
        icoActv: AssetsData.likeFilled,
      ),
      rightChild: IVText(
        txt: likesCount,
        txtColor: kPrimColG,
        txtActvColor: kPrimColB,
        isActv: isLiked,
      ),
    );
  }
}
