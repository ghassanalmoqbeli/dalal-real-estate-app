import 'package:dallal_proj/constants.dart';
import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/features/more_page/presentation/views/widgets/items/box_holder.dart';
import 'package:dallal_proj/features/more_page/presentation/views/widgets/items/form_bars.dart';
import 'package:flutter/material.dart';

class LargeForm extends StatelessWidget {
  const LargeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final sPace = WidH.respSep(context, fract: 1);
    return BoxHolder(
      fixedSizeFraction: kMLFormFractMedium,
      aspect: kMFormWidthMedium / kMLFormHeight,
      children: [
        FBars.aboutUs(() {}),
        sPace,
        FBars.prvNpoltcs(() {}),
        sPace,
        FBars.condUsing(() {}),
        sPace,
        FBars.contactUs(() {}),
        sPace,
        FBars.rateUs(() {}),
        sPace,
        FBars.shareApp(() {}),
        sPace,
        FBars.appVersion(() {}),
      ],
    );
  }
}

///for Large form sizes recommendation:
////////////////// (abMedium) Guess-Working Sizes
///fixedSizeFraction:
///      fixedSizeFraction: 0.42, //(mLFormHeight / mScRespHeight) * /*implicitly*/ MediaQuery //implicitly,
///      aspect: mFormWidth / 367, //mFormWidth / mLFormHeight,
///             //mFormWidth = 382
//////////////////
////////////////// (subMedium) standard
///fixedSizeFraction:
///          0.383, //aspect of form height to screen height mSFormHeight / mScRespHeight,
///      aspect:
///          mFormWidth / 367,
///         //mFormWidth = 410
//////////////////

//     kMLFormFractMedium, //0.42, //0.415, mLFormHeight / mScRespHeight,
// aspect:
//     kMFormWidthMedium /
//     kMLFormHeight, //410ss / 367, //mFormWidth / mLFormHeight,
