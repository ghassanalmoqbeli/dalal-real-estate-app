import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_body_items/adv_details_body_titled_item.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/contact_info_card.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/material.dart';

class FContactBox extends StatelessWidget {
  const FContactBox({
    super.key,
    required this.user,
    this.smsOnTap,
    this.callOnTap,
    this.whatsAppOnTap,
  });
  final UserModel user;
  final void Function()? smsOnTap;
  final void Function()? callOnTap;
  final void Function()? whatsAppOnTap;

  @override
  Widget build(BuildContext context) {
    return AdvDBTitledItem(
      title: kContactOwner,
      child: ContactInfoCard(
        contactedName: user.fName,
        imgPath: user.img,
        smsOnTap: smsOnTap,
        callOnTap: callOnTap,
        whatsAppOnTap: whatsAppOnTap,
      ),
    );
  }
}
