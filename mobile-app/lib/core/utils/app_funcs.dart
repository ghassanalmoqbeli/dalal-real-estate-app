import 'package:dallal_proj/core/constants/test_lists.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Funcs {
  static dynamic pushToAdv(
    BuildContext context,
    ShowDetailsEntity showDetailsEntity, {
    String? to,
  }) {
    return GoRouter.of(
      context,
    ).pushNamed(to ?? AppRouter.kAdvDetailsPage, extra: showDetailsEntity);
  }

  static void pushToPended(
    BuildContext context,
    // NCardModel nCard,
    // bool isMine,
    // bool isPended, {
    // String? to,
    // }
  ) {
    GoRouter.of(context).pop();
    GoRouter.of(context).pop();
    GoRouter.of(
      context,
    ).pushNamed(AppRouter.kAdvDetailsPage, extra: Tst.myAdsCardModel[1]);
  }

  static bool? isLeft(int index) =>
      index == 0
          ? true
          : index == 2
          ? false
          : null;

  static double respFMQ({
    required double itmFract,
    required BuildContext context,
  }) {
    return itmFract / respMQ(context: context);
  }

  static double respMQ({required BuildContext context}) {
    double x = (MediaQuery.of(context).size.width);
    double y = (MediaQuery.of(context).size.height);
    return x / y;
  }

  static double respWidth({
    required double fract,
    required BuildContext context,
  }) {
    return fract * MediaQuery.of(context).size.width;
  }

  static double aspInfWth({
    required double exWidth,
    required BuildContext context,
  }) {
    return respWidth(fract: respInfWp(exWidth, context), context: context);
  }

  /// returns relative fraction of width
  /// item [width] in figma ÷ screen width in figma
  static double getWfract(double width) => width / 440;

  /// returns relative fraction of height
  /// item [height] in figma ÷ screen width in figma
  static double getHfract(double height) => height / 956;

  /// takes item's [width] in figma and returns corresponding width
  /// ([getWfract] * [MediaQuery].width)
  static double frwGetter(double width, BuildContext context) =>
      respWidth(fract: getWfract(width), context: context);

  /// takes item's [height] in figma and returns corresponding height
  /// ([getHfract] * [MediaQuery].height)
  static double frhGetter(double height, BuildContext context) =>
      respHieght(fract: getHfract(height), context: context);

  static double respInfWp(double pads, BuildContext context) {
    return (1 - (pads / MediaQuery.of(context).size.width));
  }

  static double aspGetter(XBSize w2h) => w2h.width / w2h.height;

  static double respHieght({
    required double fract,
    required BuildContext context,
  }) {
    return fract * MediaQuery.of(context).size.height;
  }
}
