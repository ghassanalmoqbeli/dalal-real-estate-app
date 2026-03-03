import 'package:dallal_proj/core/entities/adv_card_entity/adv_card_entity.dart';
import 'package:hive/hive.dart';

void saveAdvsList(List<AdvCardEntity> featuredAdvs, String boxName) {
  if (Hive.isBoxOpen(boxName)) {
    var box = Hive.box<AdvCardEntity>(boxName);
    box.addAll(featuredAdvs);
  }
}

void deleteAdvsList(String boxName) {
  if (Hive.isBoxOpen(boxName)) {
    var box = Hive.box<AdvCardEntity?>(boxName);
    box.delete(boxName);
  }
}
