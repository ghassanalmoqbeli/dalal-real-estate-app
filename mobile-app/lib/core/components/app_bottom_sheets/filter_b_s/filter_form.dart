import 'package:dallal_proj/core/common/models/filter_sheet_values.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/constants/app_defs.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/constants/mock_models.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/filter_b_s/filter_form_items/check_box/checkbox_row.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/filter_b_s/filter_form_items/dropdown_menu/ct_drop_menu.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/filter_b_s/filter_form_items/filter_form_item.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/filter_b_s/filter_form_items/filter_form_items.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/filter_b_s/filter_form_items/from_to_fields/from_to_fields.dart';
import 'package:dallal_proj/core/components/radio_components/h_radio_form.dart';
import 'package:dallal_proj/core/components/radio_components/radio_btns/rbit/v_title_rbit.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/bottom_sheet_btns.dart';
import 'package:flutter/material.dart';

class FilterForm extends StatefulWidget {
  const FilterForm({
    super.key,
    required this.withPropType,
    required this.onValuesChanged,
    required this.onSubmit,
    this.initialValues,
  });
  final bool withPropType;
  final ValueChanged<FilterSheetValues> onValuesChanged;
  final ValueChanged<FilterSheetValues> onSubmit; // NEW
  final FilterSheetValues? initialValues;
  @override
  State<FilterForm> createState() => _FilterFormState();
}

