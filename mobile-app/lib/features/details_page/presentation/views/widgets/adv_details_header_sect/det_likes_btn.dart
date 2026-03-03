import 'package:dallal_proj/core/components/app_bottom_sheets/log_required_b_s/show_log_required_b_s.dart';
import 'package:dallal_proj/core/components/app_cards/property_card/items/card_btns/card_likes_btn.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/details_page/presentation/manager/like_det_cubit/like_det_cubit.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_header_sect/i_v_ico.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_header_sect/i_v_text.dart';
import 'package:dallal_proj/features/home_page/data/models/interaction_req_model.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:dallal_proj/core/widgets/helpers/show_snack_bar.dart';
import 'package:dallal_proj/core/components/app_btns/tcon_btn.dart';
import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class DetLikesBtn extends StatelessWidget {
  const DetLikesBtn({
    super.key,
    required this.advListItem,
    this.radius,
    this.onTap,
    this.mXAlign,
    required this.btnSize,
  });
  final double? radius;
  final void Function()? onTap;
  final MainAxisAlignment? mXAlign;
  final XBSize btnSize;

  final ShowDetailsEntity advListItem;
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isLikedNotifier = ValueNotifier(
      advListItem.isLiked,
    );
    final ValueNotifier<String> likesCountNotifier = ValueNotifier(
      advListItem.likesCount ?? '0',
    );

    return BlocConsumer<LikeDetCubit, LikeDetState>(
      listener: (context, state) {
        if (state is LikeDetFailure) {
          showAppSnackBar(context, message: state.errMsg);
          isLikedNotifier.value = !isLikedNotifier.value;
          likesCountNotifier.value = getNewLikesCount(
            likesCountNotifier.value,
            isLikedNotifier.value,
          );
        }
        if (state is LikeDetSuccess) {
          showAppSnackBar(
            context,
            message: state.response.message ?? 'Success',
            backgroundColor: kPrimColG,
          );
        }
      },
      builder: (context, state) {
        return ValueListenableBuilder<bool>(
          valueListenable: isLikedNotifier,
          builder: (context, isVLiked, _) {
            return TconBtn(
              btnSize: btnSize,
              onTap: () {
                final user = getMeData();
                if (user != null) {
                  isLikedNotifier.value = !isVLiked;
                  likesCountNotifier.value = getNewLikesCount(
                    likesCountNotifier.value,
                    isLikedNotifier.value,
                  );

                  BlocProvider.of<LikeDetCubit>(context).toggleLike(
                    InteractionReqModel(
                      advID: advListItem.advId,
                      token: user.uToken,
                    ),
                    isVLiked,
                  );
                } else {
                  showLoginRequiredBottomSheet(context);
                }
              },
              radius: radius,
              leftChild: IVIco(
                isActv: isVLiked,
                ico: AssetsData.likeSvg,
                icoActv: AssetsData.likeFilled,
              ),
              rightChild: IVText(
                txt: likesCountNotifier.value,
                txtColor: kPrimColG,
                txtActvColor: kPrimColB,
                isActv: isVLiked,
              ),
            );
          },
        );
      },
    );
  }
}
