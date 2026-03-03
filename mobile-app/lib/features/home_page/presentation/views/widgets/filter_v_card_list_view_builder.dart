import 'package:dallal_proj/core/components/shimmer_widgets/v_card_shimmer/v_card_list_shimmer.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/v_card_list/v_card_list.dart';
import 'package:dallal_proj/features/sections_page/presentation/manager/fetch_filtered_result_cubit/fetch_filtered_result_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterVCardListBlocBuilder extends StatelessWidget {
  const FilterVCardListBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<FetchFilteredResultCubit, FetchFilteredResultState>(
        builder: (context, state) {
          if (state is FetchFilteredResultLoading) {
            return const VCardListShimmer();
          }
          if (state is FetchFilteredResultSuccess) {
            return FilterVCardList(detailsEntity: state.filterResult);
          }
          if (state is FetchFilteredResultIsEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text(state.emptyMsg)],
            );
          } else {
            return const SizedBox(
              height: 400,
              width: 300,
              child: Text(' failed'),
            );
          }
        },
      ),
    );
  }
}
