import 'package:dallal_proj/core/components/app_cards/property_card/items/property_card_helper.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/components/app_cards/property_card/items/card_btns/card_seperated_btns_box.dart';
import 'package:dallal_proj/core/components/app_cards/property_card/h_card/pending_btn.dart';
import 'package:dallal_proj/core/components/app_cards/property_card/h_card/refused_btn.dart';
import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/my_account_page/data/models/delete_adv_req_model.dart';
import 'package:dallal_proj/features/my_account_page/presentation/manager/delete_adv_cubit/delete_adv_cubit.dart';
import 'package:dallal_proj/features/my_account_page/presentation/manager/user_profile_cubit/user_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyAdvSeperatedBtns extends StatelessWidget {
  const MyAdvSeperatedBtns({
    super.key,
    this.sepWidth,
    required this.detailsEntity,
  });
  final ShowDetailsEntity detailsEntity;
  // final NCardModel cardModel;
  final double? sepWidth;
  @override
  Widget build(BuildContext context) {
    void deleteAdv() {
      // var user = getMeData();
      var user = getMeData();
      BlocProvider.of<DeleteAdvCubit>(context).deleteAdv(
        DeleteAdvReqModel(adID: detailsEntity.advId, token: user!.uToken!),
      );
    }

    Future<dynamic> refreshAdvs() async {
      var user = getMeData();
      BlocProvider.of<UserProfileCubit>(context).fetchUserProfile(user!.uToken);
      // return result;
    }

    Future<dynamic> editedAdv() async {
      // var user = getMeData();

      var result = await GoRouter.of(
        context,
      ).push(AppRouter.kEditAdvPage, extra: detailsEntity);
      // BlocProvider.of<UserProfileCubit>(context).fetchUserProfile(user!.uToken);
      return result;
    }

    return SeperatedBtnsBox(
      rMXAlign:
          // (cardModel.status == true)
          // ? MainAxisAlignment.spaceEvenly
          MainAxisAlignment.center,
      children:
          (detailsEntity.advStatus == true)
              ? PCardH.normalAdvBtns(
                () => Funcs.pushToAdv(context, detailsEntity), // true, false),
                () {
                  deleteAdv();
                }, //deleteOnTap
                () async {
                  var result = await editedAdv();
                  if (result != null) {
                    if (result == true) {
                      refreshAdvs();
                    }
                  }
                }, //editOnTap
              )
              : (detailsEntity.advStatus == null)
              ? [
                PendingBtn(
                  onTap: () => Funcs.pushToAdv(context, detailsEntity),
                ),
              ]
              : [
                RefusedBtn(
                  onTap: () async {
                    var result = await Funcs.pushToAdv(
                      context,
                      detailsEntity,
                      to: AppRouter.kAdvRefusedPage,
                    );
                    if (result != null) {
                      if (result == true) {
                        deleteAdv();
                      } else if (result == false) {
                        var editResult = await editedAdv();
                        if (editResult != null) {
                          if (editResult == true) {
                            refreshAdvs();
                          }
                        }
                      }
                    } else {
                      debugPrint('YYYYYYYYYYYY');
                    }
                  },
                ),
              ],
    );
  }
}
