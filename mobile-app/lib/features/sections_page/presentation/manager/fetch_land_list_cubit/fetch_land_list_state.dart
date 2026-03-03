part of 'fetch_land_list_cubit.dart';

@immutable
sealed class FetchLandListState {}

final class FetchLandListInitial extends FetchLandListState {}

final class FetchLandListLoading extends FetchLandListState {}

final class FetchLandListSuccess extends FetchLandListState {
  final SectionListEntity landList;

  FetchLandListSuccess({required this.landList});
}

final class FetchLandListFailure extends FetchLandListState {
  final String? errMsg;

  FetchLandListFailure({required this.errMsg});
}
