import 'package:flutter/material.dart';

class HeaderAttatchText extends StatelessWidget {
  const HeaderAttatchText({super.key});
  @override
  Widget build(BuildContext context) {
    return const Text(
      'لم يتم قبول إعلانك لأنه لا يطابق معايير النشر.',
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
    );
  }
}
