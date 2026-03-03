import 'package:cached_network_image/cached_network_image.dart';
import 'package:dallal_proj/core/components/shimmer_widgets/property_card_items/cust_img_holder_shimmer.dart';
import 'package:dallal_proj/core/components/shimmer_widgets/place_holder_image.dart';
import 'package:dallal_proj/core/constants/app_defs.dart';
import 'package:dallal_proj/core/utils/functions/get_safe_image_url.dart';
import 'package:flutter/material.dart';

class CustImgHolder extends StatelessWidget {
  const CustImgHolder({super.key, required this.img, this.aspect, this.radius});
  final String? img;
  final double? aspect, radius;
  @override
  Widget build(BuildContext context) {
    debugPrint(
      'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \n kDomain is: $kDomainApp \n img is: $img',
    );
    // final immg =
    //     '$kDomainApp'
    //     '$img';
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
      child: AspectRatio(
        aspectRatio: aspect ?? 9 / 7,
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: getSafeImageUrl(img),
          // (immg == 'https://dalal.ghassanalmoqbeli.comnull' ||
          //         img == 'null' ||
          //         img == null)
          //     ? ''
          //     : immg,
          placeholder:
              (context, url) =>
                  url.isEmpty
                      ? const PlaceHolderImage()
                      : const CustImgHolderShimmer(), //ErrorImage(),
          errorWidget: (context, url, error) => const PlaceHolderImage(),
        ),
        // (img != null)
        //     ? Image(
        //       image: NetworkImage(immg),
        //       fit: BoxFit.fill,
        //       alignment: align ?? Alignment.center,
        //     )
        //     : Image.asset(
        //       AssetsData.vPropertyPng,
        //       fit: BoxFit.fill,
        //       alignment: align ?? Alignment.center,
        //     ),
      ),
    );
  }
}
