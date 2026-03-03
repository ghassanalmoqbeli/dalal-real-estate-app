import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/comment_section_items/helper/com_helper.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/comment_section_items/comments_input_field/comment_input_field.dart';
import 'package:flutter/material.dart';

class CommentsBox extends StatelessWidget {
  const CommentsBox({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ComHelper.commentsBox(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [const CommentInputField(hint: kWriteComment), child],
        ),
      ),
    );
  }
}
