import 'package:dallal_proj/core/constants/test_prop_dal.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/features/my_account_page/presentation/views/widgets/personal_info_card.dart';
import 'package:dallal_proj/temp_try.dart';

const kUserModel = UserModel();

final promv = const PropFunds(
  imgs: [AssetsData.appartmentsSvg],
  title: 'fucken mah',
  city: 'sanaa',
  area: '768',
  location: 'hasaba',
  onMap: 'lalal',
  offerTypeDal: PropOfferTypeDal.full,
  price: '98798',
  currency: PropCurrency.sar,
  isNegot: true,
  additionalInfo: 'dd',
  propTypeDal: PropTypeDal.house,
);

final kFundPckgModel = PckgInfModel(
  type: PackageType.fund,
  startDate: DateTime(2025, 11, 4),
  /*DateTime.now()*/
  // frame: '30',
);

final kSpecialPckgModel = PckgInfModel(
  type: PackageType.special,
  startDate: DateTime(2025, 11, 4),
  /*DateTime.now()*/
  // frame: 60,
);

final kGoldenPckgModel = PckgInfModel(
  type: PackageType.golden,
  startDate: DateTime(2025, 11, 4),
  /*DateTime.now()*/
  // frame: 90,
);

const kPersonalInfoCardMockModel = PersonalInfoCard(
  name: 'احمد علي الرازي',
  phone: '777777282788273',
  whatsAppNum: '7772837648732',
  img: null,
);

const kMyCardModel = NCardModel(
  '10',
  isMine: false,
  section: 'منزل',
  isLiked: true,
  isfaved: true,
  isPremium: true,
  img: [AssetsData.propertyJpg],
  title: 'بيت ثلاثة دور',
  price: '100000 ريال يمني',
  location: 'صنعاء - شارع المقالح',
  status: true,
);
