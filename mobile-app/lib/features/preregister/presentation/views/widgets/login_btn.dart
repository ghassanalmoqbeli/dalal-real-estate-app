import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:dallal_proj/core/components/app_btns/col_btn.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:flutter/material.dart';

class LoginBtn extends StatelessWidget {
  const LoginBtn({super.key, this.onPressed, this.size});
  final void Function()? onPressed;
  final XBSize? size;

  @override
  Widget build(BuildContext context) {
    return ColBtn(
      txt: kLogin,
      onPressed: onPressed,
      size: size ?? const XBSize(width: 177),
    );
  }
}
