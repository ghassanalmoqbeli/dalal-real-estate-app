import 'package:dallal_proj/core/constants/app_defs.dart';

String safeMergeUrl(String? suffix) {
  if (suffix == null || suffix.isEmpty) return kDomainApp;
  try {
    return Uri.parse(kDomainApp).resolve(suffix).toString();
  } catch (e) {
    return '$kDomainApp${suffix.startsWith('/') ? suffix : '/$suffix'}';
  }
}
