part of 'create_ad_orcstr_cubit.dart';

@immutable
sealed class CreateAdOrcstrState {
  const CreateAdOrcstrState();
}

final class CreateAdOrcstrInitial extends CreateAdOrcstrState {
  const CreateAdOrcstrInitial();
}

class CreateAdOrcstrLoading extends CreateAdOrcstrState {
  final String step;
  final int currentMedia;
  final int totalMedia;
  const CreateAdOrcstrLoading({
    required this.step,
    this.currentMedia = 0,
    this.totalMedia = 0,
  });
}

class CreateAdOrcstrSuccess extends CreateAdOrcstrState {
  final String adId;
  final List<String> successfulMediaIds;
  final List<String> failedMediaIds;
  const CreateAdOrcstrSuccess({
    required this.adId,
    required this.successfulMediaIds,
    this.failedMediaIds = const [],
  });
}

class CreateAdOrcstrPartialSuccess extends CreateAdOrcstrState {
  final String adId;
  final List<String> successfulMediaIds;
  final List<String> failedMediaIds;
  final String message;
  const CreateAdOrcstrPartialSuccess({
    required this.adId,
    required this.successfulMediaIds,
    required this.failedMediaIds,
    required this.message,
  });
}

class CreateAdOrcstrFailure extends CreateAdOrcstrState {
  final String error;
  const CreateAdOrcstrFailure(this.error);
}
