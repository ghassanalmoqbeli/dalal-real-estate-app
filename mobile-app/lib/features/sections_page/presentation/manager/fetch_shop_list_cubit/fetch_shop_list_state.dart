part of 'fetch_shop_list_cubit.dart';

@immutable
sealed class FetchShopListState {}

final class FetchShopListInitial extends FetchShopListState {}

final class FetchShopListLoading extends FetchShopListState {}

final class FetchShopListSuccess extends FetchShopListState {
  final SectionListEntity shopList;

  FetchShopListSuccess({required this.shopList});
}

final class FetchShopListFailure extends FetchShopListState {
  final String? errMsg;

  FetchShopListFailure({required this.errMsg});
}
