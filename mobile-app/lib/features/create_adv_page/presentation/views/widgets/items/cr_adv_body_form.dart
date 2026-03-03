import 'package:dallal_proj/core/components/app_input_fields/titled_text_form_field.dart';
import 'package:dallal_proj/features/create_adv_page/presentation/views/widgets/cr_adv_helper.dart';
import 'package:dallal_proj/features/create_adv_page/presentation/views/widgets/items/a_i_btn.dart';
import 'package:dallal_proj/features/create_adv_page/presentation/views/widgets/items/add_img_item.dart';
import 'package:dallal_proj/features/create_adv_page/presentation/views/widgets/items/adress_text_form_field.dart';
import 'package:dallal_proj/features/create_adv_page/presentation/views/widgets/items/area_text_form_field.dart';
import 'package:dallal_proj/features/create_adv_page/presentation/views/widgets/items/cr_adv_ct_drop.dart';
import 'package:dallal_proj/features/create_adv_page/presentation/views/widgets/items/floors_text_form_field.dart';
import 'package:dallal_proj/features/create_adv_page/presentation/views/widgets/items/loc_map_text_form_field.dart';
import 'package:dallal_proj/features/create_adv_page/presentation/views/widgets/items/parts_of_prop_text_form_fields.dart';
import 'package:dallal_proj/features/create_adv_page/presentation/views/widgets/items/price_t_f_f.dart';
import 'package:dallal_proj/features/preregister/presentation/views/widgets/register_btn.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/core/constants/mock_models.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:flutter/material.dart';

class CrAdvBodyForm extends StatelessWidget {
  const CrAdvBodyForm({
    super.key,
    required this.imgOnTap,
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
    required this.popOnCompleted,
    required this.title,
    required this.sectFwidth,
    required this.crnOnSelected,
    required this.priceOnChanged,
    required this.selectedOptB,
    required this.negotOnTapped,
    required this.mdetsOnChanged,
    required this.aiOnpressed,
    required this.postOnpressed,
    this.onImagesChanged,
    this.onBathroomsChanged,
    this.onRoomsChanged,
    this.onKichensChanged,
    this.onLivingroomsChanged,
  });

  final Function() imgOnTap;
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
  final Function(String)? popOnCompleted;
  final String title;
  final double sectFwidth;
  final Function(String?)? crnOnSelected;
  final Function(String)? priceOnChanged;
  final ValueNotifier<String> selectedOptB;
  final Function(String)? negotOnTapped;
  final Function(String)? mdetsOnChanged;
  final Function() aiOnpressed;
  final Function() postOnpressed;
  final void Function(List<String> base64Images)? onImagesChanged;
  final Function(String)? onBathroomsChanged;
  final Function(String)? onRoomsChanged;
  final Function(String)? onKichensChanged;
  final Function(String)? onLivingroomsChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        VPItem(bSpc: 20, child: AddImgItem(onImagesChanged: onImagesChanged)),
        VPItem(
          bSpc: 20,
          child: AdressTextFormField(
            onChange: adrOnChange,
            adrFwidth: adrFwidth,
          ),
        ),
        VPItem(bSpc: 20, child: CrAdvCtDrop(onSelected: ctOnSelected)),
        VPItem(bSpc: 20, child: AreaTextFormField(onChange: areaOnChange)),
        VPItem(
          bSpc: 35,
          child: LocMapTextFormFields(
            textFwidth: textFwidth,
            locOnChange: locOnChange,
            mapOnChange: mapOnChange,
            gglOnTap: gglOnTap,
          ),
        ),
        VPItem(
          bSpc: 35,
          child: CrAdvHelper.radCrAdv(
            selectedOpt,
            offerOnTapped,
            kOfferCkbModel,
          ),
        ),
        if (title == kHouse)
          VPItem(bSpc: 30, child: FloorsTFF(onChange: flrsOnChange)),
        if (title == kHouse || title == kApt)
          VPItem(
            bSpc: 30,
            child: PartsOfPropTextFormFields2(
              onBathroomsChanged: onBathroomsChanged,
              onKitchensChanged: onKichensChanged,
              onLivingRoomsChanged: onLivingroomsChanged,
              onRoomsChanged: onRoomsChanged,
              title: title,
              sectFwidth: sectFwidth,
            ),
          ),
        VPItem(
          bSpc: 30,
          child: PriceTFF(
            crnOnSelected: crnOnSelected,
            priceOnChanged: priceOnChanged,
          ),
        ),
        VPItem(
          bSpc: 30,
          child: CrAdvHelper.radCrAdv(selectedOptB, negotOnTapped, kIsNegot),
        ),
        VPItem(
          tSpc: 20,
          bSpc: 80,
          child: TitledTextFormField(
            validator: (value) => null,
            onChange: mdetsOnChanged,
            title: kMoreDets,
            height: null,
            hint:
                '$kInputMoreDetsAbout'
                '$kTheProperty',
            mxL: 5,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: VPItem(
            tSpc: 20,
            bSpc: 20,
            child: AIBtn(onPressed: aiOnpressed),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: VPItem(bSpc: 20, child: PostAdvBtn(onPressed: postOnpressed)),
        ),
      ],
    );
  }
}
