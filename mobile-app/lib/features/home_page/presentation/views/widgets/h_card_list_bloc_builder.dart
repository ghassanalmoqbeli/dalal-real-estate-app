import 'package:dallal_proj/core/components/shimmer_widgets/h_card_shimmer/h_card_list_shimmer.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/features/home_page/presentation/manager/featured_advs_cubit/featured_advs_cubit.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/h_card_list/h_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HCardListBlocBuilder extends StatelessWidget {
  const HCardListBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<FeaturedAdvsCubit, FeaturedAdvsState>(
        builder: (context, state) {
          if (state is FeaturedAdvsLoading) {
            return const HCardListShimmer();
          } else if (state is FeaturedAdvsSuccess) {
            return HCardList(advsList: state.featuredAdvsList);
          } else if (state is FeaturedAdvsSuccessLocal) {
            return HCardList(advsList: state.featuredAdvsList);
          } else if (state is FeaturedAdvsFailure) {
            return SizedBox(
              height: Funcs.respHieght(fract: 0.39, context: context),
              child: Text(state.errMsg),
            );
          }
          return SizedBox(
            height: Funcs.respHieght(fract: 0.39, context: context),
            child: const Center(
              child: CircularProgressIndicator(color: kPrimColG),
            ),
          );
        },
      ),
    );
  }
}
