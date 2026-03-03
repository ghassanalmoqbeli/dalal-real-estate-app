part of 'delete_adv_cubit.dart';

@immutable
sealed class DeleteAdvState {}

final class DeleteAdvInitial extends DeleteAdvState {}

final class DeleteAdvLoading extends DeleteAdvState {}

final class DeleteAdvSuccess extends DeleteAdvState {
  final RspAuth response;

  DeleteAdvSuccess({required this.response});
}

final class DeleteAdvFailure extends DeleteAdvState {
  final String errMsg;

  DeleteAdvFailure({required this.errMsg});
}
