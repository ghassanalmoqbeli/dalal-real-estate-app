import 'package:dallal_proj/core/components/app_cards/property_card/items/card_details/card_date_txt.dart';
import 'package:flutter/material.dart';

class DetailDateText extends StatelessWidget {
  const DetailDateText({super.key, required this.date});
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: CardDateTxt(date: date, fSize: 12),
    );
  }
}
