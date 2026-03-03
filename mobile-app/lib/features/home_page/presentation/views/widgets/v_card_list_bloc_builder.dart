import 'package:dallal_proj/core/components/shimmer_widgets/v_card_shimmer/v_card_list_shimmer.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/features/home_page/presentation/manager/all_advs_cubit/all_advs_cubit.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/v_card_list/v_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VCardListBlocBuilder extends StatelessWidget {
  const VCardListBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<AllAdvsCubit, AllAdvsState>(
        builder: (context, state) {
          if (state is AllAdvsLoading) {
            return const VCardListShimmer();
          }
          if (state is AllAdvsSuccess) {
            return VCardList(detailsEntity: state.allAdvsList);
          }
          if (state is AllAdvsFailure) {
            return SizedBox(
              height: 400,
              width: 300,
              child: Text(' ${state.errMsg}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(color: kPrimColG),
          );
        },
      ),
    );
  }
}
