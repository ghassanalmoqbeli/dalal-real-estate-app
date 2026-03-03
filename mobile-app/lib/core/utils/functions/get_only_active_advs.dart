import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';

List<ShowDetailsEntity> getOnlyActiveAds(List<ShowDetailsEntity> adsList) {
  return adsList.where((ad) => ad.status == true).toList();
}
