part of 'all_advs_cubit.dart';

@immutable
sealed class AllAdvsState {}

final class AllAdvsInitial extends AllAdvsState {}

final class AllAdvsLoading extends AllAdvsState {}

final class AllAdvsFailure extends AllAdvsState {
  final String errMsg;

  AllAdvsFailure({required this.errMsg});
}

final class AllAdvsSuccess extends AllAdvsState {
  final List<ShowDetailsEntity> allAdvsList;

  AllAdvsSuccess({required this.allAdvsList});
}

final class AllAdvsSuccessLocal extends AllAdvsState {
  final List<ShowDetailsEntity> allAdvsList;
  final String localMsg;
  AllAdvsSuccessLocal({required this.allAdvsList, required this.localMsg});
}
