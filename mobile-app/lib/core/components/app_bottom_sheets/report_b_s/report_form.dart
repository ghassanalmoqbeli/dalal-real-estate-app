import 'package:dallal_proj/core/common/models/report_sheet_values.dart';
import 'package:dallal_proj/core/constants/app_defs.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/constants/mock_models.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/utils/functions/get_city_value.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/bottom_sheet_btns.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/report_b_s/report_radio_form.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/report_b_s/report_text_field.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/report_b_s/seperated_title.dart';
import 'package:flutter/material.dart';

class ReportForm extends StatefulWidget {
  const ReportForm({
    super.key,
    required this.onValuesChanged,
    required this.onSubmit,
    required this.adID,
  });
  final ValueChanged<ReportSheetValues> onValuesChanged;
  final ValueChanged<ReportSheetValues> onSubmit; // NEW
  final String adID;
  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final ValueNotifier<String> _selectedOpt = ValueNotifier(kDefReportOpt);
  final TextEditingController _reportController = TextEditingController();
  late ReportSheetValues _reportValues;
  String? _description = '';
  @override
  void initState() {
    _reportValues = ReportSheetValues(
      adID: widget.adID,
      reason: _selectedOpt.value,
    );
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    _reportController.dispose();
    super.dispose();
  }

  void _updateValues() {
    _reportValues.description = _reportController.text;
    _reportValues.reason = DictHelper.translate(
      kOTsRev,
      _selectedOpt.value != kDefReportOpt ? _selectedOpt.value : kDefReportOpt,
    );
    widget.onValuesChanged.call(_reportValues);
  }

  void _submitValues() {
    _updateValues();
    widget.onSubmit(_reportValues);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: Funcs.frwGetter(23, context),
        left: Funcs.frwGetter(23, context),
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Form(
          autovalidateMode: autovalidateMode,
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SeperatedTitle(text: kReportRBModel.title),
              VPItem(
                tSpc: 20,
                bSpc: 32,
                child: ReportRadioForm(
                  selectedValueNotifier: _selectedOpt,
                  options: kReportRBModel.options,
                  childBuilder:
                      (isEnabled) => ReportTextField(
                        controller: _reportController,
                        onChanged: (v) {
                          _description = v;
                          _updateValues;
                        },
                      ),
                  onChanged: () => _updateValues(),
                ),
              ),
              VPItem(
                tSpc: 25,
                bSpc: 35,
                child: BottomSheetBtns(
                  rBtnTxt: kSendReport,
                  lBtnTxt: kCancel,
                  onTapR: () {
                    _submitValues();
                  },
                  onTapL: () {
                    Navigator.of(context).pop(_reportValues);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
