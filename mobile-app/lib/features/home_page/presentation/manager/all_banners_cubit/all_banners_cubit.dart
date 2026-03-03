import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/features/home_page/domain/entities/banner_entity.dart';
import 'package:dallal_proj/features/home_page/domain/use_cases/fetch_all_banners_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'all_banners_state.dart';

class AllBannersCubit extends Cubit<AllBannersState> {
  AllBannersCubit(this.fetchAllBannersUseCase) : super(AllBannersInitial());
  final FetchAllBannersUseCase fetchAllBannersUseCase;
  Future<void> fetchAllBanners() async {
    emit(AllBannersLoading());
    var result = await fetchAllBannersUseCase.call();
    result.fold(
      (failure) {
        emit(AllBannersFailure(errMsg: failure.message));
      },
      (bansRsp) {
        if (isSuxes(bansRsp.statusBans)) {
          emit(
            AllBannersSuccess(
              bannersEntity: bansRsp.bansList ?? <BannerEntity>[],
            ),
          );
          return;
        }
        emit(AllBannersFailure(errMsg: 'Failed to Fetch Banners!'));
      },
    );
  }
}
