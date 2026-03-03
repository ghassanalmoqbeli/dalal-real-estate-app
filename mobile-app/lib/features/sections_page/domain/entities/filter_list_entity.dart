import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/sections_page/data/models/filter_model/filter_model.dart';

class FilterListEntity {
  final String? advCount;
  final List<ShowDetailsEntity> advs;

  FilterListEntity({required this.advCount, required this.advs});
  factory FilterListEntity.fromFilterModel(FilterModel filter) {
    try {
      return FilterListEntity(
        advCount: '${filter.data!.totalAds}',
        advs: filter.data?.ads ?? <ShowDetailsEntity>[],
      );
    } catch (e) {
      return FilterListEntity(
        advCount: '${filter.data!.totalAds}',
        advs: filter.data?.ads ?? <ShowDetailsEntity>[],
      );
    }
  }
}
