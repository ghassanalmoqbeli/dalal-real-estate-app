import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_shadows.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/comment_section_items/model/comment_model.dart';
import 'package:flutter/material.dart';

const kCommentModel = CommentModel();

class ComHelper {
  static const List<CommentModel> commentsList = [
    kCommentModel,
    kCommentModel,
    kCommentModel,
    kCommentModel,
    kCommentModel,
    kCommentModel,
  ];

  static ShapeDecoration commentsBox() => Themer.genShape(
    color: kWhite,
    rad: 6,
    side: Themer.brdSide(
      width: 1,
      brdStyle: BorderStyle.solid,
      color: kWhiteF0,
    ),
    shadows: [Shads.shadow2(kBlackX28)],
  );

  static ShapeDecoration cShape() =>
      Themer.genShape(color: kWhite, shadows: [Shads.shadow4]);

  static ShapeDecoration userShape() =>
      Themer.genShape(color: kWhiteF6, shadows: [Shads.shadow12]);

  static InputDecoration prefTxtInput({
    required String? hint,
    required Widget child,
    TextStyle? hintStyle,
  }) {
    return Themer.txtInput(
      hint: hint,
      hintStyle: hintStyle,
    ).copyWith(prefixIcon: child);
  }
}
