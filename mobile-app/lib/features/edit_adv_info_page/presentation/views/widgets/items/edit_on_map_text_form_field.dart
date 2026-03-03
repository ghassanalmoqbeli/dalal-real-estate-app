import 'package:dallal_proj/core/components/app_input_fields/titled_text_form_field.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/widgets/svg_ico.dart';
import 'package:flutter/material.dart';

class EditOnMapTextFormField extends StatefulWidget {
  const EditOnMapTextFormField({
    super.key,
    required this.initialValue,
    required this.textFwidth,
    required this.onChange,
    required this.gglOnTap,
  });

  final String initialValue;
  final double textFwidth;
  final Function(String) onChange;
  final void Function()? gglOnTap;

  @override
  State<EditOnMapTextFormField> createState() => _EditOnMapTextFormFieldState();
}

class _EditOnMapTextFormFieldState extends State<EditOnMapTextFormField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TitledTextFormField(
      controller: _controller,
      validator: (value) => null,
      tAln: TextAlign.left,
      tDir: TextDirection.ltr,
      title: kOnMap,
      inputFwidth: widget.textFwidth,
      onChange: widget.onChange,
      deco: Themer.sufTxtInput(
        hint: kOnMapHint,
        child: GestureDetector(
          onTap: widget.gglOnTap,
          child: const SvgIco(
            padding: 8,
            ico: AssetsData.crAdvGglMap,
            ht: 31,
            wth: 23,
          ),
        ),
        hintStyle: FsC.colSt(FStyles.s12w4, kGreyA60),
      ).copyWith(errorStyle: const TextStyle(height: 0, fontSize: 0)),
    );
  }
}
