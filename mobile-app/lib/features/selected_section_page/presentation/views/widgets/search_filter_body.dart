import 'package:dallal_proj/core/components/app_bottom_sheets/bottom_sheet_holder.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/filter_b_s/filter_form.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/filter_b_s/filter_funcs.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/widgets/helpers/s_bx.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/core/widgets/text_widgets/adv_result_item.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/filter_v_card_list_view_builder.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/search_filter/search_filter_row.dart';
import 'package:dallal_proj/features/sections_page/data/models/filter_req_model.dart';
import 'package:dallal_proj/features/sections_page/presentation/manager/fetch_filtered_result_cubit/fetch_filtered_result_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchFilterBody extends StatelessWidget {
  const SearchFilterBody({super.key, this.initialFilter});
  final FilterReqModel? initialFilter;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child:
              BlocBuilder<FetchFilteredResultCubit, FetchFilteredResultState>(
                builder: (context, state) {
                  String advCount = '0';
                  if (state is FetchFilteredResultSuccess) {
                    advCount = state.filterResult.advCount ?? '0';
                  }
                  return _getSearchtFilterItem(
                    context,
                    advCount: advCount,
                    onTap:
                        () => Fltr.callBottomSheet(
                          context,
                          child: BSFormHolder(
                            form: FilterForm(
                              onSubmit: (value) {},
                              withPropType: true,
                              onValuesChanged: (values) {},
                            ),
                          ),
                        ),
                  );
                },
              ),
        ),
        const FilterVCardListBlocBuilder(),
        SliverToBoxAdapter(child: SBx.h30),
      ],
    );
  }

  SizedBox _topPadding(BuildContext context) =>
      SizedBox(height: Funcs.respHieght(fract: 0.054, context: context));

  Column _getSearchtFilterItem(
    BuildContext context, {
    void Function()? onTap,
    required String advCount,
  }) => Column(
    children: [
      _topPadding(context),
      SearchFilterRow(
        initialFilter: initialFilter,
        onFilterReady: (v) {
          BlocProvider.of<FetchFilteredResultCubit>(
            context,
          ).fetchFilteredResult(v);
        },
      ),
      VPItem(tSpc: 15, bSpc: 15, child: AdvResultsItem(advCount: advCount)),
    ],
  );
}
