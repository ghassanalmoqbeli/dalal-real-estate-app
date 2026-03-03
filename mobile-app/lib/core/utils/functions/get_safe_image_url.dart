import 'package:dallal_proj/core/utils/functions/safe_merge_url.dart';
import 'package:flutter/material.dart';

String getSafeImageUrl(String? suffix) {
  final url = safeMergeUrl(suffix);
  if (!(url.startsWith('http'))) {
    debugPrint('Warning: Image URL is not a web URL: $url');
    return '';
  }
  return url;
}
