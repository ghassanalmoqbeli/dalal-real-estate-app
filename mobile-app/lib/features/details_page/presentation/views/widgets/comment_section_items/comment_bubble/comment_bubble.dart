import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/comment_section_items/comment_bubble/comment_bubble_header.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/comment_section_items/model/comment_model.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/comment_section_items/comment_bubble/user_comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/comment_section_items/helper/com_helper.dart';

class CommentBubble extends StatelessWidget {
  const CommentBubble({super.key, required this.comModel});
  final CommentModel comModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20, right: 12, left: 9),
      decoration: ComHelper.cShape(),
      child: Column(
        children: [
          VPItem(
            bSpc: 20,
            child: CommentBubbleHeader(
              userName: comModel.userName,
              userImg: comModel.userImg,
              postedAt: comModel.postedAt,
            ),
          ),
          UserComment(
            userComment: comModel.userComment,
            postOwner: comModel.advOwner,
          ),
        ],
      ),
    );
  }
}
