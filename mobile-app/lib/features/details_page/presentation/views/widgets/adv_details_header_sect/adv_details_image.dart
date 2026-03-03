import 'package:dallal_proj/core/widgets/cust_img_holder.dart';
import 'package:flutter/material.dart';

class AdvDetailsImg extends StatelessWidget {
  const AdvDetailsImg({
    super.key,
    required this.img,
    this.aspect,
    this.radius,
    this.align,
  });
  final String? img;
  final double? aspect, radius;
  final AlignmentGeometry? align;
  @override
  Widget build(BuildContext context) {
    return CustImgHolder(radius: 8, aspect: aspect, img: img);
  }
}
