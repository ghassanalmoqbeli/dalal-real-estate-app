import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/my_account_page/data/models/delete_adv_req_model.dart';
import 'package:dallal_proj/core/components/app_labels/long_header_lbl.dart';
import 'package:dallal_proj/core/components/app_labels/short_header_lbl.dart';
import 'package:dallal_proj/core/components/app_labels/lbl_helper.dart';
import 'package:dallal_proj/core/widgets/helpers/show_snack_bar.dart';
import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class AdvHeaderLbl extends StatelessWidget {
  const AdvHeaderLbl({
    super.key,
    required this.detailsEntity,
    required this.isPended,
    this.onTap,
  });
  final ShowDetailsEntity detailsEntity;
  final bool isPended;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    void isFeaturedSuccessfully(Object? result) {
      if (result != null) {
        var user = getMeData();
        if (result is bool && result == true) {
          GoRouter.of(context).push(
            AppRouter.kPackageDetailsPage,
            extra: DeleteAdvReqModel(
              adID: detailsEntity.advId,
              token: user!.uToken!,
            ),
          );
          showAppSnackBar(
            context,
            message: 'تم تمييز إعلانك بنجاح',
            backgroundColor: kPrimColG,
          );
        }
      }
    }

    return (isPended)
        ? LongHeaderLbl(onTap: () {}, lblModel: LblHelper.pndLblModel)
        : detailsEntity.isPremium
        ? ShortHeaderLbl(
          onTap:
              detailsEntity.isMine
                  ? () {
                    var user = getMeData();
                    GoRouter.of(context).push(
                      AppRouter.kPackageDetailsPage,
                      extra: DeleteAdvReqModel(
                        adID: detailsEntity.advId,
                        token: user!.uToken!,
                      ),
                    );
                  }
                  : () {},
          lblModel: LblHelper.prmLblModel,
        )
        : detailsEntity.isMine
        ? LongHeaderLbl(
          onTap: () async {
            final result = await GoRouter.of(
              context,
            ).push(AppRouter.kFeaturingAdvPage, extra: detailsEntity.advId);
            isFeaturedSuccessfully(result);
          },
          lblModel: LblHelper.getLblModel,
        )
        : const SizedBox();
  }
}
