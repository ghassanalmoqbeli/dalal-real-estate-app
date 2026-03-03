part of 'fav_cubit.dart';

@immutable
sealed class FaveState {}

final class FaveInitial extends FaveState {}

final class FaveLoading extends FaveState {}

final class FaveSuccess extends FaveState {
  final RspAuth response;
  final bool isFaved;
  final String token;
  FaveSuccess({
    required this.isFaved,
    required this.response,
    required this.token,
  });
}

final class FaveFailure extends FaveState {
  final String errMsg;

  FaveFailure({required this.errMsg});
}
