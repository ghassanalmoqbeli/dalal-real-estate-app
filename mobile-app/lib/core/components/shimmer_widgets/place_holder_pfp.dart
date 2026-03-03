import 'package:cached_network_image/cached_network_image.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/core/utils/functions/get_safe_image_url.dart';
import 'package:flutter/material.dart';

class PlaceHolderPfp extends StatelessWidget {
  const PlaceHolderPfp({super.key, this.pfpSize});
  final double? pfpSize;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.grey.shade300),
        Center(
          child: Icon(
            Icons.person_rounded,
            size: pfpSize ?? 40,
            color: Colors.grey[700],
          ), // kPrimColG),
        ),
      ],
    );
  }
}

class PlaceHolderPff extends StatelessWidget {
  const PlaceHolderPff({
    super.key,
    this.rad,
    this.icoSize,
    this.onTap,
    this.img,
  });
  final double? rad;
  final double? icoSize;
  final Function()? onTap;
  final String? img;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(rad ?? 70)),
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: getSafeImageUrl(img),
          placeholder:
              (context, url) =>
                  url.isEmpty
                      ? NotFoundPFP(icoSize: icoSize, onTap: onTap)
                      : ErrorPFP(icoSize: icoSize), //ErrorImage(),
          errorWidget: (context, url, error) => ErrorPFP(icoSize: icoSize),
        ),
      ),
    );
  }
}

class ErrorPFP extends StatelessWidget {
  const ErrorPFP({super.key, this.icoSize});
  final double? icoSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ShimmerWrapper(isWaving: false, child: Container(color: kWhite)),
        Opacity(opacity: 0.2, child: Container(color: Colors.green[200])),
        Center(
          child: Icon(
            Icons.person_off_rounded,
            size: icoSize ?? 20,
            color: Colors.green[200],
          ), // kPrimColG),
        ),
      ],
    );
  }
}

class NotFoundPFP extends StatelessWidget {
  const NotFoundPFP({super.key, this.icoSize, this.onTap});
  final double? icoSize;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          // ShimmerWrapper(isWaving: false, child: Container(color: kWhite)),
          Opacity(opacity: 0.2, child: Container(color: Colors.grey[200])),
          Center(
            child: Icon(
              Icons.person_rounded,
              size: icoSize ?? 20,
              color: kPrimColG,
            ), // kPrimColG),
          ),
        ],
      ),
    );
  }
}

class PlaceHolderPfp2 extends StatelessWidget {
  const PlaceHolderPfp2({super.key, this.rad, this.onTap, this.icoSize});
  final double? rad;
  final double? icoSize;
  final Function()? onTap;
  // final BorderRadiusGeometry? borderRadius;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            color: Colors.grey.shade300,
            decoration: Themer.genShape(color: Colors.grey, rad: rad ?? 50),
          ),
          Center(
            child: Icon(
              Icons.person_rounded,
              size: icoSize ?? 40,
              color: kPrimColG, //Colors.grey[700],
            ), // kPrimColG),
          ),
        ],
      ),
    );
  }
}
