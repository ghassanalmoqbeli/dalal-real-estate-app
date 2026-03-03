import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/home_page/domain/use_cases/fetch_all_advs_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'all_advs_state.dart';

class AllAdvsCubit extends Cubit<AllAdvsState> {
  AllAdvsCubit(this.fetchAllAdvsUseCase) : super(AllAdvsInitial());

  final FetchAllAdvsUseCase fetchAllAdvsUseCase;

  Future<void> fetchAllAdvs(String? token) async {
    emit(AllAdvsLoading());
    var meData = getMeData();
    var result = await fetchAllAdvsUseCase.call(meData?.uToken);
    result.fold(
      (failure) {
        emit(AllAdvsFailure(errMsg: failure.message));
      },
      (advsListRsp) {
        // if (advsListRsp.fetchStatus == 'local') {
        //   emit(
        //     AllAdvsSuccessLocal(
        //       localMsg: advsListRsp.fetchMessage ?? 'localism',
        //       allAdvsList: advsListRsp.advList!,
        //     ),
        //   );
        // }
        if (isSuxes(advsListRsp.fetchStatus)) {
          emit(AllAdvsSuccess(allAdvsList: advsListRsp.advList!));
          // emit(AllAdvsLoading());
          return;
        }
        emit(
          AllAdvsFailure(
            errMsg: advsListRsp.fetchMessage ?? 'EEE RRR RRR OOO RRR!!',
          ),
        );
      },
    );
  }
}
