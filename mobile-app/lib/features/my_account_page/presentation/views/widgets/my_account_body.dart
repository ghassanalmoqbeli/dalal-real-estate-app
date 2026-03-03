import 'package:dallal_proj/core/constants/app_defs.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/login_page/domain/entities/loggedin_user_entity.dart';
import 'package:dallal_proj/features/my_account_page/data/models/user_profile/user_profile.dart';
import 'package:dallal_proj/features/my_account_page/presentation/manager/user_profile_cubit/user_profile_cubit.dart';
import 'package:dallal_proj/features/my_account_page/presentation/views/widgets/card_grid_view.dart';
import 'package:dallal_proj/features/my_account_page/presentation/views/widgets/edit_personal_info.dart';
import 'package:dallal_proj/features/my_account_page/presentation/views/widgets/fade_slide_switcher.dart';
import 'package:dallal_proj/features/my_account_page/presentation/views/widgets/mid_nav_bar/mid_nav_bar.dart';
import 'package:dallal_proj/features/my_account_page/presentation/views/widgets/personal_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyAccountBody extends StatefulWidget {
  const MyAccountBody({super.key, required this.userProfile});
  final UserProfile userProfile;
  @override
  State<MyAccountBody> createState() => _MyAccountBodyState();
}

class _MyAccountBodyState extends State<MyAccountBody> {
  int selectedIndex = kDefMidNavBarSelectedIndex;
  late LoggedinUserEntity userData;
  late Map<int, List<ShowDetailsEntity>> mMap;

  @override
  void initState() {
    mMap = widget.userProfile.data!.ads!.toMyAccMap();
    userData = getMeData() ?? _getMeData(widget.userProfile);
    super.initState();
  }

  LoggedinUserEntity _getMeData(UserProfile userProfile) => LoggedinUserEntity(
    uId: userProfile.data?.user!.id,
    uName: userProfile.data!.user!.name,
    uPhone: userProfile.data!.user!.phone,
    uProfileImage: userProfile.data!.user!.profileImage,
    uWhatsapp: userProfile.data!.user!.whatsapp,
  );

  void _onNavTap(int index) {
    if (selectedIndex != index) {
      setState(() => selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    void isEdited(Object? result) {
      if (result != null && result == true) {
        BlocProvider.of<UserProfileCubit>(
          context,
        ).fetchUserProfile(userData.uToken!);
        setState(() {
          userData = getMeData()!;
        });
      }
    }

    return RefreshIndicator(
      backgroundColor: kWhite,
      color: kPrimColG,
      onRefresh: () async {
        context.read<UserProfileCubit>().fetchUserProfile(userData.uToken);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: Column(
          children: [
            VPItem(
              tSpc: 40,
              bSpc: 32,
              child: EditPersonalInfo(
                onTap: () async {
                  var result = await GoRouter.of(
                    context,
                  ).push(AppRouter.kEditPersonalInfoPage);

                  isEdited(result);
                },
              ),
            ),
            PersonalInfoCard(
              name: userData.uName ?? 'Error',
              phone: userData.uPhone ?? 'Error',
              whatsAppNum: userData.uWhatsapp,
              img: userData.uProfileImage,
            ),

            VPItem(
              tSpc: 40,
              bSpc: 20,
              child: MidNavBar(
                selectedIndex: selectedIndex,
                onNavTap: _onNavTap,
              ),
            ),
            FadeSlideSwitcher(
              child: CardGridView(
                items: mMap[selectedIndex] ?? [],
                selectedIndex: selectedIndex,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
