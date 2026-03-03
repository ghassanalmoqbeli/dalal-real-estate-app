import 'package:dallal_proj/core/components/app_btns/white_btn.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:flutter/material.dart';

class GuestBtn extends StatelessWidget {
  const GuestBtn({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return WhiteBtn(txt: kGuestMode, onPressed: onPressed);
  }
}
