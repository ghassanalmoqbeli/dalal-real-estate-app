import 'package:dallal_proj/core/constants/app_defs.dart';
import 'package:dallal_proj/core/constants/str_lists.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/filter_b_s/filter_form_items/check_box/mc_checkbox_item.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/utils/functions/get_city_value.dart';
import 'package:flutter/material.dart';

class McCheckbox extends StatefulWidget {
  final List<String> options;
  final List<String>? initialSelected; // Initial selected API values
  final ValueChanged<List<String>>? onSelectionChanged;
  final double checkboxScale;
  final Color activeColor;
  final Color checkColor;
  final Color borderColor;
  final TextStyle textStyle;

  const McCheckbox({
    super.key,
    this.options = CLstr.propertyType,
    this.initialSelected,
    this.onSelectionChanged,
    this.checkboxScale = 1.2,
    this.activeColor = Colors.teal,
    this.checkColor = kWhite,
    this.borderColor = Colors.tealAccent,
    this.textStyle = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      height: 1.25,
    ),
  });

  @override
  State<McCheckbox> createState() => _McCheckboxState();
}

class _McCheckboxState extends State<McCheckbox> {
  late Set<String> _selectedOptions;

  @override
  void initState() {
    super.initState();
    // Initialize with initial selected values (API values like 'apartment', 'rent', etc.)
    _selectedOptions = Set<String>.from(widget.initialSelected ?? []);
  }

  void _onChanged(bool? value, String option) {
    setState(() {
      value == true
          ? _selectedOptions.add(DictHelper.translate(kOTsRev, option))
          : _selectedOptions.remove(DictHelper.translate(kOTsRev, option));
      widget.onSelectionChanged?.call(_selectedOptions.toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 0,
      children:
          widget.options.map((option) {
            final isSelected = _selectedOptions.contains(
              DictHelper.translate(kOTsRev, option),
            );
            return McCheckboxItem(
              label: option,
              isSelected: isSelected,
              onToggle: (val) => _onChanged(val, option),
              checkboxScale: widget.checkboxScale,
              activeColor: widget.activeColor,
              checkColor: widget.checkColor,
              borderColor: widget.borderColor,
              textStyle: widget.textStyle,
            );
          }).toList(),
    );
  }
}
