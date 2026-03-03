part of 'edit_ad_orcstr_cubit.dart';

@immutable
sealed class EditAdOrcstrState {
  const EditAdOrcstrState();
}

final class EditAdOrcstrInitial extends EditAdOrcstrState {
  const EditAdOrcstrInitial();
}

class EditAdOrcstrLoading extends EditAdOrcstrState {
  final String step;
  final int currentMedia;
  final int totalMedia;
  const EditAdOrcstrLoading({
    required this.step,
    this.currentMedia = 0,
    this.totalMedia = 0,
  });
}

class EditAdOrcstrSuccess extends EditAdOrcstrState {
  final String adId;
  final List<int> deletedMediaIds;
  final List<String> successfulNewMediaIds;
  const EditAdOrcstrSuccess({
    required this.adId,
    required this.deletedMediaIds,
    required this.successfulNewMediaIds,
  });
}

class EditAdOrcstrPartialSuccess extends EditAdOrcstrState {
  final String adId;
  final List<int> deletedMediaIds;
  final List<int> failedDeleteMediaIds;
  final List<String> successfulNewMediaIds;
  final List<String> failedNewMediaIds;
  final String message;
  const EditAdOrcstrPartialSuccess({
    required this.adId,
    required this.deletedMediaIds,
    required this.failedDeleteMediaIds,
    required this.successfulNewMediaIds,
    required this.failedNewMediaIds,
    required this.message,
  });
}

class EditAdOrcstrFailure extends EditAdOrcstrState {
  final String error;
  const EditAdOrcstrFailure(this.error);
}
