import 'package:dallal_proj/core/components/app_bottom_sheets/log_required_b_s/show_log_required_b_s.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/core/widgets/cust_img_holder.dart';
import 'package:dallal_proj/core/components/app_cards/property_card/items/card_image/premium_label.dart';
import 'package:dallal_proj/core/components/app_cards/property_card/items/card_image/psnd_svg_btn.dart';
import 'package:dallal_proj/core/widgets/helpers/show_snack_bar.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/home_page/data/models/interaction_req_model.dart';
import 'package:dallal_proj/features/home_page/presentation/manager/fav_cubit/fav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardPropertyImage extends StatelessWidget {
  const CardPropertyImage({super.key, required this.advListItem, this.aspect});
  final ShowDetailsEntity advListItem;
  final double? aspect;
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isFavedNotifier = ValueNotifier(
      advListItem.isFaved,
    );

    return Stack(
      children: [
        CustImgHolder(
          img:
              (advListItem.imgs?.isNotEmpty ?? false)
                  ? advListItem.imgs![0].mediaUrl
                  : null,
          radius: 16,
          // align: Alignment.bottomCenter,
          aspect: aspect,
        ),
        if (advListItem.isPremium)
          const Positioned(top: 9, left: 10, child: PremiumLabel()),
        if (advListItem.advStatus == true)
          BlocConsumer<FaveCubit, FaveState>(
            listener: (context, state) {
              if (state is FaveFailure) {
                showAppSnackBar(context, message: state.errMsg);
                isFavedNotifier.value = !isFavedNotifier.value;
              }
              if (state is FaveSuccess) {
                // showAppSnackBar(
                //   context,
                //   message: state.response.message ?? 'Success',
                //   backgroundColor: kPrimColG,
                // );
                // isFavedNotifier.value = state.isFaved;
              }
            },
            builder: (context, state) {
              return ValueListenableBuilder<bool>(
                valueListenable: isFavedNotifier,
                builder: (context, isFaved, _) {
                  return PsndSvgBtn(
                    svg:
                        isFaved
                            ? AssetsData.filledHeartSvg
                            : AssetsData.heartSvg,
                    onPressed: () {
                      final user = getMeData();
                      if (user != null) {
                        isFavedNotifier.value = !isFavedNotifier.value;
                        BlocProvider.of<FaveCubit>(context).toggleFave(
                          InteractionReqModel(
                            advID: advListItem.advId,
                            token: user.uToken,
                          ),
                          isFaved,
                        );
                      } else {
                        showLoginRequiredBottomSheet(context);
                      }
                    },
                  );
                },
              );
            },
          ),
      ],
    );
  }
}
