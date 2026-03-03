import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:flutter/material.dart';

class PassInputBase extends StatelessWidget {
  final TextEditingController pController;
  final TextEditingController? originalController;
  final ValueNotifier<bool> visibilityNotifier;
  final Function(String)? onChanged;
  final String? Function(String?) validator;

  const PassInputBase({
    super.key,
    required this.pController,
    required this.originalController,
    required this.visibilityNotifier,
    this.onChanged,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: visibilityNotifier,
      builder: (context, isVisible, _) {
        return TextFormField(
          controller: pController,
          obscureText: isVisible,
          decoration: Themer.passInput(isVisible, () {
            visibilityNotifier.value = !visibilityNotifier.value;
          }),
          onChanged: onChanged,
          validator: validator,
        );
      },
    );
  }
}