class _FilterFormState extends State<FilterForm> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late ValueNotifier<String> _selectedOptA;
  late ValueNotifier<String> _selectedOptB;
  late bool withProptype;

  // Hold filter values
  late FilterSheetValues _filterValues;

  // Controllers for text fields
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  final TextEditingController _minAreaController = TextEditingController();
  final TextEditingController _maxAreaController = TextEditingController();

  // Selected values
  String? _selectedCity;
  String? _selectedCurrency;

  @override
  void initState() {
    super.initState();
    withProptype = widget.withPropType;

    // Initialize from initial values if provided
    final initial = widget.initialValues;
    _filterValues = initial ?? FilterSheetValues();

    // Initialize text controllers with initial values
    if (initial != null) {
      if (initial.minPrice != null) {
        _minPriceController.text = initial.minPrice.toString();
      }
      if (initial.maxPrice != null) {
        _maxPriceController.text = initial.maxPrice.toString();
      }
      if (initial.minArea != null) {
        _minAreaController.text = initial.minArea.toString();
      }
      if (initial.maxArea != null) {
        _maxAreaController.text = initial.maxArea.toString();
      }
      _selectedCity = initial.city;
      _selectedCurrency = initial.currency;
    }

    // Initialize radio options
    _selectedOptA = ValueNotifier(initial?.sortBy ?? kDefFilterOPtion);
    _selectedOptB = ValueNotifier(
      (initial?.featuredOnly ?? 0) == 1 ? kYes : kDefYesNoOPtion,
    );
  }

  // @override
  // void initState() {
  //   withProptype = widget.withPropType;
  //   setState(() {});
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _selectedOptA.dispose();
  //   _selectedOptB.dispose();
  //   super.dispose();
  // }

  @override
  void dispose() {
    _selectedOptA.dispose();
    _selectedOptB.dispose();
    _minPriceController.dispose();
    _maxPriceController.dispose();
    _minAreaController.dispose();
    _maxAreaController.dispose();
    super.dispose();
  }

  // Helper method to update values and notify parent
  void _updateValues() {
    // Update numeric values
    _filterValues.minPrice = num.tryParse(_minPriceController.text);
    _filterValues.maxPrice = num.tryParse(_maxPriceController.text);
    _filterValues.minArea = num.tryParse(_minAreaController.text);
    _filterValues.maxArea = num.tryParse(_maxAreaController.text);

    // Update other values
    _filterValues.city = _selectedCity;
    _filterValues.currency = _selectedCurrency;
    _filterValues.sortBy =
        _selectedOptA.value != kDefFilterOPtion ? _selectedOptA.value : null;
    _filterValues.featuredOnly = _selectedOptB.value == kDefYesNoOPtion ? 0 : 1;

    // Notify parent
    widget.onValuesChanged.call(_filterValues);
    // widget.onValuesChanged(_filterValues);
  }

  void _submitValues() {
    // Update one last time to ensure all values are current
    _updateValues();
    // Call onSubmit only on apply
    widget.onSubmit(_filterValues);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: autovalidateMode,
      key: formKey,
      child: FilterFormItems(
        children: [
          // withProptype
          //     ? const CheckboxRow(oLModel: kPropCkbModel)
          //     : const SizedBox(),
          withProptype
              ? CheckboxRow(
                oLModel: kPropCkbModel,
                initialSelected: _filterValues.propertyTypes,
                onSelectionChanged: (selected) {
                  _filterValues.propertyTypes = selected;
                  _updateValues();
                },
              )
              : const SizedBox(),
          // const CheckboxRow(oLModel: kOfferCkbModel),
          CheckboxRow(
            oLModel: kOfferCkbModel,
            initialSelected: _filterValues.offerTypes,
            onSelectionChanged: (selected) {
              _filterValues.offerTypes = selected;
              _updateValues();
            },
          ),
          // const FilterFormItem(title: kCity, child: CtDropMenu()),
          FilterFormItem(
            title: kCity,
            child: CtDropMenu(
              initialCity: _selectedCity,
              onSelected: (city) {
                _selectedCity = city;
                _updateValues();
              },
            ),
          ),
          FilterFormItem(
            title: kPrice,
            height: 78,
            child: FromToFields(
              withCurrency: true,
              aspect: 122 / 56,
              spacingFract: 0.045,
              minPriceController: _minPriceController,
              maxPriceController: _maxPriceController,
              onCurrencySelected: (currency) {
                _selectedCurrency = currency;
                _updateValues();
              },
              onPriceChanged: _updateValues,
            ),
          ),

          // const FilterFormItem(
          //   title: kPrice,
          //   height: 78,
          //   child: FromToFields(
          //     withCurrency: true,
          //     aspect: 122 / 56,
          //     spacingFract: 0.045,
          //   ),
          // ),
          FilterFormItem(
            title: kArea,
            height: 78,
            child: FromToFields(
              minAreaController: _minAreaController,
              maxAreaController: _maxAreaController,
              onAreaChanged: _updateValues,
            ),
          ),
          // const FilterFormItem(title: kArea, height: 78, child: FromToFields()),
          // VTitleRbit(selectedOpt: _selectedOptA, oLModel: kOrderByRBModel),
          VTitleRbit(
            selectedOpt: _selectedOptA,
            oLModel: kOrderByRBModel,
            onChanged: () => _updateValues(),
          ),
          // HRadioForm(selectedOpt: _selectedOptB, olModel: kOnlyPremOptModel),
          HRadioForm(
            selectedOpt: _selectedOptB,
            olModel: kOnlyPremOptModel,
            onChanged: () => _updateValues(),
          ),
          BottomSheetBtns(
            rBtnTxt: kApply,
            lBtnTxt: kReset,
            btnSize: const XBSize(width: 177, height: 56, border: 0.5),
            onTapL: () {
              // Reset all values
              _filterValues.reset();
              _minPriceController.clear();
              _maxPriceController.clear();
              _minAreaController.clear();
              _maxAreaController.clear();
              _selectedOptA.value = kDefFilterOPtion;
              _selectedOptB.value = kDefYesNoOPtion;
              _selectedCity = null;
              _selectedCurrency = null;
              _updateValues();
              widget.onValuesChanged(_filterValues);
            },
            onTapR: () {
              // Close bottom sheet and apply filter
              _submitValues(); // Call submission method
              Navigator.of(context).pop(_filterValues);
              // Navigator.of(context).pop(_filterValues);
            },
            rBtnCol: kPrimColG,
          ),
          // BottomSheetBtns(
          //   rBtnTxt: kApply,
          //   lBtnTxt: kReset,
          //   btnSize: const XBSize(width: 177, height: 56, border: 0.5),
          //   onTapL: () {},
          //   onTapR: () {},
          //   rBtnCol: kPrimColG,
          // ),
          //Fltr.buildAddButton(),
        ],
      ),
    );
  }
}
