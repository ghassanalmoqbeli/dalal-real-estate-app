import 'package:dallal_proj/features/home_page/presentation/views/widgets/search_filter/filter_button/filter_btn_box.dart';
import 'package:flutter/material.dart';

class FilterBtn extends StatelessWidget {
  const FilterBtn({super.key, this.isMinSize = true, this.onTap});
  final bool isMinSize;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return FilterBtnBox(onTap: onTap, isMinSize: isMinSize);
  }
}
