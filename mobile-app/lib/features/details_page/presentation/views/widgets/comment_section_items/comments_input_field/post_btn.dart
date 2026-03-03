import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/text_widgets/a_text.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/comment_section_items/comments_input_field/post_btn_box.dart';
import 'package:flutter/material.dart';

class PostBtn extends StatelessWidget {
  const PostBtn({super.key, required this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return PostBtnBox(
      child: AText(
        txt: kPost,
        style: FsC.colStW(FStyles.s12w5),
        mXSize: MainAxisSize.min,
      ),
    );
  }
}
