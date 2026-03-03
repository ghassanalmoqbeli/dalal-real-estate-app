import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_body_items/adv_details_body_titled_item.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/comment_section_items/comments_list_builder.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/comment_section_items/model/comment_model.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/comment_section_items/comments_box.dart';
import 'package:flutter/material.dart';

class AdvCommentsItem extends StatelessWidget {
  const AdvCommentsItem({super.key, required this.comList});
  final List<CommentModel> comList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: AdvDBTitledItem(
        title: kComments,
        titleRightPadding: 0,
        child: CommentsBox(child: CommentsListBuilder(comModel: comList)),
      ),
    );
  }
}
