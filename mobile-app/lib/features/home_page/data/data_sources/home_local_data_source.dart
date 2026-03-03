import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:hive/hive.dart';

abstract class HomeLocalDataSource {
  List<ShowDetailsEntity> fetchFeaturedAdvs();
  List<ShowDetailsEntity> fetchAllAdvs();
}

class HomeLocalDataSourceImplement extends HomeLocalDataSource {
  @override
  List<ShowDetailsEntity> fetchAllAdvs() {
    var box = Hive.box<ShowDetailsEntity>(kAllAdvBox);
    return box.values.toList();
  }

  @override
  List<ShowDetailsEntity> fetchFeaturedAdvs() {
    var box = Hive.box<ShowDetailsEntity>(kFeaturedAdvBox);
    return box.values.toList();
  }
}
