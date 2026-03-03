part of 'fetch_house_list_cubit.dart';

@immutable
sealed class FetchHouseListState {}

final class FetchHouseListInitial extends FetchHouseListState {}

final class FetchHouseListLoading extends FetchHouseListState {}

final class FetchHouseListSuccess extends FetchHouseListState {
  final SectionListEntity houseList;

  FetchHouseListSuccess({required this.houseList});
}

final class FetchHouseListFailure extends FetchHouseListState {
  final String? errMsg;

  FetchHouseListFailure({required this.errMsg});
}
