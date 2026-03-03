import 'package:dallal_proj/core/components/app_input_fields/titled_text_form_field.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/widgets/inf_comp.dart';
import 'package:flutter/material.dart';

class PartsOfPropTextFormFields2 extends StatelessWidget {
  const PartsOfPropTextFormFields2({
    super.key,
    required this.title,
    required this.sectFwidth,
    this.onRoomsChanged,
    this.onLivingRoomsChanged,
    this.onBathroomsChanged,
    this.onKitchensChanged,
  });

  final String title;
  final double sectFwidth;
  final Function(String)? onRoomsChanged;
  final Function(String)? onLivingRoomsChanged;
  final Function(String)? onBathroomsChanged;
  final Function(String)? onKitchensChanged;

  @override
  Widget build(BuildContext context) {
    return InfComp(
      titleStyle: FStyles.s16w4,
      title: '$kPropSectF$title',
      child: VPItem(
        tSpc: 15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Rooms
            TitledTextFormField(
              title: 'غرف',
              hint: '0',
              onChange: onRoomsChanged ?? (value) {},
              inputFwidth: sectFwidth,
              keyboardType: TextInputType.number,
              tAln: TextAlign.center,
              tDir: TextDirection.ltr,
              mLth: 2,
              cXAl: CrossAxisAlignment.center,
            ),

            TitledTextFormField(
              title: 'صالات',
              hint: '0',
              onChange: onLivingRoomsChanged ?? (value) {},
              inputFwidth: sectFwidth,
              keyboardType: TextInputType.number,
              tAln: TextAlign.center,
              tDir: TextDirection.ltr,
              mLth: 2,
              cXAl: CrossAxisAlignment.center,
            ),

            TitledTextFormField(
              title: 'حمامات',
              hint: '0',
              onChange: onBathroomsChanged ?? (value) {},
              inputFwidth: sectFwidth,
              keyboardType: TextInputType.number,
              tAln: TextAlign.center,
              tDir: TextDirection.ltr,
              mLth: 2,
              cXAl: CrossAxisAlignment.center,
            ),

            TitledTextFormField(
              title: 'مطابخ',
              hint: '0',
              onChange: onKitchensChanged ?? (value) {},
              inputFwidth: sectFwidth,
              keyboardType: TextInputType.number,
              tAln: TextAlign.center,
              tDir: TextDirection.ltr,
              mLth: 2,
              cXAl: CrossAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
