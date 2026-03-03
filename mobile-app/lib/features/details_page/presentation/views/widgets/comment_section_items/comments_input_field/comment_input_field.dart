import 'package:dallal_proj/core/components/app_input_fields/bases/base_text_input.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/comment_section_items/helper/com_helper.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/comment_section_items/comments_input_field/post_btn.dart';
import 'package:flutter/material.dart';

class CommentInputField extends StatelessWidget {
  const CommentInputField({
    super.key,
    this.onSubmitted,
    this.onChanged,
    this.onTap,
    this.hint,
    this.maxLines,
  });
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? hint;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BTextInput(
        isEnabled: true,
        maxLines: maxLines,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        decoration: ComHelper.prefTxtInput(
          child: PostBtn(onTap: onTap),
          hint: hint,
        ),
      ),
    );
  }
}
