import 'package:dallal_proj/core/utils/service_locator.dart';
import 'package:dallal_proj/features/change_password_page/data/repos/change_password_page_repo_implement.dart';
import 'package:dallal_proj/features/change_password_page/domain/use_cases/change_password_use_case.dart';
import 'package:dallal_proj/features/change_password_page/presentation/manager/change_password_cubit/change_password_cubit.dart';
import 'package:dallal_proj/features/create_adv_page/data/repos/create_adv_page_repo_implement.dart';
import 'package:dallal_proj/features/create_adv_page/domain/use_cases/craete_media_use_case.dart';
import 'package:dallal_proj/features/create_adv_page/domain/use_cases/create_adv_use_case.dart';
import 'package:dallal_proj/features/create_adv_page/presentation/manager/create_ad_orcstr/create_ad_orcstr_cubit.dart';
import 'package:dallal_proj/features/create_adv_page/presentation/views/adv_has_been_sent_page.dart';
import 'package:dallal_proj/features/create_adv_page/presentation/views/create_adv_page.dart';
import 'package:dallal_proj/features/details_page/data/repos/details_page_repo_implement.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/details_page/domain/use_cases/fave_adv_det_use_case.dart';
import 'package:dallal_proj/features/details_page/domain/use_cases/like_adv_det_use_case.dart';
import 'package:dallal_proj/features/details_page/domain/use_cases/report_adv_use_case.dart';
import 'package:dallal_proj/features/details_page/domain/use_cases/unfave_adv_det_use_case.dart';
import 'package:dallal_proj/features/details_page/domain/use_cases/unlike_adv_det_use_case.dart';
import 'package:dallal_proj/features/details_page/presentation/manager/fave_det_cubit/fave_det_cubit.dart';
import 'package:dallal_proj/features/details_page/presentation/manager/like_det_cubit/like_det_cubit.dart';
import 'package:dallal_proj/features/details_page/presentation/manager/report_adv_cubit/report_adv_cubit.dart';
import 'package:dallal_proj/features/details_page/presentation/views/adv_details_page.dart';
import 'package:dallal_proj/features/details_page/presentation/views/adv_refused_page.dart';
import 'package:dallal_proj/features/edit_adv_info_page/data/repos/edit_adv_page_repo_implement.dart';
import 'package:dallal_proj/features/edit_adv_info_page/domain/use_cases/delete_media_use_case.dart';
import 'package:dallal_proj/features/edit_adv_info_page/domain/use_cases/update_adv_use_case.dart';
import 'package:dallal_proj/features/edit_adv_info_page/domain/use_cases/update_media_use_case.dart';
import 'package:dallal_proj/features/edit_adv_info_page/presentation/edit_ad_orcstr_cubit/edit_ad_orcstr_cubit.dart';
import 'package:dallal_proj/features/edit_adv_info_page/presentation/views/edit_adv_info_page.dart';
import 'package:dallal_proj/features/edit_personal_info/presentation/manager/edit_personal_info_cubit/edit_personal_info_cubit.dart';
import 'package:dallal_proj/features/edit_personal_info/presentation/views/edit_personal_info_page.dart';
import 'package:dallal_proj/features/favorite_page/domain/use_cases/fetch_fav_advs_use_case.dart';
import 'package:dallal_proj/features/favorite_page/presentation/manager/fetch_fav_advs_cubit/fetch_fav_advs_cubit.dart';
import 'package:dallal_proj/features/favorite_page/presentation/views/favorite_page.dart';
import 'package:dallal_proj/features/featuring_adv_page/data/repos/featuring_adv_page_repo_implement.dart';
import 'package:dallal_proj/features/featuring_adv_page/domain/use_cases/feature_the_adv_use_case.dart';
import 'package:dallal_proj/features/featuring_adv_page/presentation/manager/feature_the_adv_cubit/feature_the_adv_cubit.dart';
import 'package:dallal_proj/features/featuring_adv_page/presentation/views/featuring_adv_page.dart';
import 'package:dallal_proj/features/home_page/data/repos/home_page_repo_implement.dart';
import 'package:dallal_proj/features/home_page/domain/use_cases/fetch_all_advs_use_case.dart';
import 'package:dallal_proj/features/home_page/domain/use_cases/fetch_all_banners_use_case.dart';
import 'package:dallal_proj/features/home_page/domain/use_cases/fetch_featured_advs_use_case.dart';
import 'package:dallal_proj/features/home_page/presentation/manager/all_advs_cubit/all_advs_cubit.dart';
import 'package:dallal_proj/features/home_page/presentation/manager/all_banners_cubit/all_banners_cubit.dart';
import 'package:dallal_proj/features/home_page/presentation/manager/featured_advs_cubit/featured_advs_cubit.dart';
import 'package:dallal_proj/features/login_page/data/repos/login_page_repo_implement.dart';
import 'package:dallal_proj/features/login_page/data/repos/set_profile_repo_implement.dart';
import 'package:dallal_proj/features/login_page/domain/use_cases/login_user_use_case.dart';
import 'package:dallal_proj/features/login_page/domain/use_cases/set_profile_use_case.dart';
import 'package:dallal_proj/features/login_page/presentation/manager/login_user_cubit/login_user_cubit.dart';
import 'package:dallal_proj/features/login_page/presentation/manager/set_profile_picture_cubit/set_profile_picture_cubit.dart';
import 'package:dallal_proj/features/login_page/presentation/views/add_pfp_page.dart';
import 'package:dallal_proj/features/main_page/data/repos/main_page_repo_implement.dart';
import 'package:dallal_proj/features/main_page/presentation/views/main_page.dart';
import 'package:dallal_proj/features/my_account_page/data/models/delete_adv_req_model.dart';
import 'package:dallal_proj/features/my_account_page/data/repos/my_account_page_repo_implement.dart';
import 'package:dallal_proj/features/my_account_page/domain/use_cases/delete_adv_use_case.dart';
import 'package:dallal_proj/features/my_account_page/presentation/manager/delete_adv_cubit/delete_adv_cubit.dart';
import 'package:dallal_proj/features/notifications_page/presentation/views/notifications_page.dart';
import 'package:dallal_proj/features/package_details_page/data/repos/package_details_page_repo_implement.dart';
import 'package:dallal_proj/features/package_details_page/domain/use_cases/get_package_info_use_case.dart';
import 'package:dallal_proj/features/package_details_page/presentation/manager/get_package_info_cubit/get_package_info_cubit.dart';
import 'package:dallal_proj/features/package_details_page/presentation/views/package_details_page.dart';
import 'package:dallal_proj/features/preregister/presentation/views/pre_register_page.dart';
import 'package:dallal_proj/features/preview/presentation/views/preview_page.dart';
import 'package:dallal_proj/features/register_page/data/repos/register_page_repo_implement.dart';
import 'package:dallal_proj/features/register_page/domain/use_cases/register_user_use_case.dart';
import 'package:dallal_proj/features/register_page/presentation/manager/register_user_cubit/register_user_cubit.dart';
import 'package:dallal_proj/features/register_page/presentation/views/register_page.dart';
import 'package:dallal_proj/features/reset_password_page/data/repos/reset_password_page_repo_implement.dart';
import 'package:dallal_proj/features/reset_password_page/domain/use_cases/reset_password_use_case.dart';
import 'package:dallal_proj/features/reset_password_page/presentation/manager/reset_password_cubit/reset_password_cubit.dart';
import 'package:dallal_proj/features/sections_page/data/models/filter_req_model.dart';
import 'package:dallal_proj/features/sections_page/data/repos/section_page_repo_implement.dart';
import 'package:dallal_proj/features/sections_page/domain/entities/section_list_entity.dart';
import 'package:dallal_proj/features/sections_page/domain/use_cases/fetch_filtered_result_use_case.dart';
import 'package:dallal_proj/features/sections_page/presentation/manager/fetch_filtered_result_cubit/fetch_filtered_result_cubit.dart';
import 'package:dallal_proj/features/selected_section_page/presentation/views/search_filter_page.dart';
import 'package:dallal_proj/features/selected_section_page/presentation/views/selected_sect_page.dart';
import 'package:dallal_proj/features/splash/presentation/views/splash_view.dart';
import 'package:dallal_proj/features/login_page/presentation/views/login_page.dart';
import 'package:dallal_proj/features/change_password_page/presentation/views/change_pass_page.dart';
import 'package:dallal_proj/features/change_password_page/presentation/views/pass_change_suxeed_page.dart';
import 'package:dallal_proj/features/reset_password_page/presentation/views/reset_pass_page.dart';
import 'package:dallal_proj/features/verification_page/Domain/use_cases/send_otp_code_use_case.dart';
import 'package:dallal_proj/features/verification_page/data/repos/verification_page_repo_implement.dart';
import 'package:dallal_proj/features/verification_page/presentation/manager/send_otp_code_cubit/send_otp_code_cubit.dart';
import 'package:dallal_proj/features/verification_page/presentation/views/verification_page.dart';
import 'package:dallal_proj/features/verify_msg_page/data/repos/verify_msg_page_repo_implement.dart';
import 'package:dallal_proj/features/verify_msg_page/domain/use_cases/get_otp_msg_use_case.dart';
import 'package:dallal_proj/features/verify_msg_page/domain/use_cases/resend_otp_msg_use_case.dart';
import 'package:dallal_proj/features/verify_msg_page/domain/use_cases/verify_otp_msg_use_case.dart';
import 'package:dallal_proj/features/verify_msg_page/presentation/manager/get_otp_code_cubit/get_otp_code_cubit.dart';
import 'package:dallal_proj/features/verify_msg_page/presentation/manager/resend_otp_code_cubit/resend_otp_code_cubit.dart';
import 'package:dallal_proj/features/verify_msg_page/presentation/manager/verify_otp_code_cubit/verify_otp_code_cubit.dart';
import 'package:dallal_proj/features/verify_msg_page/presentation/views/verify_msg_page.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kPreviewPage = '/previewPage';
  static const kPreRegisterPage = '/preRegisterPage';
  static const kRegisterPage = '/registerPage';
  static const kLoginPage = '/loginPage';
  static const kVerificationPage = '/verificationPage';
  static const kVerifyMsgPage = '/verifyMsgPage';
  static const kResetPassPage = '/resetPassPage';
  static const kChangePassPage = '/changePassPage';
  static const kPassChangedSuxeed = '/passChangedSuxeedPage';
  static const kAdvHasBeenSentPage = '/advHasBeenSentPage';
  static const kAddPfpPage = '/addPfpPage';
  static const kMainPage = '/mainPage';
  static const kNotificPage = '/notificPage';
  static const kFavoritePage = '/favoritePage';
  static const kSelectedSectPage = '/selectedSectPage';
  static const kSearchFilterPage = '/searchFilterPage';
  static const kAdvDetailsPage = '/advDetailsPage';
  static const kAdvRefusedPage = '/advRefusedPage';
  static const kCrAdvPage = '/crAdvPage';
  static const kFeaturingAdvPage = '/featuringAdvPage';
  static const kPackageDetailsPage = '/packageDetailsPage';
  static const kEditPersonalInfoPage = '/editPersonalInfoPage';
  static const kEditAdvPage = '/editAdvPage';

  static final router = GoRouter(
    routes: [
      // GoRoute(path: '/', builder: (context, state) => const SplashView()),
      // GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
      GoRoute(
        path: '/',
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child:
                  const SplashView(), // or SplashViewBody if that's your entry widget
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            ),
      ),
      GoRoute(
        path: kPreviewPage,
        pageBuilder:
            (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const PreviewPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            ),
      ),
      GoRoute(
        path: kPreRegisterPage,
        builder: (context, state) => const PreRegisterPage(),
      ),
      GoRoute(
        path: kRegisterPage,
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) => RegisterUserCubit(
                    RegisterUserUseCase(getIt.get<RegisterPageRepoImplement>()),
                  ),
              child: const RegisterPage(),
            ), // your register page widget
        // BlocProvider(
        //   create: (context) => SimilarBooksCubit(getIt.get<HomeRepoImpl>()),
        //   child: BookDetailsView(bookModel: state.extra as BookModel),
        // ),
      ),
      GoRoute(
        path: kLoginPage,
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) => LoginUserCubit(
                    LoginUserUseCase(getIt.get<LoginPageRepoImplement>()),
                  ),
              child: const LoginPage(),
            ),
      ),
      GoRoute(
        path: kVerificationPage,
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) => SendOtpCodeCubit(
                    SendOtpCodeUseCase(
                      getIt.get<VerificationPageRepoImplement>(),
                    ),
                  ),
              child: const VerificationPage(),
            ),
      ),
      GoRoute(
        path: kVerifyMsgPage,
        name: kVerifyMsgPage,
        builder: (context, state) {
          final vMsgModel = state.extra as VerifyMsgViewModel;
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create:
                    (context) => VerifyOtpCodeCubit(
                      VerifyOtpMsgUseCase(
                        getIt.get<VerifyMsgPageRepoImplement>(),
                      ),
                    ),
              ),
              BlocProvider(
                create:
                    (context) => GetOtpCodeCubit(
                      GetOtpMsgUseCase(getIt.get<VerifyMsgPageRepoImplement>()),
                    )..getOtpCodeMsg(vMsgModel.phone),
              ),
              BlocProvider(
                create:
                    (context) => ResendOtpCodeCubit(
                      ResendOtpMsgUseCase(
                        getIt.get<VerifyMsgPageRepoImplement>(),
                      ),
                    ),
              ),
            ],
            child: VerifyMsgPage(vMsgModel: vMsgModel),
          );
        },
      ),
      GoRoute(
        path: kResetPassPage,
        name: kResetPassPage,
        builder: (context, state) {
          final String phone = state.extra as String;
          return BlocProvider(
            create:
                (context) => ResetPasswordCubit(
                  ResetPasswordUseCase(
                    getIt.get<ResetPasswordPageRepoImplement>(),
                  ),
                ),
            child: ResetPassPage(phone: phone),
          );
        },
      ),
      GoRoute(
        path: kPassChangedSuxeed,
        builder: (context, state) => const PassChangeSuxeedPage(),
      ),
      GoRoute(
        path: kAddPfpPage,
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) => SetProfileCubit(
                    SetProfileUseCase(
                      repo: getIt.get<SetProfileRepoImplement>(),
                    ),
                  ),
              child: const AddPfpPage(),
            ),
      ),
      GoRoute(
        path: kMainPage,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create:
                    (context) => AllAdvsCubit(
                      FetchAllAdvsUseCase(
                        homePageRepo: getIt.get<HomePageRepoImplement>(),
                      ),
                    )..fetchAllAdvs(null),
              ),
              BlocProvider(
                create:
                    (context) => FeaturedAdvsCubit(
                      FetchFeaturedAdvsUseCase(
                        getIt.get<HomePageRepoImplement>(),
                      ),
                    )..fetchFeaturedAdvs(null),
              ),
              BlocProvider(
                create:
                    (context) => AllBannersCubit(
                      FetchAllBannersUseCase(
                        homePageRepo: getIt.get<HomePageRepoImplement>(),
                      ),
                    )..fetchAllBanners(),
              ),
            ],
            child: const MainPage(),
          );
        },
      ),
      GoRoute(
        path: kNotificPage,
        builder: (context, state) => const NotificPage(),
      ),
      GoRoute(
        path: kFavoritePage,
        name: kFavoritePage,
        builder: (context, state) {
          final String token = state.extra as String;
          return BlocProvider(
            create:
                (context) => FetchFavAdvsCubit(
                  FetchFavAdvsUseCase(
                    mainPageRepo: getIt.get<MainPageRepoImplement>(),
                  ),
                )..fetchFavAdvs(token),
            child: FavoritePage(token: token),
          );
        },
      ),
      GoRoute(
        path: kSelectedSectPage,
        name: kSelectedSectPage, // Needed for pushNamed to work
        builder: (context, state) {
          final sectionListEntity = state.extra as SectionListEntity;
          return SelectedSectPage(sectionListEntity: sectionListEntity);
        },
      ),
      GoRoute(
        path: kSearchFilterPage,
        name: kSearchFilterPage, // Needed for pushNamed to work
        builder: (context, state) {
          final filterReqModel = state.extra as FilterReqModel;
          return BlocProvider(
            create:
                (context) => FetchFilteredResultCubit(
                  FetchFilteredResultUseCase(
                    getIt.get<SectionPageRepoImplement>(),
                  ),
                )..fetchFilteredResult(filterReqModel),
            child: SearchFilterPage(initialFilter: filterReqModel),
          );
        },
      ),
      GoRoute(
        path: kChangePassPage,
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) => ChangePasswordCubit(
                    ChangePasswordUseCase(
                      changePasswordPageRepo:
                          getIt.get<ChangePasswordPageRepoImplement>(),
                    ),
                  ),
              child: const ChangePassPage(),
            ),
      ),
      GoRoute(
        path: kAdvDetailsPage,
        name: kAdvDetailsPage,
        builder: (context, state) {
          final detailsEntity = state.extra as ShowDetailsEntity;
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create:
                    (context) => ReportAdvCubit(
                      ReportAdvUseCase(
                        detailsPageRepo: getIt.get<DetailsPageRepoImplement>(),
                      ),
                    ),
                // child: Container(),
              ),
              BlocProvider(
                create:
                    (context) => FaveDetCubit(
                      FaveAdvDetUseCase(getIt.get<DetailsPageRepoImplement>()),
                      UnfaveAdvDetUseCase(
                        getIt.get<DetailsPageRepoImplement>(),
                      ),
                    ),
                child: Container(),
              ),
              BlocProvider(
                create:
                    (context) => LikeDetCubit(
                      LikeAdvDetUseCase(getIt.get<DetailsPageRepoImplement>()),
                      UnlikeAdvDetUseCase(
                        getIt.get<DetailsPageRepoImplement>(),
                      ),
                    ),
                // child: Container(),
              ),
            ],
            // create: (context) => SubjectBloc(),
            child: AdvDetailsPage(detailsEntity: detailsEntity),
          );
        },
      ),
      GoRoute(
        path: kAdvRefusedPage,
        name: kAdvRefusedPage,
        builder: (context, state) {
          final detShowModel = state.extra as ShowDetailsEntity;
          return BlocProvider(
            create:
                (context) => DeleteAdvCubit(
                  DeleteAdvUseCase(
                    myAccountPageRepo: getIt.get<MyAccountPageRepoImplement>(),
                  ),
                ),
            child: AdvRefusedPage(detailsEntity: detShowModel),
          );
        },
      ),
      GoRoute(
        path: kCrAdvPage,
        name: kCrAdvPage, // Needed for pushNamed to work
        builder: (context, state) {
          final title = state.extra as String;
          return BlocProvider(
            create:
                (context) => CreateAdOrcstrCubit(
                  createAdvUseCase: CreateAdvUseCase(
                    advPageRepo: getIt.get<CreateAdvPageRepoImplement>(),
                  ),
                  createMediaUseCase: CreateMediaUseCase(
                    advPageRepo: getIt.get<CreateAdvPageRepoImplement>(),
                  ),
                ),
            child: CreateAdvPage(title: title),
          );
        },
      ),
      GoRoute(
        path: kAdvHasBeenSentPage,
        builder: (context, state) => const AdvHasBeenSentPage(),
      ),
      GoRoute(
        path: kEditPersonalInfoPage,
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) => EditPersonalInfoCubit(
                    SetProfileUseCase(
                      repo: getIt.get<SetProfileRepoImplement>(),
                    ),
                  ),
              child: const EditPersonalInfoPage(),
            ),
      ),
      GoRoute(
        path: kFeaturingAdvPage,
        name: kFeaturingAdvPage,
        builder: (context, state) {
          final String adID = state.extra as String;
          return BlocProvider(
            create:
                (context) => FeatureTheAdvCubit(
                  FeatureTheAdvUseCase(
                    featuringAdvPageRepo:
                        getIt.get<FeaturingAdvPageRepoImplement>(),
                  ),
                ),
            child: FeaturingAdvPage(adID: adID),
          );
        },
      ),
      GoRoute(
        path: kPackageDetailsPage,
        name: kPackageDetailsPage,
        builder: (context, state) {
          final idTokenModel = state.extra as DeleteAdvReqModel;
          return BlocProvider(
            create:
                (context) => GetPackageInfoCubit(
                  GetPackageInfoUseCase(
                    packageDetailsPageRepo:
                        getIt.get<PackageDetailsPageRepoImplement>(),
                  ),
                )..getPackageInfo(idTokenModel),
            child: const PackageDetailsPage(),
          );
        },
      ),
      GoRoute(
        path: kEditAdvPage,
        name: kEditAdvPage,
        builder: (context, state) {
          final extra = state.extra as ShowDetailsEntity;
          return BlocProvider(
            create:
                (context) => EditAdOrcstrCubit(
                  updateMediaUseCase: UpdateMediaUseCase(
                    editAdvPageRepo: getIt.get<EditAdvPageRepoImplement>(),
                  ),
                  deleteMediaUseCase: DeleteMediaUseCase(
                    editAdvPageRepo: getIt.get<EditAdvPageRepoImplement>(),
                  ),
                  updateAdvUseCase: UpdateAdvUseCase(
                    editAdvPageRepo: getIt.get<EditAdvPageRepoImplement>(),
                  ),
                ),
            child: EditAdvInfoPage(detailsEntity: extra),
          );
        },
      ),
    ],
  );
}
