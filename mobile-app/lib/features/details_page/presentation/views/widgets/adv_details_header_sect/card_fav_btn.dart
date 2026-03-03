import 'package:dallal_proj/core/components/app_bottom_sheets/log_required_b_s/show_log_required_b_s.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/details_page/presentation/manager/fave_det_cubit/fave_det_cubit.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_header_sect/i_v_ico.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_header_sect/i_v_text.dart';
import 'package:dallal_proj/features/home_page/data/models/interaction_req_model.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:dallal_proj/core/widgets/helpers/show_snack_bar.dart';
import 'package:dallal_proj/core/components/app_btns/tcon_btn.dart';
import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class CardFavBtn extends StatelessWidget {
  const CardFavBtn({
    super.key,
    required this.favBtnSize,
    this.onTap,
    required this.advListItem,
    this.radius,
    this.mXAlign,
  });
  final XBSize favBtnSize;
  final ShowDetailsEntity advListItem;
  final double? radius;
  final void Function()? onTap;
  final MainAxisAlignment? mXAlign;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isFavedNotifier = ValueNotifier(
      advListItem.isFaved,
    );

    return BlocConsumer<FaveDetCubit, FaveDetState>(
      listener: (context, state) {
        if (state is FaveDetFailure) {
          showAppSnackBar(context, message: state.errMsg);
          isFavedNotifier.value = !isFavedNotifier.value;
        }
        if (state is FaveDetSuccess) {
          // var meData = getMeData();
          // showAppSnackBar(
          //   context,
          //   message: state.response.message ?? 'Success',
          //   backgroundColor: kPrimColG,
          // );
        }
      },
      builder: (context, state) {
        return ValueListenableBuilder(
          valueListenable: isFavedNotifier,
          builder: (context, isVFaved, _) {
            return TconBtn(
              btnSize: favBtnSize,
              onTap: () {
                final user = getMeData();
                if (user != null) {
                  isFavedNotifier.value = !isVFaved;
                  BlocProvider.of<FaveDetCubit>(context).toggleFave(
                    InteractionReqModel(
                      advID: advListItem.advId,
                      token: user.uToken,
                    ),
                    isVFaved,
                  );
                } else {
                  showLoginRequiredBottomSheet(context);
                }
              },
              radius: radius,
              leftChild: IVText(
                txt: kFav,
                txtColor: kPrimColG,
                txtActvColor: kRed38,
                isActv: isVFaved,
                fontSize: 10,
              ),
              rightChild: IVIco(
                isActv: isVFaved,
                ico: AssetsData.faved,
                icoActv: AssetsData.favedfilled,
                icoWidth: 18,
                icoHeight: 18,
              ),
            );
          },
        );
      },
    );
  }
}
