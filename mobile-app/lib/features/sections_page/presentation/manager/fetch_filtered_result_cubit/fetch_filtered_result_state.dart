part of 'fetch_filtered_result_cubit.dart';

@immutable
sealed class FetchFilteredResultState {}

final class FetchFilteredResultInitial extends FetchFilteredResultState {}

final class FetchFilteredResultLoading extends FetchFilteredResultState {}

final class FetchFilteredResultSuccess extends FetchFilteredResultState {
  final FilterListEntity filterResult;

  FetchFilteredResultSuccess({required this.filterResult});
}

final class FetchFilteredResultFailure extends FetchFilteredResultState {
  final String? errMsg;

  FetchFilteredResultFailure({required this.errMsg});
}

final class FetchFilteredResultIsEmpty extends FetchFilteredResultState {
  final String emptyMsg = 'لا نتائج لما تبحث عنه';
}
