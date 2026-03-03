import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/home_page/data/models/adv_information_model/adv_information_model.dart';

List<ShowDetailsEntity> getFeaturedAdvsList(data) {
  List<ShowDetailsEntity> allAdvs = [];
  for (var advCard in data['data']['featured_ads']) {
    allAdvs.add(AdvInformationModel.fromJson(advCard));
  }
  return allAdvs;
}
