import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/features/featuring_adv_page/data/models/feature_adv_model.dart';
import 'package:dallal_proj/features/featuring_adv_page/domain/use_cases/feature_the_adv_use_case.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'feature_the_adv_state.dart';

class FeatureTheAdvCubit extends Cubit<FeatureTheAdvState> {
  FeatureTheAdvCubit(this.featureTheAdvUseCase) : super(FeatureTheAdvInitial());
  final FeatureTheAdvUseCase featureTheAdvUseCase;

  Future<void> featureTheAdv(FeatureAdvModel featureAdv) async {
    emit(FeatureTheAdvLoading());
    var result = await featureTheAdvUseCase.call(featureAdv);

    result.fold(
      (failure) => emit(FeatureTheAdvFailure(errMsg: failure.message)),
      (response) {
        if (isSuxes(response.status)) {
          emit(FeatureTheAdvSuccess(response: response.data));
          return;
        } else {
          emit(FeatureTheAdvFailure(errMsg: response.message ?? ''));
        }
      },
    );
  }
}
