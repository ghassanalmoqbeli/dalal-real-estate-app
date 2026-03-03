import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:dallal_proj/core/components/app_btns/col_btn.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:flutter/material.dart';

class RegisterBtn extends StatelessWidget {
  const RegisterBtn({
    super.key,
    this.onPressed,
    this.size = const XBSize(width: 367),
  });
  final void Function()? onPressed;
  final XBSize size;

  @override
  Widget build(BuildContext context) {
    return ColBtn(txt: kCreateAccount, onPressed: onPressed, size: size);
  }
}

class PostAdvBtn extends StatelessWidget {
  const PostAdvBtn({
    super.key,
    this.onPressed,
    this.size = const XBSize(width: 367),
  });
  final void Function()? onPressed;
  final XBSize size;

  @override
  Widget build(BuildContext context) {
    return ColBtn(txt: kPostAdvBtn, onPressed: onPressed, size: size);
  }
}
