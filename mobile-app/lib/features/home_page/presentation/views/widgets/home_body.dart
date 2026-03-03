import 'dart:developer';

import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/features/home_page/presentation/manager/all_advs_cubit/all_advs_cubit.dart';
import 'package:dallal_proj/features/home_page/presentation/manager/all_banners_cubit/all_banners_cubit.dart';
import 'package:dallal_proj/features/home_page/presentation/manager/featured_advs_cubit/featured_advs_cubit.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/adv_list/cvp_item_bloc_builder.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/h_card_list_bloc_builder.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/v_card_list_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/home_text_widgets/all_props_text_wid.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/home_text_widgets/special_props_text_wid.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/search_filter/search_filter_row.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    // Refresh all data
    context.read<AllAdvsCubit>().fetchAllAdvs(null);
    context.read<FeaturedAdvsCubit>().fetchFeaturedAdvs(null);
    context.read<AllBannersCubit>().fetchAllBanners();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: kPrimColG,
      backgroundColor: kWhite,
      onRefresh: () => _onRefresh(context),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const CvpItemBlocBuilder(),
                SearchFilterRow(
                  onFilterReady: (filterModel) {
                    log(filterModel.toQueryParams());
                    GoRouter.of(context).pushNamed(
                      AppRouter.kSearchFilterPage,
                      extra: filterModel,
                    );
                  },
                ),
                const SpecialPropsTextWid(),
              ],
            ),
          ),
          const HCardListBlocBuilder(),
          const AllPropsTextWid(),
          const VCardListBlocBuilder(),
          // VCardListBlocBuilder(),
        ],
      ),
    );
  }
}
