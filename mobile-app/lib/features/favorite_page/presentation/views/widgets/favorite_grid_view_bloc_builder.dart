import 'package:dallal_proj/core/components/shimmer_widgets/favorite_grid_view_shimmer.dart';
import 'package:dallal_proj/core/utils/functions/get_only_active_advs.dart';
import 'package:dallal_proj/core/widgets/helpers/show_snack_bar.dart';
import 'package:dallal_proj/features/favorite_page/presentation/manager/fetch_fav_advs_cubit/fetch_fav_advs_cubit.dart';
import 'package:dallal_proj/features/favorite_page/presentation/views/widgets/favorite_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteGridViewBlocBuilder extends StatelessWidget {
  const FavoriteGridViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchFavAdvsCubit, FetchFavAdvsState>(
      listener: (context, state) {
        if (state is FetchFavAdvsFailure) {
          showAppSnackBar(context, message: state.errMsg);
        }
      },
      builder: (context, state) {
        if (state is FetchFavAdvsSuccess) {
          return FavoriteGridView(favList: getOnlyActiveAds(state.favList));
        }
        if (state is FetchFavAdvsFailure) {
          return Center(child: Text(state.errMsg));
        }
        if (state is FetchFavAdvsIsEmpty) {
          return Center(child: Text(state.msg));
        }
        return const FavoriteGridViewShimmer();
      },
    );
  }
}
