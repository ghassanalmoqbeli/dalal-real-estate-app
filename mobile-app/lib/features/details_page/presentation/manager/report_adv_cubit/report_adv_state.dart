part of 'report_adv_cubit.dart';

@immutable
sealed class ReportAdvState {}

final class ReportAdvInitial extends ReportAdvState {}

final class ReportAdvLoading extends ReportAdvState {}

final class ReportAdvSuccess extends ReportAdvState {
  final RspAuth response;

  ReportAdvSuccess({required this.response});
}

final class ReportAdvFailure extends ReportAdvState {
  final String errMsg;

  ReportAdvFailure({required this.errMsg});
}
