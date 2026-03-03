import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/user_contacts_items/mini_named_avatar.dart';
import 'package:flutter/material.dart';
import 'package:dallal_proj/core/widgets/helpers/s_bx.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/user_contacts_items/contacts_btns.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/desc_holder_items/details_desc_box.dart';

class ContactInfoCard extends StatelessWidget {
  const ContactInfoCard({
    super.key,
    this.whatsAppOnTap,
    this.smsOnTap,
    this.callOnTap,
    required this.contactedName,
    required this.imgPath,
  });
  final void Function()? whatsAppOnTap, smsOnTap, callOnTap;
  final String contactedName;
  final String? imgPath;
  @override
  Widget build(BuildContext context) {
    return DetailDescBox(
      backColor: kWhiteF9,
      children: [
        MiniNamedAvatar(imgPath: imgPath, username: contactedName),
        SBx.h20,
        ContactsBtns(
          callOnTap: callOnTap,
          whatsAppOnTap: whatsAppOnTap,
          smsOnTap: smsOnTap,
        ),
      ],
    );
  }
}
