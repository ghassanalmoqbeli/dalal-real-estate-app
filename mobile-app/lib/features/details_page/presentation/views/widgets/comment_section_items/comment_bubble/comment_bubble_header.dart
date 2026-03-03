import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/comment_section_items/comment_bubble/comment_bubble_header_box.dart';
import 'package:flutter/material.dart';

class CommentBubbleHeader extends StatelessWidget {
  const CommentBubbleHeader({
    super.key,
    required this.userName,
    this.userImg,
    this.postedAt,
  });
  final String userName;
  final String? userImg, postedAt;

  @override
  Widget build(BuildContext context) {
    return CommentBubbleHeaderBox(
      userName: userName,
      userImg: userImg ?? AssetsData.rUserAvatar,
      postedAt: postedAt ?? 'الآن',
    );
  }
}
