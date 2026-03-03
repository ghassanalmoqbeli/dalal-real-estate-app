import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/features/sections_page/domain/entities/section_list_entity.dart';
import 'package:dallal_proj/features/sections_page/domain/use_cases/fetch_lands_list_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_land_list_state.dart';

class FetchLandListCubit extends Cubit<FetchLandListState> {
  FetchLandListCubit(this.landsListUseCase) : super(FetchLandListInitial());
  final FetchLandsListUseCase landsListUseCase;

  Future<void> fetchLandList(String? token) async {
    emit(FetchLandListLoading());

    var landResult = await landsListUseCase.call(token);
    landResult.fold(
      (failure) {
        emit(FetchLandListFailure(errMsg: 'Land section list failure'));
      },
      (filterModel) {
        if (isSuxes(filterModel.status)) {
          emit(
            FetchLandListSuccess(
              landList: SectionListEntity.fromFilterModel(filterModel),
            ),
          );
        }
      },
    );
  }
}
