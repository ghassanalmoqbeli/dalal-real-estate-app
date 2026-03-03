import 'package:dallal_proj/core/components/app_bottom_sheets/filter_b_s/filter_funcs.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/search_filter/filter_button/filter_btn_holder.dart';
import 'package:flutter/material.dart';

class FilterBtnBox extends StatelessWidget {
  const FilterBtnBox({super.key, required this.onTap, required this.isMinSize});

  final void Function()? onTap;
  final bool isMinSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(right: 5),
        height: 44,
        width: Fltr.btnWidth(isMinSize, context),
        decoration: Fltr.btnDeco(),
        child: FilterBtnHolder(isMinSize: isMinSize),
      ),
    );
  }
}
