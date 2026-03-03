part of 'like_cubit.dart';

@immutable
sealed class LikeState {}

final class LikeInitial extends LikeState {}

final class LikeLoading extends LikeState {}

final class LikeSuccess extends LikeState {
  final RspAuth response;
  final bool isLiked;
  LikeSuccess({required this.isLiked, required this.response});
}

final class LikeFailure extends LikeState {
  final String errMsg;

  LikeFailure({required this.errMsg});
}
