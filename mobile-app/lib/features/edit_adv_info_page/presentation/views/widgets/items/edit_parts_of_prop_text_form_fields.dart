import 'package:dallal_proj/core/components/app_input_fields/titled_text_form_field.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/widgets/inf_comp.dart';
import 'package:flutter/material.dart';

class EditPartsOfPropTextFormFields extends StatefulWidget {
  const EditPartsOfPropTextFormFields({
    super.key,
    required this.initialRooms,
    required this.initialLivingRooms,
    required this.initialBathrooms,
    required this.initialKitchens,
    required this.title,
    required this.sectFwidth,
    this.onRoomsChanged,
    this.onLivingRoomsChanged,
    this.onBathroomsChanged,
    this.onKitchensChanged,
  });

  final String initialRooms;
  final String initialLivingRooms;
  final String initialBathrooms;
  final String initialKitchens;
  final String title;
  final double sectFwidth;
  final Function(String)? onRoomsChanged;
  final Function(String)? onLivingRoomsChanged;
  final Function(String)? onBathroomsChanged;
  final Function(String)? onKitchensChanged;

  @override
  State<EditPartsOfPropTextFormFields> createState() =>
      _EditPartsOfPropTextFormFieldsState();
}

class _EditPartsOfPropTextFormFieldsState
    extends State<EditPartsOfPropTextFormFields> {
  late TextEditingController _roomsController;
  late TextEditingController _livingRoomsController;
  late TextEditingController _bathroomsController;
  late TextEditingController _kitchensController;

  @override
  void initState() {
    super.initState();
    _roomsController = TextEditingController(text: widget.initialRooms);
    _livingRoomsController = TextEditingController(
      text: widget.initialLivingRooms,
    );
    _bathroomsController = TextEditingController(text: widget.initialBathrooms);
    _kitchensController = TextEditingController(text: widget.initialKitchens);
  }

  @override
  void dispose() {
    _roomsController.dispose();
    _livingRoomsController.dispose();
    _bathroomsController.dispose();
    _kitchensController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InfComp(
      titleStyle: FStyles.s16w4,
      title: '$kPropSectF${widget.title}',
      child: VPItem(
        tSpc: 15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Rooms
            TitledTextFormField(
              controller: _roomsController,
              title: 'غرف',
              hint: '0',
              onChange: widget.onRoomsChanged ?? (value) {},
              inputFwidth: widget.sectFwidth,
              keyboardType: TextInputType.number,
              tAln: TextAlign.center,
              tDir: TextDirection.ltr,
              mLth: 2,
              cXAl: CrossAxisAlignment.center,
            ),

            TitledTextFormField(
              controller: _livingRoomsController,
              title: 'صالات',
              hint: '0',
              onChange: widget.onLivingRoomsChanged ?? (value) {},
              inputFwidth: widget.sectFwidth,
              keyboardType: TextInputType.number,
              tAln: TextAlign.center,
              tDir: TextDirection.ltr,
              mLth: 2,
              cXAl: CrossAxisAlignment.center,
            ),

            TitledTextFormField(
              controller: _bathroomsController,
              title: 'حمامات',
              hint: '0',
              onChange: widget.onBathroomsChanged ?? (value) {},
              inputFwidth: widget.sectFwidth,
              keyboardType: TextInputType.number,
              tAln: TextAlign.center,
              tDir: TextDirection.ltr,
              mLth: 2,
              cXAl: CrossAxisAlignment.center,
            ),

            TitledTextFormField(
              controller: _kitchensController,
              title: 'مطابخ',
              hint: '0',
              onChange: widget.onKitchensChanged ?? (value) {},
              inputFwidth: widget.sectFwidth,
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
