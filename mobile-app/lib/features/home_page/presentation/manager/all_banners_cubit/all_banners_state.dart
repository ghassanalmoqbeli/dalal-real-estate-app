part of 'all_banners_cubit.dart';

@immutable
sealed class AllBannersState {}

final class AllBannersInitial extends AllBannersState {}

final class AllBannersLoading extends AllBannersState {}

final class AllBannersSuccess extends AllBannersState {
  final List<BannerEntity> bannersEntity;

  AllBannersSuccess({required this.bannersEntity});
}

final class AllBannersFailure extends AllBannersState {
  final String? errMsg;

  AllBannersFailure({required this.errMsg});
}
