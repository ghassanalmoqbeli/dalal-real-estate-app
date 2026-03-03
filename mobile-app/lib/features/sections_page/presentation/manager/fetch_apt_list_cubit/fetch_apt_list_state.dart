part of 'fetch_apt_list_cubit.dart';

@immutable
sealed class FetchAptListState {}

final class FetchAptListInitial extends FetchAptListState {}

final class FetchAptListLoading extends FetchAptListState {}

final class FetchAptListSuccess extends FetchAptListState {
  final SectionListEntity aptList;
  FetchAptListSuccess({required this.aptList});
}

final class FetchAptListFailure extends FetchAptListState {
  final String? errMsg;

  FetchAptListFailure({required this.errMsg});
}
