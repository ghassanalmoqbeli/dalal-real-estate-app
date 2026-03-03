import 'package:dallal_proj/core/components/app_input_fields/bases/base_text_input.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/search_filter/items/suffix_text_icon.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    this.onSubmitted,
    this.onChanged,
    this.onTap,
    this.controller,
  });
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Funcs.respWidth(fract: 0.64, context: context),
      height: 44,
      child: BTextInput(
        controller: controller,
        isEnabled: true,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        decoration: Themer.sufTxtInput(
          child: SuffixTextIcon(onTap: onTap),
          hint: kHintSearchTextField,
        ),
      ),
    );
  }
}
