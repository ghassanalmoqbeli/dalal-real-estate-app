import 'package:dallal_proj/core/common/models/filter_sheet_values.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/bottom_sheet_holder.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/filter_b_s/filter_form.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/widgets/helpers/s_bx.dart';
import 'package:dallal_proj/core/widgets/text_widgets/adv_result_item.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/search_filter/filter_button/filter_btn.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/v_card_list/v_card_list.dart';
import 'package:dallal_proj/features/sections_page/domain/entities/section_list_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SelectedSectionBody extends StatefulWidget {
  const SelectedSectionBody({
    super.key,
    this.advCount = '150',
    required this.sectionListEntity,
  });
  final String advCount;
  final SectionListEntity sectionListEntity;

  @override
  State<SelectedSectionBody> createState() => _SelectedSectionBodyState();
}

class _SelectedSectionBodyState extends State<SelectedSectionBody> {
  late FilterSheetValues _filterValues;

  @override
  void initState() {
    super.initState();
    // Initialize with the section's property type pre-selected
    _filterValues = FilterSheetValues(
      propertyTypes:
          widget.sectionListEntity.sectionName != null &&
                  widget.sectionListEntity.sectionName!.isNotEmpty
              ? [widget.sectionListEntity.sectionName!]
              : [],
    );
  }

  void _collectFilterValues(FilterSheetValues values) {
    _filterValues
      ..offerTypes = values.offerTypes
      ..city = values.city
      ..minPrice = values.minPrice
      ..maxPrice = values.maxPrice
      ..currency = values.currency
      ..minArea = values.minArea
      ..maxArea = values.maxArea
      ..sortBy = values.sortBy
      ..featuredOnly = values.featuredOnly;
    // Keep the property type from the section
    if (widget.sectionListEntity.sectionName != null &&
        widget.sectionListEntity.sectionName!.isNotEmpty) {
      _filterValues.propertyTypes = [widget.sectionListEntity.sectionName!];
    }
  }

  void _submitFilterValues(FilterSheetValues values) {
    _collectFilterValues(values);
    // Navigate to search filter page with the filter
    GoRouter.of(context).pushNamed(
      AppRouter.kSearchFilterPage,
      extra: _filterValues.toFilterReqModel(),
    );
  }

  Future<void> _showFilterBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      useSafeArea: false,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      context: Navigator.of(context, rootNavigator: true).context,
      builder:
          (context) => BSFormHolder(
            form: FilterForm(
              withPropType: false, // Property type is already set by section
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
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: _getSectFilterBtn(
            context,
            advCount: widget.sectionListEntity.advCount ?? '00',
            onTap: () => _showFilterBottomSheet(context),
          ),
        ),
        SliverToBoxAdapter(
          child: VCardList(detailsEntity: widget.sectionListEntity.advs),
        ),
        SliverToBoxAdapter(child: SBx.h30),
      ],
    );
  }

  SizedBox _topPadding(BuildContext context) =>
      SizedBox(height: Funcs.respHieght(fract: 0.054, context: context));

  Column _getSectFilterBtn(
    BuildContext context, {
    void Function()? onTap,
    required String advCount,
  }) => Column(
    children: [
      _topPadding(context),
      FilterBtn(isMinSize: false, onTap: onTap),
      VPItem(tSpc: 15, bSpc: 15, child: AdvResultsItem(advCount: advCount)),
    ],
  );
}
