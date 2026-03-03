import 'package:dallal_proj/core/constants/app_defs.dart';
import 'package:flutter/material.dart';
import 'package:dallal_proj/core/widgets/cust_seperator.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:intl/intl.dart' as m_intl;

class WidH {
  static const TextAlign tra = TextAlign.right;
  static const TextDirection trd = TextDirection.rtl;

  static int strToint(String strNum) {
    try {
      return int.parse(strNum);
    } catch (e) {
      return 0;
    }
  }

  static String date2str(DateTime date) =>
      m_intl.DateFormat(kDefDateFormat).format(date).toString();

  static DateTime str2date(String date) =>
      m_intl.DateFormat(kDefDateFormat).parse(date);

  static DateTime addDaysToDt(DateTime date, int frame) {
    return date.add(Duration(days: frame));
  }

  static String addDaysToStr(DateTime date, int frame) {
    return date2str(addDaysToDt(date, frame));
  }

  static CustSeperator respSep(BuildContext context, {double? fract}) =>
      CustSeperator(
        width: Funcs.respWidth(fract: fract ?? 0.8, context: context),
      );
}
