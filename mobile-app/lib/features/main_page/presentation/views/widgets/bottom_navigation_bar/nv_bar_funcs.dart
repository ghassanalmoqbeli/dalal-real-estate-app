import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/core/utils/service_locator.dart';
import 'package:dallal_proj/features/main_page/data/repos/main_page_repo_implement.dart';
import 'package:dallal_proj/features/main_page/domain/use_cases/fetch_user_profile_use_case.dart';
import 'package:dallal_proj/features/more_page/data/repos/more_page_repo_implement.dart';
import 'package:dallal_proj/features/more_page/domain/use_cases/delete_accout_use_case.dart';
import 'package:dallal_proj/features/more_page/presentation/delete_account_cubit/delete_account_cubit.dart';
import 'package:dallal_proj/features/my_account_page/data/repos/my_account_page_repo_implement.dart';
import 'package:dallal_proj/features/my_account_page/domain/use_cases/delete_adv_use_case.dart';
import 'package:dallal_proj/features/my_account_page/presentation/manager/delete_adv_cubit/delete_adv_cubit.dart';
import 'package:dallal_proj/features/my_account_page/presentation/manager/user_profile_cubit/user_profile_cubit.dart';
import 'package:dallal_proj/features/notifications_page/data/repos/notifications_page_repo_implement.dart';
import 'package:dallal_proj/features/notifications_page/domain/use_cases/get_unread_count_use_case.dart';
import 'package:dallal_proj/features/notifications_page/presentation/manager/unread_count_cubit/unread_count_cubit.dart';
import 'package:dallal_proj/features/sections_page/data/repos/section_page_repo_implement.dart';
import 'package:dallal_proj/features/sections_page/domain/use_cases/fetch_apt_list_use_case.dart';
import 'package:dallal_proj/features/sections_page/domain/use_cases/fetch_houses_list_use_case.dart';
import 'package:dallal_proj/features/sections_page/domain/use_cases/fetch_lands_list_use_case.dart';
import 'package:dallal_proj/features/sections_page/domain/use_cases/fetch_shops_list_use_case.dart';
import 'package:dallal_proj/features/sections_page/presentation/manager/fetch_apt_list_cubit/fetch_apt_list_cubit.dart';
import 'package:dallal_proj/features/sections_page/presentation/manager/fetch_house_list_cubit/fetch_house_list_cubit.dart';
import 'package:dallal_proj/features/sections_page/presentation/manager/fetch_land_list_cubit/fetch_land_list_cubit.dart';
import 'package:dallal_proj/features/sections_page/presentation/manager/fetch_shop_list_cubit/fetch_shop_list_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:dallal_proj/features/home_page/presentation/views/home_page.dart';
import 'package:dallal_proj/features/more_page/presentation/views/more_page.dart';
import 'package:dallal_proj/features/sections_page/presentation/views/sections_page.dart';
import 'package:dallal_proj/features/my_account_page/presentation/views/my_account_page.dart';
import 'package:dallal_proj/features/create_adv_page/presentation/views/create_adv_selection_page.dart';

class NvBar {
  static List<Widget> screens() {
    return [
      BlocProvider(
        create:
            (context) => DeleteAccountCubit(
              DeleteAccountUseCase(
                morePageRepo: getIt.get<MorePageRepoImplement>(),
              ),
            ),
        child: const MorePage(),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              var user = getMeData();
              return UserProfileCubit(
                FetchUserProfileUseCase(getIt.get<MainPageRepoImplement>()),
              )..fetchUserProfile(user?.uToken);
            },
          ),
          BlocProvider(
            create: (context) {
              return DeleteAdvCubit(
                DeleteAdvUseCase(
                  myAccountPageRepo: getIt.get<MyAccountPageRepoImplement>(),
                ),
              );
            },
          ),
        ],
        child: const MyAccountPage(),
      ),
      const CreateAdvSelectionPage(),
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              var user = getMeData();
              return FetchAptListCubit(
                FetchAptsListUseCase(getIt.get<SectionPageRepoImplement>()),
              )..fetchAptList(user?.uToken);
            },
          ),
          BlocProvider(
            create: (context) {
              var user = getMeData();
              return FetchHouseListCubit(
                FetchHousesListUseCase(getIt.get<SectionPageRepoImplement>()),
              )..fetchHouseList(user?.uToken);
            },
          ),
          BlocProvider(
            create: (context) {
              var user = getMeData();
              return FetchShopListCubit(
                FetchShopsListUseCase(getIt.get<SectionPageRepoImplement>()),
              )..fetchShopList(user?.uToken);
            },
          ),
          BlocProvider(
            create: (context) {
              var user = getMeData();
              return FetchLandListCubit(
                FetchLandsListUseCase(getIt.get<SectionPageRepoImplement>()),
              )..fetchLandList(user?.uToken);
            },
          ),
        ],
        child: const SectionsPage(),
      ),
      BlocProvider(
        create: (context) {
          var user = getMeData();
          return UnreadCountCubit(
            GetUnreadCountUseCase(
              notificationsPageRepo:
                  getIt.get<NotificationsPageRepoImplement>(),
            ),
          )..getUnreadCount(user?.uToken ?? '');
        },
        child: const HomePage(),
      ),
    ];
  }

  static List<PersistentBottomNavBarItem> items() {
    return [
      navItem(title: kMoreP, ico: AssetsData.menuSvg),
      navItem(title: kMyAccP, ico: AssetsData.usertSvg),
      navItem(title: kAdvP, ico: AssetsData.addSquaretSvg),
      navItem(title: kSectsP, ico: AssetsData.sectionsSvg),
      navItem(title: kMainP, ico: AssetsData.homeSvg),
    ];
  }

  static PersistentBottomNavBarItem navItem({
    required String title,
    required String ico,
  }) {
    return PersistentBottomNavBarItem(
      iconSize: 24,
      icon: SvgPicture.asset(ico),
      title: title,
      activeColorPrimary: kPrimColG,
      inactiveColorPrimary: kGrey,
    );
  }

  static NavBarAnimationSettings animationSettings() {
    return const NavBarAnimationSettings(
      navBarItemAnimation: ItemAnimationSettings(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimationSettings(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        duration: Duration(milliseconds: 400),
        screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
      ),
    );
  }
}
