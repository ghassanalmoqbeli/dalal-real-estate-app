import 'package:dallal_proj/core/widgets/helpers/s_bx.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_header_sect/card_fav_btn.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_header_sect/card_share_btn.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_header_sect/det_likes_btn.dart';
import 'package:flutter/material.dart';

class DetailsBtns extends StatelessWidget {
  const DetailsBtns({
    super.key,
    required this.advDetailsEntity,
    required this.likeSize,
    this.shareOnTap,
    this.likeOnTap,
    this.shareSize,
    this.favOnTap,
    this.favSize,
  });
  final void Function()? likeOnTap, favOnTap, shareOnTap;
  final XBSize likeSize;
  final XBSize? favSize, shareSize;

  final ShowDetailsEntity advDetailsEntity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SBx.w15,
        DetLikesBtn(
          advListItem: advDetailsEntity,
          btnSize: likeSize,
          onTap: likeOnTap,
        ),
        SBx.w15,
        CardFavBtn(
          favBtnSize: favSize ?? likeSize,
          advListItem: advDetailsEntity,
          onTap: favOnTap,
        ),
        SBx.w15,
        CardShareBtn(shareBtnSize: shareSize ?? likeSize, onTap: shareOnTap),
      ],
    );
  }
}
