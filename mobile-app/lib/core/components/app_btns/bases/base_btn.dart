import 'package:dallal_proj/core/components/app_btns/btn_flex_box.dart';
import 'package:dallal_proj/core/widgets/text_widgets/a_text.dart';
import 'package:dallal_proj/core/components/app_btns/models/btn_model.dart';
import 'package:flutter/material.dart';

abstract class BaseBtn extends StatelessWidget {
  const BaseBtn({super.key});

  BtnModel buildModel(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final model = buildModel(context);
    return BtnFlexBox(
      btnSize: model.btnSize,
      radius: model.btnSize.radius,
      onTap: model.onPressed,
      btnCols: model.btnColors,
      deco: model.deco,
      child: AText(
        txt: model.text,
        style: model.txtStyle,
        mXAlign: MainAxisAlignment.center,
      ),
    );
  }
}
