import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/features/more_page/presentation/views/widgets/items/more_body_item.dart';

class FBars {
  static MoreBodyItem changePass(void Function()? onTap) =>
      fBar(onTap, AssetsData.kMoreChangePass, kCangePass);

  static MoreBodyItem logOut(void Function()? onTap) =>
      fBar(onTap, AssetsData.kMoreLogout, kLogOut);

  static MoreBodyItem delAcc(void Function()? onTap) =>
      fBar(onTap, AssetsData.kMoreDelAcc, kDelAcc);

  static MoreBodyItem aboutUs(void Function()? onTap) =>
      fBar(onTap, AssetsData.kMoreInfo, kAboutUs);

  static MoreBodyItem prvNpoltcs(void Function()? onTap) =>
      fBar(onTap, AssetsData.kMorePrivNPoltcs, kPrvNpoltcs);

  static MoreBodyItem condUsing(void Function()? onTap) =>
      fBar(onTap, AssetsData.kMoreCondUsing, kCondUsing);

  static MoreBodyItem contactUs(void Function()? onTap) =>
      fBar(onTap, AssetsData.kMoreContactUs, kContactUs);

  static MoreBodyItem rateUs(void Function()? onTap) =>
      fBar(onTap, AssetsData.kMoreRateUs, kRateUs);

  static MoreBodyItem shareApp(void Function()? onTap) =>
      fBar(onTap, AssetsData.kMoreShareApp, kShareApp);

  static MoreBodyItem appVersion(void Function()? onTap) =>
      fBar(onTap, AssetsData.kMoreAppVersion, kAppVersion);

  static MoreBodyItem fBar(void Function()? onTap, String img, String text) =>
      MoreBodyItem(text: text, img: img, onTap: onTap);
}
