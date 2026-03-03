import 'package:dallal_proj/features/details_page/presentation/views/widgets/comment_section_items/comment_bubble/comment_bubble.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/comment_section_items/model/comment_model.dart';
import 'package:flutter/material.dart';

class CommentsListBuilder extends StatelessWidget {
  const CommentsListBuilder({super.key, required this.comModel});
  final List<CommentModel> comModel;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      padding: const EdgeInsets.only(top: 10),
      itemBuilder:
          (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: CommentBubble(comModel: comModel[index]),
          ),
    );
  }
}
