part of 'feature_the_adv_cubit.dart';

@immutable
sealed class FeatureTheAdvState {}

final class FeatureTheAdvInitial extends FeatureTheAdvState {}

final class FeatureTheAdvLoading extends FeatureTheAdvState {}

final class FeatureTheAdvSuccess extends FeatureTheAdvState {
  final PckgInfModel response;

  FeatureTheAdvSuccess({required this.response});
}

final class FeatureTheAdvFailure extends FeatureTheAdvState {
  final String errMsg;

  FeatureTheAdvFailure({required this.errMsg});
}
