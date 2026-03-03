import 'package:dallal_proj/core/components/app_input_fields/titled_text_form_field.dart';
import 'package:dallal_proj/core/entities/media_entity/media_entity.dart';
import 'package:dallal_proj/features/create_adv_page/presentation/views/widgets/cr_adv_helper.dart';
import 'package:dallal_proj/features/edit_adv_info_page/presentation/views/widgets/items/edit_add_img_item.dart';
import 'package:dallal_proj/features/edit_adv_info_page/presentation/views/widgets/items/edit_adress_text_form_field.dart';
import 'package:dallal_proj/features/edit_adv_info_page/presentation/views/widgets/items/edit_area_text_form_field.dart';
import 'package:dallal_proj/features/edit_adv_info_page/presentation/views/widgets/items/edit_ct_drop.dart';
import 'package:dallal_proj/features/edit_adv_info_page/presentation/views/widgets/items/edit_floors_text_form_field.dart';
import 'package:dallal_proj/features/edit_adv_info_page/presentation/views/widgets/items/edit_loc_map_text_form_fields.dart';
import 'package:dallal_proj/features/edit_adv_info_page/presentation/views/widgets/items/edit_parts_of_prop_text_form_fields.dart';
import 'package:dallal_proj/features/edit_adv_info_page/presentation/views/widgets/items/edit_price_t_f_f.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/core/constants/mock_models.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:flutter/material.dart';

class EditAdvBodyForm extends StatelessWidget {
  const EditAdvBodyForm({
    super.key,
    // Initial values
    required this.initialTitle,
    required this.initialCity,
    required this.initialArea,
    required this.initialLocation,
    required this.initialMapLink,
    required this.initialFloors,
    required this.initialRooms,
    required this.initialLivingRooms,
    required this.initialBathrooms,
    required this.initialKitchens,
    required this.initialPrice,
    required this.initialCurrency,
    required this.initialExtraDetails,
    // Existing media
    required this.existingMedia,
    required this.onExistingImageRemoved,
    // New images callback
    this.onNewImagesChanged,
    // Form callbacks
    required this.adrOnChange,
    required this.adrFwidth,
    required this.ctOnSelected,
    required this.areaOnChange,
    required this.textFwidth,
    required this.locOnChange,
    required this.mapOnChange,
    required this.gglOnTap,
    required this.selectedOpt,
    required this.offerOnTapped,
    required this.flrsOnChange,
    required this.title,
    required this.sectFwidth,
    required this.crnOnSelected,
    required this.priceOnChanged,
    required this.selectedOptB,
    required this.negotOnTapped,
    required this.mdetsOnChanged,
    required this.updateOnPressed,
    this.onBathroomsChanged,
    this.onRoomsChanged,
    this.onKitchensChanged,
    this.onLivingRoomsChanged,
  });

  // Initial values from entity
  final String initialTitle;
  final String initialCity;
  final String initialArea;
  final String initialLocation;
  final String initialMapLink;
  final String initialFloors;
  final String initialRooms;
  final String initialLivingRooms;
  final String initialBathrooms;
  final String initialKitchens;
  final String initialPrice;
  final String initialCurrency;
  final String initialExtraDetails;

  // Existing media handling
  final List<MediaEntity> existingMedia;
  final void Function(int mediaId) onExistingImageRemoved;
  final void Function(List<String> base64Images)? onNewImagesChanged;

