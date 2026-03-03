import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/home_app_bar/items/home_app_bar_icon.dart';
import 'package:flutter/material.dart';

class NotiFavIcos extends StatelessWidget {
  const NotiFavIcos({
    super.key,
    required this.favOnPressed,
    required this.notifOnPressed,
    this.hasUnread = false,
  });

  final void Function()? favOnPressed;
  final void Function()? notifOnPressed;
  final bool hasUnread;

  @override
  Widget build(BuildContext context) {
    return TwoItmRow(
      mXSize: MainAxisSize.min,
      leftChild: HomeAppBarIcon(
        ico: AssetsData.favSectionSvg,
        onPressed: favOnPressed,
      ),
      rightChild: HomeAppBarIcon(
        ico: hasUnread ? AssetsData.unreadNotificSvg : AssetsData.readNotificSvg,
        onPressed: notifOnPressed,
      ),
    );
  }
}
