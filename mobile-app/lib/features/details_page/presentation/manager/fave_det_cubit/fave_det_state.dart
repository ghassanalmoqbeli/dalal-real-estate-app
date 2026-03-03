part of 'fave_det_cubit.dart';

@immutable
sealed class FaveDetState {}

final class FaveDetInitial extends FaveDetState {}

final class FaveDetLoading extends FaveDetState {}

final class FaveDetSuccess extends FaveDetState {
  final RspAuth response;
  final bool isFaved;
  FaveDetSuccess({required this.isFaved, required this.response});
}

final class FaveDetFailure extends FaveDetState {
  final String errMsg;

  FaveDetFailure({required this.errMsg});
}
