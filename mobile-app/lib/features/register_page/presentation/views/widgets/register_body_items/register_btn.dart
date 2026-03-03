import 'package:dallal_proj/core/components/app_btns/col_btn.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:flutter/material.dart';

class RegisterBtn extends StatelessWidget {
  const RegisterBtn({super.key, this.onPressed});

  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ColBtn(txt: kCreateAccount, onPressed: onPressed);
  }
}
