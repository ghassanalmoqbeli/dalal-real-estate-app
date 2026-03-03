import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/features/sections_page/domain/entities/section_list_entity.dart';
import 'package:dallal_proj/features/sections_page/domain/use_cases/fetch_apt_list_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_apt_list_state.dart';

class FetchAptListCubit extends Cubit<FetchAptListState> {
  FetchAptListCubit(this.aptsListUseCase) : super(FetchAptListInitial());
  final FetchAptsListUseCase aptsListUseCase;

  Future<void> fetchAptList(String? token) async {
    emit(FetchAptListLoading());

    var aptResult = await aptsListUseCase.call(token);
    aptResult.fold(
      (failure) {
        emit(FetchAptListFailure(errMsg: 'apt section list failure'));
      },
      (filterModel) {
        if (isSuxes(filterModel.status)) {
          emit(
            FetchAptListSuccess(
              aptList: SectionListEntity.fromFilterModel(filterModel),
            ),
          );
        }
      },
    );
  }
}
