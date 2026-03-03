import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dallal_proj/features/home_page/domain/entities/banner_entity.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/adv_list/items/adv_item.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdvSlidingList extends StatelessWidget {
  const AdvSlidingList({super.key, required this.bannersList});
  final List<BannerEntity> bannersList;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: bannersList.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return AdvItemViewer(
          banner: bannersList[index],
          onTapBanner: () async {
            var url = bannersList[index].distBanUrl;
            log('Banner tapped! URL: $url');
            if (url != null && url.isNotEmpty) {
              // Add https:// if no scheme is present
              if (!url.startsWith('http://') && !url.startsWith('https://')) {
                url = 'https://$url';
              }
              log('Launching URL: $url');
              final uri = Uri.parse(url);
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            } else {
              log('No URL available for this banner');
            }
          },
        );
      },
      options: CarouselOptions(
        enlargeFactor: 0.4,
        height: 150,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
        onPageChanged: (index, reason) {},
      ),
    );
  }
}
