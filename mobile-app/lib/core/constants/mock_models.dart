import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/constants/str_lists.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/temp_try.dart';

const kPropCkbModel = OptionsListModel(
  title: kPropertyType,
  options: CLstr.propertyType,
);

const int tfModelLength = 4;

const List<String> kTFModelTitles = [
  kKitchenCount,
  kBathsCount,
  kHallsCount,
  kRoomsCount,
];

// const TFModel kPropSectVM = TFModel(widthF: widthF, codeLength: codeLength, controllers: controllers, titles: titles, fNodes: fNodes)
const kIsNegot = OptionsListModel(
  title: '$kNegotiatable؟   ',
  options: CLstr.isOnlyPremOpts,
);
const kOfferCkbModel = OptionsListModel(
  title: kOfferType,
  options: CLstr.offerType,
);

const kAdvicesOLM = OptionsListModel(title: kAdvices, options: CLstr.advices);

const kOrderByRBModel = OptionsListModel(
  title: kOrderResultsBy,
  options: CLstr.orderByOptions,
);

const kReportRBModel = OptionsListModel(
  title: kReportTitle,
  options: CLstr.reportOptions,
);

const kOnlyPremOptModel = OptionsListModel(
  title: kIsOnlyPremiumResults,
  options: CLstr.isOnlyPremOpts,
);

const kCrAdvCardHouse = SectCardModel(
  name: kHouse,
  pTitle: '$kCreateAdv - $kHouse',
  img: AssetsData.crAdvHouse,
  routePath: AppRouter.kCrAdvPage,
);

const kCrAdvCardApt = SectCardModel(
  name: kApt,
  pTitle: '$kCreateAdv - $kApt',
  img: AssetsData.crAdvApt,
  routePath: AppRouter.kCrAdvPage,
);

const kCrAdvCardStore = SectCardModel(
  name: kStore,
  pTitle: '$kCreateAdv - $kStore',
  img: AssetsData.crAdvStore,
  routePath: AppRouter.kCrAdvPage,
);

const kCrAdvCardGrnd = SectCardModel(
  name: kGround,
  pTitle: '$kCreateAdv - $kGround',
  img: AssetsData.crAdvGround,
  routePath: AppRouter.kCrAdvPage,
);

const kSectCardHouses = SectCardModel(
  name: kHouses,
  img: AssetsData.housesSvg,
  routePath: AppRouter.kSelectedSectPage,
);

const kSectCardApts = SectCardModel(
  name: kApts,
  img: AssetsData.appartmentsSvg,
  routePath: AppRouter.kSelectedSectPage,
);

const kSectCardStores = SectCardModel(
  name: kStores,
  img: AssetsData.storesSvg,
  routePath: AppRouter.kSelectedSectPage,
);

const kSectCardGrnds = SectCardModel(
  name: kGrounds,
  img: AssetsData.groundsSvg,
  routePath: AppRouter.kSelectedSectPage,
);
