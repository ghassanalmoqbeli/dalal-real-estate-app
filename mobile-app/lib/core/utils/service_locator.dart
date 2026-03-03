import 'package:dallal_proj/core/utils/api.dart';
import 'package:dallal_proj/features/ai_price_prediction/data/data_source/ai_api_service.dart';
import 'package:dallal_proj/features/ai_price_prediction/data/data_source/ai_prediction_remote_data_source.dart';
import 'package:dallal_proj/features/ai_price_prediction/data/repos/ai_prediction_repo_impl.dart';
import 'package:dallal_proj/features/change_password_page/data/data_source/change_password_remote_data_source.dart';
import 'package:dallal_proj/features/change_password_page/data/repos/change_password_page_repo_implement.dart';
import 'package:dallal_proj/features/create_adv_page/data/data_source/create_adv_remote_data_source.dart';
import 'package:dallal_proj/features/create_adv_page/data/repos/create_adv_page_repo_implement.dart';
import 'package:dallal_proj/features/details_page/data/data_sources/details_remote_data_source.dart';
import 'package:dallal_proj/features/details_page/data/repos/details_page_repo_implement.dart';
import 'package:dallal_proj/features/edit_adv_info_page/data/data_sources/edit_adv_remote_data_source.dart';
import 'package:dallal_proj/features/edit_adv_info_page/data/repos/edit_adv_page_repo_implement.dart';
import 'package:dallal_proj/features/featuring_adv_page/data/data_source/featuring_adv_remote_data_source.dart';
import 'package:dallal_proj/features/featuring_adv_page/data/repos/featuring_adv_page_repo_implement.dart';
import 'package:dallal_proj/features/home_page/data/data_sources/home_local_data_source.dart';
import 'package:dallal_proj/features/home_page/data/data_sources/home_remote_data_source.dart';
import 'package:dallal_proj/features/home_page/data/repos/home_page_repo_implement.dart';
import 'package:dallal_proj/features/login_page/data/data_resources/login_local_data_source.dart';
import 'package:dallal_proj/features/login_page/data/data_resources/login_remote_data_source.dart';
import 'package:dallal_proj/features/login_page/data/data_resources/set_profile_remote_data_source.dart';
import 'package:dallal_proj/features/login_page/data/repos/login_page_repo_implement.dart';
import 'package:dallal_proj/features/login_page/data/repos/set_profile_repo_implement.dart';
import 'package:dallal_proj/features/main_page/data/data_source/main_remote_data_source.dart';
import 'package:dallal_proj/features/main_page/data/repos/main_page_repo_implement.dart';
import 'package:dallal_proj/features/more_page/data/data_source/more_remote_data_source.dart';
import 'package:dallal_proj/features/more_page/data/repos/more_page_repo_implement.dart';
import 'package:dallal_proj/features/my_account_page/data/data_source/my_account_remote_data_source.dart';
import 'package:dallal_proj/features/my_account_page/data/repos/my_account_page_repo_implement.dart';
import 'package:dallal_proj/features/notifications_page/data/data_source/notifications_remote_data_source.dart';
import 'package:dallal_proj/features/notifications_page/data/repos/notifications_page_repo_implement.dart';
import 'package:dallal_proj/features/package_details_page/data/data_source/package_details_remote_data_source.dart';
import 'package:dallal_proj/features/package_details_page/data/repos/package_details_page_repo_implement.dart';
import 'package:dallal_proj/features/register_page/data/data_resources/register_remote_data_source.dart';
import 'package:dallal_proj/features/register_page/data/repos/register_page_repo_implement.dart';
import 'package:dallal_proj/features/reset_password_page/data/data_sources/reset_password_remote_data_source.dart';
import 'package:dallal_proj/features/reset_password_page/data/repos/reset_password_page_repo_implement.dart';
import 'package:dallal_proj/features/sections_page/data/data_source/sections_remote_data_source.dart';
import 'package:dallal_proj/features/sections_page/data/repos/section_page_repo_implement.dart';
import 'package:dallal_proj/features/verification_page/data/data_resources/verification_remote_data_source.dart';
import 'package:dallal_proj/features/verification_page/data/repos/verification_page_repo_implement.dart';
import 'package:dallal_proj/features/verify_msg_page/data/data_resources/verify_msg_remote_data_source.dart';
import 'package:dallal_proj/features/verify_msg_page/data/repos/verify_msg_page_repo_implement.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<Api>(Api());

  // AI Price Prediction Service Registration
  getIt.registerSingleton<AiApiService>(AiApiService());
  getIt.registerSingleton<AiPredictionRepoImpl>(
    AiPredictionRepoImpl(
      remoteDataSource: AiPredictionRemoteDataSourceImpl(
        aiApiService: getIt.get<AiApiService>(),
      ),
    ),
  );

  getIt.registerSingleton<RegisterPageRepoImplement>(
    RegisterPageRepoImplement(
      remoteDataSource: RegisterRemoteDataSourceImplement(getIt.get<Api>()),
    ),
  );

  getIt.registerSingleton<VerifyMsgPageRepoImplement>(
    VerifyMsgPageRepoImplement(
      remoteDataSource: VerifyMsgRemoteDataSourceImplement(getIt.get<Api>()),
    ),
  );
  getIt.registerSingleton<VerificationPageRepoImplement>(
    VerificationPageRepoImplement(
      remoteDataSource: VerificationRemoteDataSourceImplement(getIt.get<Api>()),
    ),
  );
  getIt.registerSingleton<LoginPageRepoImplement>(
    LoginPageRepoImplement(
      remoteDataSource: LoginRemoteDataSourceImplement(getIt.get<Api>()),
      localDataSource: LoginLocalDataSourceImplement(),
    ),
  );
  getIt.registerSingleton<ResetPasswordPageRepoImplement>(
    ResetPasswordPageRepoImplement(
      remoteDataSource: ResetPasswordRemoteDataSourceImplement(
        getIt.get<Api>(),
      ),
    ),
  );
  getIt.registerSingleton<HomePageRepoImplement>(
    HomePageRepoImplement(
      remoteDataSource: HomeRemoteDataSourceImplement(api: getIt.get<Api>()),
      localDataSource: HomeLocalDataSourceImplement(),
    ),
  );
  getIt.registerSingleton<DetailsPageRepoImplement>(
    DetailsPageRepoImplement(
      remoteDataSource: DetailsRemoteDataSourceImplement(api: getIt.get<Api>()),
    ),
  );
  getIt.registerSingleton<MainPageRepoImplement>(
    MainPageRepoImplement(
      remoteDataSource: MainRemoteDataSourceImplement(api: getIt.get<Api>()),
    ),
  );
  getIt.registerSingleton<SectionPageRepoImplement>(
    SectionPageRepoImplement(
      remoteDataSource: SectionsRemoteDataSourceImplement(
        api: getIt.get<Api>(),
      ),
    ),
  );
  getIt.registerSingleton<CreateAdvPageRepoImplement>(
    CreateAdvPageRepoImplement(
      remoteDataSource: CreateAdvRemoteDataSourceImplement(
        api: getIt.get<Api>(),
      ),
    ),
  );
  getIt.registerSingleton<EditAdvPageRepoImplement>(
    EditAdvPageRepoImplement(
      remoteDataSource: EditAdvRemoteDataSourceImplement(api: getIt.get<Api>()),
    ),
  );

  // getIt.registerSingleton<EditAdvPageRepoImplement>(
  //   EditAdvPageRepoImplement(
  //     remoteDataSource: getIt.get<EditAdvRemoteDataSourceImplement>(),
  //   ),
  // );

  getIt.registerSingleton<MyAccountPageRepoImplement>(
    MyAccountPageRepoImplement(
      remoteDataSource: MyAccountRemoteDataSourceImplement(
        api: getIt.get<Api>(),
      ),
    ),
  );
  getIt.registerSingleton<FeaturingAdvPageRepoImplement>(
    FeaturingAdvPageRepoImplement(
      remoteDataSource: FeaturingAdvRemoteDataSourceImplement(
        api: getIt.get<Api>(),
      ),
    ),
  );
  getIt.registerSingleton<PackageDetailsPageRepoImplement>(
    PackageDetailsPageRepoImplement(
      remoteDataSource: PackageDetailsRemoteDataSourceImplement(
        api: getIt.get<Api>(),
      ),
    ),
  );
  getIt.registerSingleton<ChangePasswordPageRepoImplement>(
    ChangePasswordPageRepoImplement(
      remoteDataSource: ChangePasswordRemoteDataSourceImplement(
        api: getIt.get<Api>(),
      ),
    ),
  );
  getIt.registerSingleton<MorePageRepoImplement>(
    MorePageRepoImplement(
      remoteDataSource: MoreRemoteDataSourceImplement(api: getIt.get<Api>()),
    ),
  );
  getIt.registerSingleton<SetProfileRepoImplement>(
    SetProfileRepoImplement(
      remoteDataSource: SetProfileRemoteDataSourceImplement(
        api: getIt.get<Api>(),
      ),
    ),
  );
  getIt.registerSingleton<NotificationsPageRepoImplement>(
    NotificationsPageRepoImplement(
      remoteDataSource: NotificationsRemoteDataSourceImplement(
        api: getIt.get<Api>(),
      ),
    ),
  );
  // getIt.registerSingleton(instance)
  // Registering SimilarBooksCubit so it's globally available
  // getIt.registerSingleton<SimilarBooksCubit>(
  //   SimilarBooksCubit(getIt.get<HomeRepoImpl>()),
  // );
  // getIt.registerSingleton<SearchRepoImpl>(
  //   SearchRepoImpl(getIt.get<ApiService>()),
  // );
}
