import 'package:dallal_proj/core/widgets/custom_app_bar.dart';
import 'package:dallal_proj/features/sections_page/data/models/filter_req_model.dart';
import 'package:dallal_proj/features/selected_section_page/presentation/views/widgets/search_filter_body.dart';
import 'package:flutter/material.dart';

class SearchFilterPage extends StatelessWidget {
  const SearchFilterPage({super.key, this.initialFilter});
  final FilterReqModel? initialFilter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'فلترة وبحث'),
        body: SearchFilterBody(initialFilter: initialFilter),
      ),
    );
  }
}
