import 'package:flutter/material.dart';

class GradText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const GradText({
    required this.text,
    required this.gradient,
    required this.style,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(
        foreground:
            Paint()
              ..shader = gradient.createShader(
                Rect.fromLTWH(
                  0,
                  0,
                  text.length * style.fontSize!,
                  style.fontSize!,
                ),
              ),
      ),
    );
  }
}
