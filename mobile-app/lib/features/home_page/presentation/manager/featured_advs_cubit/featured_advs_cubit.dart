import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/features/home_page/domain/use_cases/fetch_featured_advs_use_case.dart';
import 'package:meta/meta.dart';

part 'featured_advs_state.dart';

class FeaturedAdvsCubit extends Cubit<FeaturedAdvsState> {
  FeaturedAdvsCubit(this.fetchFeaturedAdvsUseCase)
    : super(FeaturedAdvsInitial());

  final FetchFeaturedAdvsUseCase fetchFeaturedAdvsUseCase;
  Future<void> fetchFeaturedAdvs(String? token) async {
    emit(FeaturedAdvsLoading());
    var meData = getMeData();
    var result = await fetchFeaturedAdvsUseCase.call(meData?.uToken);
    result.fold(
      (failure) {
        emit(FeaturedAdvsFailure(errMsg: failure.message));
      },
      (advsListRsp) {
        // if (advsListRsp.fetchStatus == 'local') {
        //   emit(
        //     FeaturedAdvsSuccessLocal(
        //       localMsg: advsListRsp.fetchMessage ?? 'localism',
        //       featuredAdvsList: advsListRsp.advList!,
        //     ),
        //   );
        // }
        if (isSuxes(advsListRsp.fetchStatus)) {
          emit(FeaturedAdvsSuccess(featuredAdvsList: advsListRsp.advList!));
          // emit(FeaturedAdvsLoading());
          return;
        }
        emit(
          FeaturedAdvsFailure(
            errMsg: advsListRsp.fetchMessage ?? 'EEE RRR RRR OOO RRR!!',
          ),
        );
      },
      // (advsList) {
      //   emit(FeaturedAdvsSuccess(featuredAdvsList: advsList));
      // },
    );
  }
}
