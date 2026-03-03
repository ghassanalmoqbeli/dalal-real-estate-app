import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/theme/app_shadows.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:flutter/material.dart';

class Themer {
  static InputDecoration custInputDeco({
    String? hintText,
    Color? enCol,
    Color? fsCol,
    Color? brCol,
  }) {
    return InputDecoration(
      hintStyle: const TextStyle(fontSize: 12, color: kBlack38),
      hintText: hintText ?? '-',
      border: _outBorder(brCol, kBlack38),
      enabledBorder: _outBorder(enCol, kBlack54),
      errorBorder: _outBorder(null, kRed),
      focusedBorder: _outBorder(fsCol, kPrimColG, width: 1.5),
      disabledBorder: _outBorder(null, Colors.black26),
    );
  }

  static OutlineInputBorder _outBorder(
    Color? optCol,
    Color fndCol, {
    double width = 1.0,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: optCol ?? fndCol, width: width),
    );
  }

  static InputDecorationTheme menuTheme({Color? fillColor, Color? iconColor}) {
    final base = custInputDeco(enCol: fillColor ?? kWhiteF0);
    return InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      suffixIconColor: iconColor ?? kBlack,
      border: base.border,
      enabledBorder: base.enabledBorder,
      focusedBorder: base.focusedBorder,
      filled: true,
      fillColor: fillColor ?? kGrite,
    );
  }

  static InputDecoration customErrorInput({String? hintText}) {
    return custInputDeco(
      brCol: kRed,
      enCol: kRed,
      fsCol: kRed,
      hintText: hintText ?? '-',
    );
  }

  static MenuStyle menuStyle(BuildContext context) => MenuStyle(
    backgroundColor: const WidgetStatePropertyAll(kGrite),
    fixedSize: WidgetStatePropertyAll(
      Size(Funcs.respWidth(fract: 0.0, context: context), 208),
    ),
  );

  static InputDecoration txtInput({
    required String? hint,
    TextStyle? hintStyle,
  }) {
    final base = custInputDeco(
      hintText: hint,
      brCol: kWhiteF0,
      enCol: kWhiteF0,
    );
    return base.copyWith(
      filled: true,
      fillColor: kGrite,
      hintStyle: hintStyle ?? FsC.colStH(FStyles.s14W4),
      hintTextDirection: WidH.trd,
      // contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    );
  }

  static Decoration bard(Color? color, {double? radius, double? borderWidth}) {
    final bool isNull = borderWidth == null;
    return Themer.genShape(
      color: color ?? kWhite,
      rad: radius,
      side: Themer.brdSide(
        width: borderWidth,
        brdStyle: Themer.getBrdStyle(isNull),
      ),
      shadows: [Shads.shadow2(kBlackX28)],
    );
  }

  static BoxDecoration wallPaper() => const BoxDecoration(
    image: DecorationImage(
      image: AssetImage(AssetsData.bkgImg),
      fit: BoxFit.cover,
      opacity: 0.4,
    ),
  );

  static BoxDecoration numFieldCont() =>
      BoxDecoration(color: kTransP, boxShadow: [Shads.shadow2(null)]);

  static InputDecoration numInput(String hint, {TextStyle? hintStyle}) {
    final base = custInputDeco(enCol: kWhiteF0, hintText: hint);
    return base.copyWith(
      filled: true,
      fillColor: kGrite,
      // hintTextDirection: WidH.trd,//////////////////
      hintStyle: hintStyle ?? FsC.colSt(FStyles.s14W4, kGreyA60),
    );
  }

  static InputDecoration passInput(bool isObscure, void Function()? onPressed) {
    final base = custInputDeco(hintText: kPassTxtHnt);
    final ico = isObscure ? Icons.visibility_off : Icons.visibility;
    return base.copyWith(
      prefixIcon: IconButton(
        icon: Icon(ico, color: kBlack54),
        onPressed: onPressed,
      ),
    );
  }

  static InputDecoration verifiCodeInput() {
    final base = custInputDeco();
    return InputDecoration(
      counterText: '',
      border: base.border,
      focusedBorder: base.focusedBorder,
      enabledBorder: base.enabledBorder,
    );
  }

  static ShapeDecoration aiBtn(List<Color>? colors, double? rad) =>
      ShapeDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-1, -1),
          end: const Alignment(1, 1),
          colors: colors ?? kAiBtnColors,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rad ?? 8),
        ),
        shadows: const [Shads.shadow12],
      );

  static ShapeDecoration genShape({
    required Color color,
    double? rad = 8,
    BorderSide side = BorderSide.none,
    List<BoxShadow>? shadows,
    BorderRadiusGeometry? borderRadius,
  }) => ShapeDecoration(
    color: color,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(rad ?? 8),
      side: side,
    ),
    shadows: shadows,
  );

  static BorderSide brdSide({
    double? width = 1.0,
    Color? color = kBlack,
    BorderStyle brdStyle = BorderStyle.solid,
  }) => BorderSide(
    width: width ?? 0.0,
    color: color ?? kWhiteF0,
    style: brdStyle,
  );

  static InputDecoration sufTxtInput({
    required String? hint,
    required Widget child,
    TextStyle? hintStyle,
  }) {
    return Themer.txtInput(
      hint: hint,
      hintStyle: hintStyle,
    ).copyWith(suffixIcon: child);
  }

  static BorderStyle getBrdStyle(bool isNull) =>
      isNull ? BorderStyle.none : BorderStyle.solid;
}
