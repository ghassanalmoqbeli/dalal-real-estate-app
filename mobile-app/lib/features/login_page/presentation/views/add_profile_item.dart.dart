import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/utils/functions/get_safe_image_url.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AddProfileItem extends StatefulWidget {
  const AddProfileItem({
    super.key,
    required this.onImageChanged,
    this.initialImageUrl,
    this.size = 120.0,
    this.iconSize = 40.0,
    this.borderRadius = 360.0, // Fully circular by default
    this.enableEdit = true,
    this.showEditIcon = true,
  });

  final void Function(String? base64Image)? onImageChanged;
  final String? initialImageUrl;
  final double size;
  final double iconSize;
  final double borderRadius;
  final bool enableEdit;
  final bool showEditIcon;

  @override
  State<AddProfileItem> createState() => _AddProfileItemState();
}

class _AddProfileItemState extends State<AddProfileItem> {
  XFile? _selectedImage;
  String? _base64Image;
  String? _initialImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initialImage = widget.initialImageUrl;
    // If initialImageUrl is provided, we'll use it for display
    // But base64Image will be null until user picks a new image
  }

  Future<void> _pickImage() async {
    if (!widget.enableEdit) return;

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = pickedFile;
        });

        await _convertImageToBase64(pickedFile);
        widget.onImageChanged?.call(_base64Image);
      }
    } catch (e) {
      log('Error picking image: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _convertImageToBase64(XFile image) async {
    setState(() => _isLoading = true);
    try {
      final bytes = await image.readAsBytes();
      final base64String = base64Encode(bytes);
      setState(() {
        _base64Image = base64String;
      });
    } catch (e) {
      log('Error converting image to base64: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
      _base64Image = null;
      _initialImage = null;
    });
    widget.onImageChanged?.call(null);
  }

  Widget _buildImageContent() {
    // Priority 1: Selected local image (user just picked)
    if (_selectedImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Image.file(
          File(_selectedImage!.path),
          width: widget.size,
          height: widget.size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildErrorState(),
        ),
      );
    }

    // Priority 2: Base64 image (already converted)
    if (_base64Image != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Image.memory(
          base64Decode(_base64Image!),
          width: widget.size,
          height: widget.size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildErrorState(),
        ),
      );
    }

    // Priority 3: Initial image URL from server
    if (widget.initialImageUrl != null && widget.initialImageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: CachedNetworkImage(
          width: widget.size,
          height: widget.size,
          fit: BoxFit.cover,
          imageUrl: getSafeImageUrl(_initialImage), //widget.initialImageUrl!),
          placeholder: (context, url) => _buildLoadingState(),
          errorWidget: (context, url, error) => _buildPlaceholderState(),
        ),
      );
    }

    // Priority 4: Empty placeholder
    return _buildPlaceholderState();
  }

  Widget _buildPlaceholderState() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Container(
        width: widget.size,
        height: widget.size,
        color: Colors.grey[200],
        child:
            _isLoading
                ? _buildLoadingState()
                : Center(
                  child: Icon(
                    Icons.person_rounded,
                    size: widget.iconSize,
                    color: kPrimColG,
                  ),
                ),
      ),
    );
  }

  Widget _buildErrorState() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Container(
        width: widget.size,
        height: widget.size,
        color: Colors.green[200],
        child: Center(
          child: Icon(
            Icons.person_off_rounded,
            size: widget.iconSize,
            color: kPrimColG,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Container(
        width: widget.size,
        height: widget.size,
        color: Colors.grey[200],
        child: const Center(child: CircularProgressIndicator(color: kPrimColG)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Main Image Container
        GestureDetector(
          onTap: widget.enableEdit ? _pickImage : null,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: Border.all(color: Colors.grey[300]!, width: 2.0),
            ),
            child: _buildImageContent(),
          ),
        ),

        // Edit/Remove Button (floating)
        if (widget.enableEdit && widget.showEditIcon)
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                if (_selectedImage != null ||
                    _base64Image != null ||
                    (widget.initialImageUrl != null &&
                        widget.initialImageUrl!.isNotEmpty)) {
                  _removeImage();
                } else {
                  _pickImage();
                }
              },
              child: Container(
                width: widget.size * 0.3,
                height: widget.size * 0.3,
                decoration: BoxDecoration(
                  color: kPrimColG,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.0),
                ),
                child: Center(
                  child: Icon(
                    (_selectedImage != null ||
                            _base64Image != null ||
                            (widget.initialImageUrl != null &&
                                widget.initialImageUrl!.isNotEmpty))
                        ? Icons.close
                        : Icons.add_a_photo,
                    color: Colors.white,
                    size: widget.iconSize * 0.5,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
