import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:flutter/material.dart';

class DeskMapImg extends StatelessWidget {
  const DeskMapImg({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Funcs.respWidth(fract: 0.17, context: context),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: AspectRatio(
          aspectRatio: 1.505,
          child: Image.asset(
            AssetsData.mapImg,
            fit: BoxFit.fill,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
