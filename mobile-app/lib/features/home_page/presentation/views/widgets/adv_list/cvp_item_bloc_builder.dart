import 'package:dallal_proj/core/components/shimmer_widgets/adv_sliding_list_shimmer/adv_sliding_list_shimmer.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/cvp_item.dart';
import 'package:dallal_proj/features/home_page/presentation/manager/all_banners_cubit/all_banners_cubit.dart';
import 'package:dallal_proj/features/home_page/presentation/views/widgets/adv_list/adv_sliding_list.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CvpItemBlocBuilder extends StatelessWidget {
  const CvpItemBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllBannersCubit, AllBannersState>(
      builder: (context, state) {
        if (state is AllBannersSuccess) {
          return CvpItem(
            tFract: 0.0374,
            bFract: 0.0428,
            child: AdvSlidingList(bannersList: state.bannersEntity),
          );
        }
        if (state is AllBannersFailure) {
          return Center(
            child: SizedBox(
              child: Text(
                state.errMsg ?? 'Failed To Fetch Banners',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        }
        return const CvpItem(
          tFract: 0.0374,
          bFract: 0.0428,
          child: AdvSlidingListShimmer(),
        );
      },
    );
  }
}
