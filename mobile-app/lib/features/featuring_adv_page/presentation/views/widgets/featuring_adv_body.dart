import 'package:dallal_proj/core/components/app_cards/package_card/package_card.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/constants/test_mock_models.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/core/widgets/text_widgets/body_text.dart';
import 'package:dallal_proj/core/widgets/text_widgets/right_main_title.dart';
import 'package:dallal_proj/features/featuring_adv_page/data/models/feature_adv_model.dart';
import 'package:dallal_proj/features/featuring_adv_page/presentation/manager/feature_the_adv_cubit/feature_the_adv_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeaturingAdvBody extends StatelessWidget {
  const FeaturingAdvBody({super.key, required this.adID});
  final String adID;

  @override
  Widget build(BuildContext context) {
    final double cSize = ((Funcs.respWidth(fract: 0.9, context: context)) / 3);
    return Column(
      children: [
        const Spacer(flex: 2),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: RightMainTitle(text: kFeaturinAdvPckg),
        ),
        const Spacer(flex: 1),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: BodyTxt(tAln: WidH.tra, text: kFeaturinAdvPckgBody),
        ),
        const Spacer(),
        const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: BodyTxt(tAln: WidH.tra, text: kChoosePackage),
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PckgCard(
              cWidth: cSize,
              pckgModel: kGoldenPckgModel,
              onTap: () {
                var user = getMeData();

                BlocProvider.of<FeatureTheAdvCubit>(context).featureTheAdv(
                  FeatureAdvModel(
                    adID: adID,
                    token: user!.uToken!,
                    packageID: '26',
                  ),
                );
              },
            ),
            PckgCard(
              cWidth: cSize,
              pckgModel: kSpecialPckgModel,
              onTap: () {
                var user = getMeData();

                BlocProvider.of<FeatureTheAdvCubit>(context).featureTheAdv(
                  FeatureAdvModel(
                    adID: adID,
                    token: user!.uToken!,
                    packageID: '25',
                  ),
                );
              },
            ),
            PckgCard(
              cWidth: cSize,
              pckgModel: kFundPckgModel,
              onTap: () {
                var user = getMeData();

                BlocProvider.of<FeatureTheAdvCubit>(context).featureTheAdv(
                  FeatureAdvModel(
                    adID: adID,
                    token: user!.uToken!,
                    packageID: '24',
                  ),
                );
              },
            ),
          ],
        ),
        const Spacer(flex: 7),
      ],
    );
  }
}
