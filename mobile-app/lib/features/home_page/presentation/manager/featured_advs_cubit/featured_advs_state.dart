part of 'featured_advs_cubit.dart';

@immutable
sealed class FeaturedAdvsState {}

final class FeaturedAdvsInitial extends FeaturedAdvsState {}

final class FeaturedAdvsLoading extends FeaturedAdvsState {}

final class FeaturedAdvsFailure extends FeaturedAdvsState {
  final String errMsg;

  FeaturedAdvsFailure({required this.errMsg});
}

final class FeaturedAdvsSuccess extends FeaturedAdvsState {
  final List<ShowDetailsEntity> featuredAdvsList;

  FeaturedAdvsSuccess({required this.featuredAdvsList});
}

final class FeaturedAdvsSuccessLocal extends FeaturedAdvsState {
  final List<ShowDetailsEntity> featuredAdvsList;
  final String localMsg;
  FeaturedAdvsSuccessLocal({
    required this.featuredAdvsList,
    required this.localMsg,
  });
}
