import 'package:dallal_proj/features/home_page/domain/entities/banner_entity.dart';

class BannersRspEntity {
  final String? statusBans;
  final List<BannerEntity>? bansList;
  BannersRspEntity({this.statusBans, this.bansList});
}
