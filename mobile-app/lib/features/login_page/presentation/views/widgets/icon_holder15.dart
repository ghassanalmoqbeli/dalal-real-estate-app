import 'package:flutter/material.dart';

class IconHolder15 extends StatelessWidget {
  const IconHolder15({super.key, required this.path, this.onPressed});
  final String path;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: IconButton(onPressed: onPressed, icon: Image.asset(path)),
    );
  }
}