  // Form callbacks
  final Function(String) adrOnChange;
  final double adrFwidth;
  final Function(String?)? ctOnSelected;
  final Function(String) areaOnChange;
  final double textFwidth;
  final Function(String) locOnChange;
  final Function(String) mapOnChange;
  final Function() gglOnTap;
  final ValueNotifier<String> selectedOpt;
  final Function(String)? offerOnTapped;
  final Function(String) flrsOnChange;
  final String title;
  final double sectFwidth;
  final Function(String?)? crnOnSelected;
  final Function(String)? priceOnChanged;
  final ValueNotifier<String> selectedOptB;
  final Function(String)? negotOnTapped;
  final Function(String)? mdetsOnChanged;
  final Function() updateOnPressed;
  final Function(String)? onBathroomsChanged;
  final Function(String)? onRoomsChanged;
  final Function(String)? onKitchensChanged;
  final Function(String)? onLivingRoomsChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Image carousel with existing images and add new images capability
        VPItem(
          bSpc: 20,
          child: EditAddImgItem(
            existingMedia: existingMedia,
            onExistingImageRemoved: onExistingImageRemoved,
            onNewImagesChanged: onNewImagesChanged,
          ),
        ),
        // Title/Address field
        VPItem(
          bSpc: 20,
          child: EditAdressTextFormField(
            initialValue: initialTitle,
            onChange: adrOnChange,
            adrFwidth: adrFwidth,
          ),
        ),
        // City dropdown
        VPItem(
          bSpc: 20,
          child: EditCtDrop(initialCity: initialCity, onSelected: ctOnSelected),
        ),
        // Area field
        VPItem(
          bSpc: 20,
          child: EditAreaTextFormField(
            initialValue: initialArea,
            onChange: areaOnChange,
          ),
        ),
        // Location and Map URL fields
        VPItem(
          bSpc: 35,
          child: EditLocMapTextFormFields(
            initialLocation: initialLocation,
            initialMapLink: initialMapLink,
            textFwidth: textFwidth,
            locOnChange: locOnChange,
            mapOnChange: mapOnChange,
            gglOnTap: gglOnTap,
          ),
        ),
        // Offer type radio
        VPItem(
          bSpc: 35,
          child: CrAdvHelper.radCrAdv(
            selectedOpt,
            offerOnTapped,
            kOfferCkbModel,
          ),
        ),
        // Floors (only for houses)
        if (title == kHouse)
          VPItem(
            bSpc: 30,
            child: EditFloorsTFF(
              initialValue: initialFloors,
              onChange: flrsOnChange,
            ),
          ),
        // Parts of property (rooms, bathrooms, etc.)
        if (title == kHouse || title == kApt)
          VPItem(
            bSpc: 30,
            child: EditPartsOfPropTextFormFields(
              initialRooms: initialRooms,
              initialLivingRooms: initialLivingRooms,
              initialBathrooms: initialBathrooms,
              initialKitchens: initialKitchens,
              onBathroomsChanged: onBathroomsChanged,
              onKitchensChanged: onKitchensChanged,
              onLivingRoomsChanged: onLivingRoomsChanged,
              onRoomsChanged: onRoomsChanged,
              title: title,
              sectFwidth: sectFwidth,
            ),
          ),
        // Price field
        VPItem(
          bSpc: 30,
          child: EditPriceTFF(
            initialPrice: initialPrice,
            initialCurrency: initialCurrency,
            crnOnSelected: crnOnSelected,
            priceOnChanged: priceOnChanged,
          ),
        ),
        // Negotiable radio
        VPItem(
          bSpc: 30,
          child: CrAdvHelper.radCrAdv(selectedOptB, negotOnTapped, kIsNegot),
        ),
        // Extra details
        VPItem(
          tSpc: 20,
          bSpc: 80,
          child: _EditExtraDetailsField(
            initialValue: initialExtraDetails,
            onChange: mdetsOnChanged,
          ),
        ),
        // Update button
        Align(
          alignment: Alignment.center,
          child: VPItem(
            bSpc: 20,
            child: _UpdateAdvBtn(onPressed: updateOnPressed),
          ),
        ),
      ],
    );
  }
}

/// Extra details text field with initial value
class _EditExtraDetailsField extends StatefulWidget {
  const _EditExtraDetailsField({required this.initialValue, this.onChange});

  final String initialValue;
  final Function(String)? onChange;

  @override
  State<_EditExtraDetailsField> createState() => _EditExtraDetailsFieldState();
}

class _EditExtraDetailsFieldState extends State<_EditExtraDetailsField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TitledTextFormField(
      controller: _controller,
      validator: (value) => null,
      onChange: widget.onChange,
      title: kMoreDets,
      height: null,
      hint:
          '$kInputMoreDetsAbout'
          '$kTheProperty',
      mxL: 5,
    );
  }
}

/// Update advertisement button
class _UpdateAdvBtn extends StatelessWidget {
  const _UpdateAdvBtn({this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 367,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2ECC71),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          'تحديث الإعلان',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
