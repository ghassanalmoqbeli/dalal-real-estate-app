import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/home_app_bar/items/named_logo_mini.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/home_app_bar/items/noti_fav_icos.dart';
import 'package:flutter/material.dart';

class HomeAppBarIcos extends StatelessWidget {
  const HomeAppBarIcos({
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
      mXAlign: MainAxisAlignment.spaceBetween,
      leftChild: NotiFavIcos(
        favOnPressed: favOnPressed,
        notifOnPressed: notifOnPressed,
        hasUnread: hasUnread,
      ),
      rightChild: const MiniNamedLogo(),
    );
  }
}
