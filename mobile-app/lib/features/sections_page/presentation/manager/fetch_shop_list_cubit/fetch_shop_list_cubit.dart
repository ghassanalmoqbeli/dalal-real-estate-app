import 'package:dallal_proj/core/utils/functions/is_success.dart';
import 'package:dallal_proj/features/sections_page/domain/entities/section_list_entity.dart';
import 'package:dallal_proj/features/sections_page/domain/use_cases/fetch_shops_list_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_shop_list_state.dart';

class FetchShopListCubit extends Cubit<FetchShopListState> {
  FetchShopListCubit(this.shopsListUseCase) : super(FetchShopListInitial());
  final FetchShopsListUseCase shopsListUseCase;

  Future<void> fetchShopList(String? token) async {
    emit(FetchShopListLoading());

    var shopResult = await shopsListUseCase.call(token);
    shopResult.fold(
      (failure) {
        emit(FetchShopListFailure(errMsg: 'shop section list failure'));
      },
      (filterModel) {
        if (isSuxes(filterModel.status)) {
          emit(
            FetchShopListSuccess(
              shopList: SectionListEntity.fromFilterModel(filterModel),
            ),
          );
        }
      },
    );
  }
}
