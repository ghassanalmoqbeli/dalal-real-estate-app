import 'package:flutter/material.dart';

class PlaceHolderImage extends StatelessWidget {
  const PlaceHolderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ShimmerWrapper(isWaving: false, child: Container(color: kWhite)),
        Opacity(opacity: 0.2, child: Container(color: Colors.green[200])),
        Center(
          child: Icon(
            Icons.image_not_supported,
            size: 40,
            color: Colors.green[200],
          ), // kPrimColG),
        ),
      ],
    );
  }
}
