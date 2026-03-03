import 'package:dallal_proj/core/components/app_bottom_sheets/filter_b_s/filter_form_items/filter_form_item.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/entities/media_entity/media_entity.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/utils/functions/get_safe_image_url.dart';
import 'package:dallal_proj/core/widgets/svg_ico.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:convert';
import 'dart:io';

/// Image item widget for edit advertisement page.
/// Handles both existing images (URLs from server) and new images (local files to be uploaded as base64).
class EditAddImgItem extends StatefulWidget {
  const EditAddImgItem({
    super.key,
    required this.existingMedia,
    required this.onExistingImageRemoved,
    this.onNewImagesChanged,
  });

  /// List of existing media from the server
  final List<MediaEntity> existingMedia;

  /// Callback when user removes an existing image (by media ID)
  final void Function(int mediaId) onExistingImageRemoved;

  /// Callback when user picks new images (returns base64 strings)
  final void Function(List<String> base64Images)? onNewImagesChanged;

  @override
  State<EditAddImgItem> createState() => _EditAddImgItemState();
}

class _EditAddImgItemState extends State<EditAddImgItem> {
  // New images picked by user (local files)
  List<XFile> _newSelectedImages = [];
  List<String> _newBase64Images = [];

  final ValueNotifier<int> _currentPage = ValueNotifier(0);
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _currentPage.dispose();
    _pageController.dispose();
    super.dispose();
  }

  /// Total number of images (existing + new)
  int get _totalImages =>
      widget.existingMedia.length + _newSelectedImages.length;

  /// Check if we're currently showing an existing image
  bool _isExistingImage(int index) => index < widget.existingMedia.length;

  /// Pick new images from device
  Future<void> _pickNewImages() async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile>? pickedFiles = await picker.pickMultiImage(
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        // Calculate how many more images we can add (max 10 total)
        final int remainingSlots = 10 - _totalImages;
        if (remainingSlots <= 0) {
          _showMaxImagesWarning();
          return;
        }

        final List<XFile> limitedFiles =
            pickedFiles.length > remainingSlots
                ? pickedFiles.sublist(0, remainingSlots)
                : pickedFiles;

        setState(() {
          _newSelectedImages.addAll(limitedFiles);
        });

        await _convertNewImagesToBase64(limitedFiles);
        widget.onNewImagesChanged?.call(_newBase64Images);
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

  void _showMaxImagesWarning() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('الحد الأقصى 10 صور'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _convertNewImagesToBase64(List<XFile> newImages) async {
    for (final image in newImages) {
      try {
        final bytes = await image.readAsBytes();
        final base64String = base64Encode(bytes);
        _newBase64Images.add(base64String);
      } catch (e) {
        log('Error converting image to base64: $e');
      }
    }
  }

  /// Remove an existing image (mark for deletion on server)
  void _removeExistingImage(int index) {
    final media = widget.existingMedia[index];
    final mediaId = int.tryParse(media.mediaId ?? '');
    if (mediaId != null) {
      widget.onExistingImageRemoved(mediaId);
      // Adjust page if needed
      _adjustPageAfterRemoval();
    }
  }

  /// Remove a new image (not yet uploaded)
  void _removeNewImage(int localIndex) {
    setState(() {
      _newSelectedImages.removeAt(localIndex);
      if (_newBase64Images.length > localIndex) {
        _newBase64Images.removeAt(localIndex);
      }
    });
    widget.onNewImagesChanged?.call(_newBase64Images);
    _adjustPageAfterRemoval();
  }

  void _adjustPageAfterRemoval() {
    if (_currentPage.value >= _totalImages && _totalImages > 0) {
      _currentPage.value = _totalImages - 1;
      _pageController.jumpToPage(_currentPage.value);
    }
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
                _totalImages == 0 ? _buildPlaceholder() : _buildImageCarousel(),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    final height = Funcs.respWidth(fract: 0.534759, context: context);
    return GestureDetector(
      onTap: _pickNewImages,
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
                  'اضغط لإضافة صور\n(الحد الأقصى 10 صور)',
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
              itemCount: _totalImages,
              onPageChanged: (index) => _currentPage.value = index,
              itemBuilder: (context, index) {
                if (_isExistingImage(index)) {
                  return _buildExistingImageItem(index);
                } else {
                  final newIndex = index - widget.existingMedia.length;
                  return _buildNewImageItem(newIndex);
                }
              },
            ),

            // Page indicator (only show if more than 1 image)
            if (_totalImages > 1)
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
                            Icon(
                              Icons.circle,
                              color:
                                  _isExistingImage(value)
                                      ? Colors.blue
                                      : kPrimColG,
                              size: 8,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${value + 1}/$_totalImages',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _isExistingImage(value) ? '(موجودة)' : '(جديدة)',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

            // Add more button (only if under 10 images)
            if (_totalImages < 10)
              Positioned(
                bottom: 12,
                right: 12,
                child: GestureDetector(
                  onTap: _pickNewImages,
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

  /// Build an existing image item (from URL)
  Widget _buildExistingImageItem(int index) {
    final media = widget.existingMedia[index];
    final imageUrl = getSafeImageUrl(media.mediaUrl);

    log('Loading existing image: $imageUrl (original: ${media.mediaUrl})');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Stack(
        children: [
          // Image from URL
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: kGrite,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                placeholder:
                    (context, url) => const Center(
                      child: CircularProgressIndicator(color: kPrimColG),
                    ),
                errorWidget:
                    (context, url, error) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error, color: Colors.red),
                          const SizedBox(height: 4),
                          Text(
                            'فشل تحميل الصورة',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.red.shade300,
                            ),
                          ),
                        ],
                      ),
                    ),
              ),
            ),
          ),
          // "Existing" badge
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'موجودة',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
          // Delete button
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () => _removeExistingImage(index),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(6),
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build a new image item (from local file)
  Widget _buildNewImageItem(int newIndex) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Stack(
        children: [
          // Image from local file
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: FileImage(File(_newSelectedImages[newIndex].path)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // "New" badge
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: kPrimColG.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'جديدة',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
          // Delete button
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () => _removeNewImage(newIndex),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(6),
                child: const Icon(Icons.close, color: Colors.white, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
