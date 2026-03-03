import 'package:dallal_proj/core/components/app_cards/property_card/v_card/v_card_item.dart';
import 'package:dallal_proj/core/utils/service_locator.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/home_page/data/repos/home_page_repo_implement.dart';
import 'package:dallal_proj/features/home_page/domain/use_cases/fave_adv_use_case.dart';
import 'package:dallal_proj/features/home_page/domain/use_cases/like_adv_use_case.dart';
import 'package:dallal_proj/features/home_page/domain/use_cases/unfave_adv_use_case.dart';
import 'package:dallal_proj/features/home_page/domain/use_cases/unlike_adv_use_case.dart';
import 'package:dallal_proj/features/home_page/presentation/manager/fav_cubit/fav_cubit.dart';
import 'package:dallal_proj/features/home_page/presentation/manager/like_cubit/like_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VCardItemProvider extends StatelessWidget {
  const VCardItemProvider({super.key, required this.cardModel});
  final ShowDetailsEntity cardModel;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => FaveCubit(
                FaveAdvUseCase(
                  homePageRepo: getIt.get<HomePageRepoImplement>(),
                ),
                UnfaveAdvUseCase(
                  homePageRepo: getIt.get<HomePageRepoImplement>(),
                ),
              ),
        ),
        BlocProvider(
          create:
              (context) => LikeCubit(
                LikeAdvUseCase(
                  homePageRepo: getIt.get<HomePageRepoImplement>(),
                ),
                UnlikeAdvUseCase(
                  homePageRepo: getIt.get<HomePageRepoImplement>(),
                ),
              ),
        ),
      ],
      child: VCardItem(cardModel: cardModel),
    );
  }
}
