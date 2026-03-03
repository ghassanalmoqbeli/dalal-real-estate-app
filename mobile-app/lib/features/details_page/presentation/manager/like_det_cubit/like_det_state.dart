part of 'like_det_cubit.dart';

@immutable
sealed class LikeDetState {}

final class LikeDetInitial extends LikeDetState {}

final class LikeDetLoading extends LikeDetState {}

final class LikeDetSuccess extends LikeDetState {
  final RspAuth response;
  final bool isLiked;
  LikeDetSuccess({required this.isLiked, required this.response});
}

final class LikeDetFailure extends LikeDetState {
  final String errMsg;

  LikeDetFailure({required this.errMsg});
}
