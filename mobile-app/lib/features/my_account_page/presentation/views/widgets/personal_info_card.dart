import 'dart:developer';

import 'package:dallal_proj/core/widgets/helpers/s_bx.dart';
import 'package:dallal_proj/features/login_page/presentation/views/add_profile_item.dart.dart';
import 'package:dallal_proj/features/my_account_page/presentation/views/widgets/personal_info_form.dart';
import 'package:flutter/material.dart';

class PersonalInfoCard extends StatelessWidget {
  const PersonalInfoCard({
    super.key,
    required this.name,
    required this.phone,
    this.whatsAppNum,
    this.img,
  });
  final String name, phone;
  final String? whatsAppNum, img;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PersonalInfoForm(
          name: name,
          phone: phone,
          whatsAppNum: whatsAppNum,
          withWhatsAppNum: (whatsAppNum != null) ? true : false,
        ),
        SBx.w15,
        AddProfileItem(
          enableEdit: false,
          showEditIcon: false,
          size: 100,
          initialImageUrl: img,
          onImageChanged: (base64Image) {
            log('Profile image selected: ${base64Image?.substring(0, 20)}...');
          },
        ),
      ],
    );
  }
}
