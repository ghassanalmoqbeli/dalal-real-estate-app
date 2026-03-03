import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_dets_helper.dart';
import 'package:flutter/material.dart';

class DetailDescBox extends StatelessWidget {
  const DetailDescBox({
    super.key,
    required this.children,
    this.backColor,
    this.brdrColor,
    this.shadowColor,
    this.outbxHPad,
    this.inbxHPad,
    this.inbxVPad,
    this.brdrRadius,
    this.brdrWidth,
  });
  final List<Widget> children;
  final Color? backColor, brdrColor, shadowColor;
  final double? outbxHPad, inbxHPad, inbxVPad, brdrRadius, brdrWidth;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: outbxHPad ?? 12.0),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: inbxHPad ?? 16.0,
          vertical: inbxVPad ?? 12.0,
        ),
        decoration: DetsHelper.getDescBoxShape(
          backColor: backColor,
          brdrColor: brdrColor,
          brdrWidth: brdrWidth,
          shadowColor: brdrColor,
          brdrRad: brdrRadius,
        ),
        child: Column(children: children),
      ),
    );
  }
}
