import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/features/sections_page/data/models/filter_req_model.dart';
import 'package:dallal_proj/features/sections_page/domain/entities/filter_list_entity.dart';
import 'package:dallal_proj/features/sections_page/domain/use_cases/fetch_filtered_result_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_filtered_result_state.dart';

class FetchFilteredResultCubit extends Cubit<FetchFilteredResultState> {
  FetchFilteredResultCubit(this.filteredResultUseCase)
    : super(FetchFilteredResultInitial());
  final FetchFilteredResultUseCase filteredResultUseCase;

  Future<void> fetchFilteredResult(FilterReqModel filterReqModel) async {
    emit(FetchFilteredResultLoading());

    var result = await filteredResultUseCase.call(filterReqModel);

    result.fold(
      (failure) {
        emit(FetchFilteredResultFailure(errMsg: failure.message));
      },
      (filterModel) {
        if (isSuxes(filterModel.status)) {
          emit(
            FetchFilteredResultSuccess(
              filterResult: FilterListEntity.fromFilterModel(filterModel),
            ),
          );
          if (filterModel.data!.ads!.isEmpty) {
            emit(FetchFilteredResultIsEmpty());
          }
        } else {
          emit(FetchFilteredResultFailure(errMsg: 'Failed to fetch result!'));
        }
      },
    );
  }
}
