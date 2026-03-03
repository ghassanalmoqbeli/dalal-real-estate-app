import 'package:dallal_proj/core/common/models/filter_sheet_values.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/bottom_sheet_holder.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/filter_b_s/filter_form.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/search_filter/filter_button/filter_btn.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/search_filter/items/search_text_field.dart';
import 'package:dallal_proj/features/sections_page/data/models/filter_req_model.dart';
import 'package:flutter/material.dart';

class SearchFilterRow extends StatefulWidget {
  const SearchFilterRow({super.key, this.onFilterReady, this.initialFilter});
  final ValueChanged<FilterReqModel>? onFilterReady;
  final FilterReqModel? initialFilter;

  @override
  State<SearchFilterRow> createState() => _SearchFilterRowState();
}

class _SearchFilterRowState extends State<SearchFilterRow> {
  final TextEditingController _searchController = TextEditingController();
  late FilterSheetValues _filterValues;

  @override
  void initState() {
    super.initState();
    _filterValues = _initFromFilterReqModel(widget.initialFilter);
    // Set search text if available
    if (widget.initialFilter?.q != null) {
      _searchController.text = widget.initialFilter!.q!;
    }
  }

  FilterSheetValues _initFromFilterReqModel(FilterReqModel? model) {
    if (model == null) return FilterSheetValues();
    return FilterSheetValues(
      searchQuery: model.q,
      propertyTypes: model.propertyType ?? [],
      offerTypes: model.offerType ?? [],
      city: model.city,
      minPrice: model.minPrice,
      maxPrice: model.maxPrice,
      currency: model.currency,
      minArea: model.minArea,
      maxArea: model.maxArea,
      sortBy: FilterSheetValues.apiToDisplaySortBy(model.sortBy), // Convert API to display
      featuredOnly: model.featuredOnly ?? 0,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _updateSearchQuery(String query) {
    _filterValues.searchQuery = query.isNotEmpty ? query : null;
  }

  void _collectFilterValues(FilterSheetValues values) {
    _filterValues
      ..propertyTypes = values.propertyTypes
      ..offerTypes = values.offerTypes
      ..city = values.city
      ..minPrice = values.minPrice
      ..maxPrice = values.maxPrice
      ..currency = values.currency
      ..minArea = values.minArea
      ..maxArea = values.maxArea
      ..sortBy = values.sortBy
      ..featuredOnly = values.featuredOnly;
  }

  void _submitFilterValues(FilterSheetValues values) {
    // Update with final values
    _collectFilterValues(values);
    // Trigger navigation
    widget.onFilterReady?.call(_filterValues.toFilterReqModel());
  }

  Future<void> _showFilterBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet(
      useSafeArea: false,
      backgroundColor: kWhite,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      context: Navigator.of(context, rootNavigator: true).context,
      builder:
          (context) => BSFormHolder(
            form: FilterForm(
              withPropType: true,
              initialValues: _filterValues,
              onValuesChanged: _collectFilterValues,
              onSubmit: _submitFilterValues,
            ),
          ),
      sheetAnimationStyle: AnimationStyle(
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 500),
      ),
    );

    if (result is FilterSheetValues) {}
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Funcs.respWidth(fract: 0.03, context: context),
      ),
      child: TwoItmRow(
        mXAlign: MainAxisAlignment.spaceAround,
        leftChild: SearchTextField(
          controller: _searchController,
          onSubmitted: (value) {
            _updateSearchQuery(value);
            // Trigger navigation here
            widget.onFilterReady?.call(_filterValues.toFilterReqModel());
          },
          onChanged: _updateSearchQuery,
        ),
        rightChild: FilterBtn(onTap: () => _showFilterBottomSheet(context)),
      ),
    );
  }
}
