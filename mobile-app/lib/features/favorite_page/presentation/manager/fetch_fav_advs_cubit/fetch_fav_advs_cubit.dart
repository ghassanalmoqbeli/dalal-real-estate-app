import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/favorite_page/domain/use_cases/fetch_fav_advs_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_fav_advs_state.dart';

class FetchFavAdvsCubit extends Cubit<FetchFavAdvsState> {
  FetchFavAdvsCubit(this.fetchFavAdvsUseCase) : super(FetchFavAdvsInitial());
  final FetchFavAdvsUseCase fetchFavAdvsUseCase;

  Future<void> fetchFavAdvs(String token) async {
    emit(FetchFavAdvsLoading());

    var result = await fetchFavAdvsUseCase.call(token);

    result.fold(
      (failure) {
        emit(FetchFavAdvsFailure(errMsg: failure.message));
      },
      (userProfile) {
        if (isSuxes(userProfile.status)) {
          var favList =
              userProfile.data!.ads!.favoriteAds?.ads ?? <ShowDetailsEntity>[];
          if (favList.isNotEmpty) {
            emit(FetchFavAdvsSuccess(favList: favList));
            return;
          } else if (favList.isEmpty) {
            emit(FetchFavAdvsIsEmpty());
            return;
          } else {
            emit(FetchFavAdvsFailure(errMsg: 'Dunno What Happened'));
          }
        }
        emit(FetchFavAdvsFailure(errMsg: 'Dunno Dunno Dunno'));
      },
    );
  }
}
