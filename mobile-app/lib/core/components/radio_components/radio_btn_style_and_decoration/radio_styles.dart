import 'package:dallal_proj/core/components/radio_components/radio_btn_style_and_decoration/radio_decorations.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';

abstract class RStyles {
  static var activeTheme = RBDeco.rActive(kPrimColG);
  static var activeRTheme = RBDeco.rActive(kPrimColR2A, bgCol: kWhite);
  static var inActiveTheme = RBDeco.rInActive(null);
}
