import 'package:dallal_proj/core/components/app_bottom_sheets/filter_b_s/filter_form_items/filter_form_item.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/widgets/svg_ico.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:convert';
import 'dart:io';

class AddImgItem extends StatefulWidget {
  const AddImgItem({super.key, required this.onImagesChanged});

  final void Function(List<String> base64Images)? onImagesChanged;

  @override
  State<AddImgItem> createState() => _AddImgItemState();
}

class _AddImgItemState extends State<AddImgItem> {
  List<XFile> _selectedImages = [];
  List<String> _base64Images = [];
  final ValueNotifier<int> _currentPage = ValueNotifier(0);
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _currentPage.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile>? pickedFiles = await picker.pickMultiImage(
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        final List<XFile> limitedFiles =
            pickedFiles.length > 10 ? pickedFiles.sublist(0, 10) : pickedFiles;

        setState(() {
          _selectedImages = limitedFiles;
        });

        await _convertImagesToBase64(limitedFiles);
        widget.onImagesChanged?.call(_base64Images);
      }
    } catch (e) {
      log('Error picking images: $e');

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _convertImagesToBase64(List<XFile> images) async {
    _base64Images.clear();

    for (final image in images) {
      try {
        final bytes = await image.readAsBytes();
        final base64String = base64Encode(bytes);
        _base64Images.add(base64String);
      } catch (e) {
        log('Error converting image to base64: $e');
      }
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
      if (_base64Images.length > index) {
        _base64Images.removeAt(index);
      }

      if (_currentPage.value >= _selectedImages.length &&
          _selectedImages.isNotEmpty) {
        _currentPage.value = _selectedImages.length - 1;
      }
    });

    widget.onImagesChanged?.call(_base64Images);
  }

  @override
  Widget build(BuildContext context) {
    return FilterFormItem(
      style: FStyles.s16w4,
      height: Funcs.respWidth(fract: 0.534759, context: context),
      title: kAddImgVid,
      child: Column(
        children: [
          Expanded(
            child:
                _selectedImages.isEmpty
                    ? _buildPlaceholder()
                    : _buildImageCarousel(),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    final height = Funcs.respWidth(fract: 0.534759, context: context);
    return GestureDetector(
      onTap: _pickImages,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        height: height - 20,
        decoration: Themer.genShape(
          color: kGrite,
          side: Themer.brdSide(color: kWhiteF0),
        ),
        child: AspectRatio(
          aspectRatio: Funcs.aspInfWth(exWidth: 32, context: context) / 206,
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgIco(ico: AssetsData.crAdvAddImg, ht: 60, wth: 60),
                SizedBox(height: 8),
                Text(
                  'Tap to add images\n(Max 10 images)',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageCarousel() {
    final aspectRatio = Funcs.aspInfWth(exWidth: 32, context: context) / 206;
    final height = Funcs.respWidth(fract: 0.534759, context: context);

    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: height - 20,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _selectedImages.length,
              onPageChanged: (index) => _currentPage.value = index,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Stack(
                    children: [
                      // Image container
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: FileImage(File(_selectedImages[index].path)),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      // Delete button for THIS image
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => _removeImage(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.all(6),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Page indicator (only show if more than 1 image)
            if (_selectedImages.length > 1)
              Positioned(
                bottom: 12,
                left: 0,
                right: 0,
                child: Center(
                  child: ValueListenableBuilder<int>(
                    valueListenable: _currentPage,
                    builder: (_, value, __) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.circle, color: kPrimColG, size: 8),
                            const SizedBox(width: 4),
                            Text(
                              '${value + 1}/${_selectedImages.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

            // Add more button
            Positioned(
              bottom: 12,
              right: 12,
              child: GestureDetector(
                onTap: _pickImages,
                child: Container(
                  decoration: BoxDecoration(
                    color: kPrimColG,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
