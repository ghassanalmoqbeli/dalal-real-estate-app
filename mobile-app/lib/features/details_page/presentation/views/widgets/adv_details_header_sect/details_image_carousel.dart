import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_header_sect/crsl_img_holder.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_header_sect/smoth_pg_ind.dart';
import 'package:flutter/material.dart';

class AdvDetailsImgCarousel extends StatefulWidget {
  const AdvDetailsImgCarousel({
    super.key,
    required this.imagePaths,
    this.aspectRatio,
  });

  final List<String>? imagePaths;
  final double? aspectRatio;

  @override
  State<AdvDetailsImgCarousel> createState() => _AdvDetailsImgCarouselState();
}

class _AdvDetailsImgCarouselState extends State<AdvDetailsImgCarousel> {
  final ValueNotifier<int> _currentPage = ValueNotifier(0);
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aspectRatio = widget.aspectRatio ?? 1.7215;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        AspectRatio(
          aspectRatio: aspectRatio,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.imagePaths?.length ?? 1,
            onPageChanged: (index) => _currentPage.value = index,
            itemBuilder:
                (_, index) => CrslImgHolder(
                  widget: widget,
                  aspectRatio: aspectRatio,
                  index: index,
                ),
          ),
        ),
        Positioned(
          bottom: 12,
          child: ValueListenableBuilder<int>(
            valueListenable: _currentPage,
            builder:
                (_, value, __) =>
                    SmothPgInd(controller: _controller, widget: widget),
          ),
        ),
      ],
    );
  }
}
