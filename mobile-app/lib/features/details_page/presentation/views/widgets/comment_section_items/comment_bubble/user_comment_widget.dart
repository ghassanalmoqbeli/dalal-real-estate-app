import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/comment_section_items/helper/com_helper.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/comment_section_items/helper/emb_text_link.dart';
import 'package:flutter/material.dart';

class UserComment extends StatelessWidget {
  const UserComment({super.key, this.postOwner, this.userComment});
  final String? postOwner;
  final String? userComment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 12, left: 8, top: 10, bottom: 6),
      decoration: ComHelper.userShape(),
      child: EmbTextLink(
        postOwner: postOwner ?? kPostOwnerNameError,
        userComment: userComment ?? kCommentErrorTemp,
      ),
    );
  }
}
