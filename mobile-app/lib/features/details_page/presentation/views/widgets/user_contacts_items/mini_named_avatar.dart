import 'dart:developer';

import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/text_widgets/h_p_text.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:dallal_proj/features/login_page/presentation/views/add_profile_item.dart.dart';
import 'package:flutter/material.dart';

class MiniNamedAvatar extends StatelessWidget {
  const MiniNamedAvatar({
    super.key,
    required this.username,
    required this.imgPath,
    this.circleSize,
    this.svgHeight,
    this.svgWidth,
    this.txtStyle,
  });
  final String username;
  final String? imgPath;
  final double? circleSize, svgHeight, svgWidth;
  final TextStyle? txtStyle;
  @override
  Widget build(BuildContext context) {
    return TwoItmRow(
      mXAlign: MainAxisAlignment.end,
      leftChild: HPText(
        txt: username,
        style: txtStyle ?? FStyles.s14wB,
        rSpc: 15,
      ),
      rightChild: AddProfileItem(
        enableEdit: false,
        showEditIcon: false,
        size: circleSize ?? 65,
        initialImageUrl: imgPath,
        onImageChanged: (base64Image) {
          log('Profile image selected: ${base64Image?.substring(0, 20)}...');
        },
      ),
    );
  }
}
