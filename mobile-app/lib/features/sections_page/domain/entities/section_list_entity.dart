import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/sections_page/data/models/filter_model/filter_model.dart';

class SectionListEntity {
  final String? sectionName;
  final String? advCount;
  final List<ShowDetailsEntity> advs;

  SectionListEntity({
    required this.sectionName,
    required this.advCount,
    required this.advs,
  });
  factory SectionListEntity.fromFilterModel(FilterModel filter) {
    try {
      return SectionListEntity(
        sectionName: '${filter.data?.query?.propertyType?.first}',
        advCount: '${filter.data!.totalAds}',
        advs: filter.data?.ads ?? <ShowDetailsEntity>[],
      );
    } catch (e) {
      return SectionListEntity(
        sectionName: '',
        advCount: '${filter.data!.totalAds}',
        advs: filter.data?.ads ?? <ShowDetailsEntity>[],
      );
    }
  }
}
