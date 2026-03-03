part of 'fetch_fav_advs_cubit.dart';

@immutable
sealed class FetchFavAdvsState {}

final class FetchFavAdvsInitial extends FetchFavAdvsState {}

final class FetchFavAdvsLoading extends FetchFavAdvsState {}

final class FetchFavAdvsIsEmpty extends FetchFavAdvsState {
  final String msg = 'List is Empty, Dude!';
}

final class FetchFavAdvsSuccess extends FetchFavAdvsState {
  final List<ShowDetailsEntity> favList;

  FetchFavAdvsSuccess({required this.favList});
}

final class FetchFavAdvsFailure extends FetchFavAdvsState {
  final String errMsg;

  FetchFavAdvsFailure({required this.errMsg});
}
