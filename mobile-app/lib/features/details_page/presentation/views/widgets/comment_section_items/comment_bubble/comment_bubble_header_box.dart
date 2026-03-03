import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/svg_ico.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/user_contacts_items/mini_named_avatar.dart';
import 'package:flutter/material.dart';

class CommentBubbleHeaderBox extends StatelessWidget {
  const CommentBubbleHeaderBox({
    super.key,
    required this.userName,
    required this.userImg,
    required this.postedAt,
  });
  final String userName, userImg, postedAt;
  @override
  Widget build(BuildContext context) {
    return TwoItmRow(
      mXAlign: MainAxisAlignment.spaceBetween,
      leftChild: const SvgIco(ico: AssetsData.more),
      rightChild: MiniNamedAvatar(
        circleSize: 25,
        username:
            'أضاف '
            '$userName'
            ' تعليقًا $postedAt',
        imgPath: userImg,
        txtStyle: FsC.colStH60(FStyles.s10w4.copyWith(height: 1.45)),
      ),
    );
  }
}
