import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/features/sections_page/domain/entities/section_list_entity.dart';
import 'package:dallal_proj/features/sections_page/domain/use_cases/fetch_houses_list_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_house_list_state.dart';

class FetchHouseListCubit extends Cubit<FetchHouseListState> {
  FetchHouseListCubit(this.housesListUseCase) : super(FetchHouseListInitial());
  final FetchHousesListUseCase housesListUseCase;

  Future<void> fetchHouseList(String? token) async {
    emit(FetchHouseListLoading());

    var houseResult = await housesListUseCase.call(token);
    houseResult.fold(
      (failure) {
        emit(FetchHouseListFailure(errMsg: 'apt section list failure'));
      },
      (filterModel) {
        if (isSuxes(filterModel.status)) {
          emit(
            FetchHouseListSuccess(
              houseList: SectionListEntity.fromFilterModel(filterModel),
            ),
          );
        }
      },
    );
  }
}
