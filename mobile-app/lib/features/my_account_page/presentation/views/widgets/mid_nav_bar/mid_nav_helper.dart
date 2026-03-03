import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_shadows.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:flutter/material.dart';

class MidNavHelper {
  static ShapeDecoration btnLR(bool? isLeft, bool isSelected) {
    final rad = _midNavRad(isLeft);
    final col = isSelected ? kWhite : kPrimColG;
    return Themer.genShape(
      color: col,
      borderRadius: rad,
      shadows: [Shads.shadow4],
    );
  }

  static BorderRadius _midNavRad(bool? isLeft) => switch (isLeft) {
    null => BorderRadius.zero,
    true => _leftMidNavRad(),
    false => _rightMidNavRad(),
  };

  static BorderRadius _leftMidNavRad() => const BorderRadius.only(
    topLeft: Radius.circular(50),
    bottomLeft: Radius.circular(5),
  );

  static BorderRadius _rightMidNavRad() => const BorderRadius.only(
    topRight: Radius.circular(50),
    bottomRight: Radius.circular(5),
  );
}
