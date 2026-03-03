import 'package:dallal_proj/core/constants/app_defs.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';

class DictHelper {
  static final Map<String, Map<String, String>> _translations = {
    kCTs: {
      'sanaa': 'صنعاء',
      'taiz': 'تعز',
      'aden': 'عدن',
      'ibb': 'إب',
      'dhamar': 'ذمار',
      'hadramout': 'حضرموت',
      'hodeidah': 'الحديدة',
      'yareem': 'يريم',
      'saada': 'صعدة',
      'amran': 'عمران',
      'raymah': 'ريمة',
      'mahweet': 'المحويت',
      'haggah': 'حجة',
      'lahj': 'لحج',
      'mahrah': 'المهرة',
      'shabwa': 'شبوة',
      'marib': 'مأرب',
      'aljawf': 'الجوف',
      'albayda': 'البيضاء',
      'aldhale': 'الضالع',
      'socotra': 'سقطرى',
      'abian': 'أبين',
    },
    kOTs: {
      'sale_freehold': 'تمليك حر',
      'sale_waqf': 'تمليك وقف',
      'rent': 'إيجار',
    },
    kOTsRev: {
      'تمليك حر': 'sale_freehold',
      'تمليك وقف': 'sale_waqf',
      'إيجار': 'rent',
      'شقة': 'apartment',
      'منزل': 'house',
      'أرض': 'land',
      'دكان': 'shop',
      kRptFakeAdv: 'fake',
      kRptWrongInfo: 'wrong_info',
      kRptInsult: 'fraud',
      kRptOthers: 'other',

      'صنعاء': 'sanaa',
      'تعز': 'taiz',
      'عدن': 'aden',
      'إب': 'ibb',
      'ذمار': 'dhamar',
      'حضرموت': 'hadramout',
      'الحديدة': 'hodeidah',
      'يريم': 'yareem',
      'صعدة': 'saada',
      'عمران': 'amran',
      'ريمة': 'raymah',
      'المحويت': 'mahweet',
      'حجة': 'haggah',
      'لحج': 'lahj',
      'المهرة': 'mahrah',
      'شبوة': 'shabwa',
      'مأرب': 'marib',
      'الجوف': 'aljawf',
      'البيضاء': 'albayda',
      'الضالع': 'aldhale',
      'سقطرى': 'socotra',
      'أبين': 'abian',
    },
    kPTs: {'apartment': 'شقة', 'house': 'منزل', 'land': 'أرض', 'shop': 'دكان'},
    kPTSs: {
      'apartment': 'شقق',
      'house': 'منازل',
      'land': 'أراضي',
      'shop': 'دكاكين',
    },
  };

  static String translate(String category, String key) {
    final categoryMap = _translations[category];
    if (categoryMap == null) {
      throw ArgumentError('Invalid translation category: $category');
    }

    final value = categoryMap[key.toLowerCase()];
    return value ?? '';
  }

  static String translateStrict(String category, String key) {
    final categoryMap = _translations[category];
    if (categoryMap == null) {
      throw ArgumentError('Invalid translation category: $category');
    }

    final value = categoryMap[key.toLowerCase()];
    if (value == null) {
      throw ArgumentError('Invalid key "$key" for category "$category"');
    }

    return value;
  }
}
