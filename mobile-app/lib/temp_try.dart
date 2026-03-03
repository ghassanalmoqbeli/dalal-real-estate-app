import 'package:dallal_proj/core/constants/app_defs.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/constants/mock_models.dart';
import 'package:dallal_proj/core/constants/test_mock_models.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/components/app_labels/lbl_row.dart';
import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:flutter/material.dart';
import 'package:dallal_proj/core/widgets/custom_app_bar.dart';
import 'package:intl/intl.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      body: const Center(child: Text('App Settings')),
    );
  }
}

class AddAdvPage extends StatelessWidget {
  const AddAdvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'إعلانات', showBackButton: false),
      body: Center(child: Text('قيد الإنشاء يسطا')),
    );
  }
}

////////////Important/////////////////
// class FullName {
//   final UserModel _userModel;

//   FullName._(this._userModel);

//   factory FullName.fromUserModel(UserModel userModel) {
//     return FullName._(userModel);
//   }

//   String get fullName => '${_userModel.fName} ${_userModel.mName} ${_userModel.lName}';
// }

enum PackageType {
  fund(kFund, AssetsData.grDiamond, Color(0xFF21C59F), '10', '30', '24'),
  special(kSpecial, AssetsData.blDiamond, Color(0xFF0069C8), '20', '60', '25'),
  golden(kGolden, AssetsData.oraDiamond, Color(0xFFFF9441), '30', '90', '26');

  final String name, img, price, frame, id;
  final Color color;

  const PackageType(
    this.name,
    this.img,
    this.color,
    this.price,
    this.frame,
    this.id,
  );
}

enum PackageCardType {
  single(
    16,
    106,
    25,
    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  ),
  multi(
    8,
    84,
    20,
    TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
  );
  // golden(kGolden, AssetsData.oraDiamond, Color(0xFFFF9441), '30', '90');

  final double padding, imgSize, icoSize;
  final TextStyle titleStyle, detsStyle, dtStyle;

  const PackageCardType(
    this.padding,
    this.imgSize,
    this.icoSize,
    this.titleStyle,
    this.detsStyle,
    this.dtStyle,
  );
}

enum VerifyMsgType {
  verifyUser,
  resetPass, //('reset',), //AppRouter.kResetPassPage),
  logUsr, //('login', ),//null),
  changeNumber; //('changeNum'); //null);

  // final String typeName;
  // final String? to;
  const VerifyMsgType(); //this.typeName); //this.to);
}

class VerifyMsgViewModel {
  final String phone;
  final String? pass;
  final VerifyMsgType type;
  const VerifyMsgViewModel({
    required this.phone,
    this.pass,
    this.type = VerifyMsgType.resetPass,
  });
}

class PckgInfModel {
  final PackageType type;
  final DateTime startDate;
  // final int frame;

  const PckgInfModel({
    required this.type,
    required this.startDate,
    // required this.frame,
  });
  // factory PckgInfModel.fromJson(Map<String, dynamic> json) {
  //   return PckgInfModel(
  //     type: _packageTypeFromId(json['package_id'] as String),
  //     startDate: DateFormat('yyyy-MM-dd').parse(json['start_date'] as String),
  //     frame: json['frame'] as int,
  //   );
  // }
  // static PackageType _packageTypeFromId(String packageId) {
  //   return PackageType.values.firstWhere(
  //     (type) => type.id == packageId,
  //     orElse: () => PackageType.fund, // Default to fund if not found
  //   );
  // }

  Map<String, dynamic> toEJson() {
    return {
      'type': type.name,
      'package_id': type.id, // Add this line
      'start_date': DateFormat('yyyy-MM-dd').format(startDate),
      'frame': type.frame,
      'start_date_str': startDateStr,
      'end_date': DateFormat('yyyy-MM-dd').format(endDate),
      'end_date_str': endDateStr,
      'remaining_days': remainingDays,
    };
  }

  /// Formatted start date
  String get startDateStr => DateFormat(kDefDateFormat).format(startDate);

  /// Computed end date
  DateTime get endDate =>
      startDate.add(Duration(days: WidH.strToint(type.frame)));

  /// Formatted end date
  String get endDateStr => DateFormat(kDefDateFormat).format(endDate);

  /// Remaining days from today to endDate
  String get remainingDays {
    final now = DateTime.now();
    final remaining = endDate.difference(now).inDays;
    return remaining > 0 ? remaining.toString() : '0';
  }
}

// class SetPackageInfModel {
//   final PackageType type;
//   final DateTime begins, ends;
//   final String daysLeft;
//   const SetPackageInfModel({
//     this.type = PackageType.fund,
//     required this.begins,
//     required this.ends,
//     required this.daysLeft,
//   });
// }

class PckgModel {
  final String price, frame;
  final double width;

  const PckgModel(this.price, this.frame, this.width);
}

class DpModel {
  final DateTime? firstDate, lastDate, initialDate;

  const DpModel({this.firstDate, this.lastDate, this.initialDate});
}

class TFModel {
  final List<String> titles;
  final List<TextEditingController> controllers;
  final List<FocusNode> fNodes;
  final int codeLength;
  final double widthF;
  const TFModel({
    required this.widthF,
    this.codeLength = 4,
    required this.controllers,
    this.titles = kTFModelTitles,
    required this.fNodes,
  });
}

class SectCardModel {
  final String name, img, routePath;
  final String? pTitle;
  const SectCardModel({
    this.pTitle,
    required this.name,
    required this.img,
    required this.routePath,
  });
}

class DetShowModel {
  final NCardModel cardModel;
  final bool isMine, isPended;
  const DetShowModel({
    this.isPended = false,
    required this.cardModel,
    this.isMine = false,
  });
}

class OptionsListModel {
  final String title;
  final List<String> options;
  final String? defOpt;

  const OptionsListModel({
    this.defOpt,
    required this.title,
    required this.options,
  });
}

class LblModel {
  final Decoration deco;
  final LblRow lblRow;

  const LblModel(this.deco, this.lblRow);
}

class SvgModel {
  final String img;
  final double? height, width;

  const SvgModel(this.img, this.height, this.width);
}

class NCardModel {
  final PckgInfModel? package;
  final List<String> img;
  final DateTime? date;
  final UserModel advOwner;
  final String title;
  // final String seller;
  final String location;
  final String price;
  final String section;
  final String? area;
  final String? mapImg;
  final String? flrCount;
  final String? romCount;
  final String? halCount;
  final String? bthCount;
  final String? kchCount;
  final String likes;
  final bool? isMine;
  final bool? status; // true for active, false refused, null pending
  final bool isLiked; // true for liked, false unliked
  final bool isfaved; // true for faved, false unfaved
  final bool isPremium; // true for premium, false for free

  const NCardModel(
    this.likes, {
    this.package,
    // this.seller = 'سامية علي الرازي',
    this.isMine,
    this.advOwner = kUserModel,
    this.date,
    this.area = '200',
    this.mapImg = AssetsData.mapImg,
    this.flrCount = '3',
    this.romCount = '12',
    this.halCount = '2',
    this.bthCount = '12',
    this.kchCount = '10',
    required this.section,
    this.status,
    required this.isLiked,
    required this.isfaved,
    required this.isPremium,
    required this.img,
    required this.title,
    required this.price,
    required this.location,
  });
}

class SelfUserModel {
  const SelfUserModel({
    required this.user,
    required this.birthDate,
    required this.userStatus,
    required this.likedAdvs,
    required this.favedAdvs,
    required this.hisOwnAdvs,
    required this.reportedAdvs,
  });
  final UserModel user;
  final String birthDate; //dont think that it will be needed, after registering
  final String userStatus;
  //userStatus; //true for active/allowed, false blocked, null suspended
  final List<NCardModel> likedAdvs;
  final List<NCardModel> favedAdvs;
  final List<NCardModel> hisOwnAdvs;
  //hisOwnAdvs; //should be ordered by (latest first (pending -> refused -> prem -> normal))
  final List<NCardModel> reportedAdvs;
}

class UserModel {
  const UserModel({
    this.userId,
    this.img, //= AssetsData.rUserAvatar,
    this.fName = 'سامية علي الرازي',
    // required this.mName,
    // required this.lName,
    this.phoneNum,
    this.whatsNum,
    //this.email,
    // this.city,
  });
  final String? userId; //, city;
  final String? img;
  final String fName; //, mName, lName;
  final String? phoneNum;
  final String? whatsNum; //, email; //optional
}

// final Map<int, List<CardModel>> cardMap = {
//   0: myAds,
//   1: likedAds,
//   2: favorites,
// };
//   GridView.builder(
//     key: ValueKey<int>(selectedIndex),
//     shrinkWrap: true,
//     physics: const NeverScrollableScrollPhysics(),
//     padding: const EdgeInsets.symmetric(horizontal: 1),
//     gridDelegate: kGridDelegate,
//     itemCount: dummySymbols[selectedIndex].length,
//     itemBuilder: (context, index) {
//       return HCardItem(
//         imgPath: AssetsData.propertyJpg,
//         // symbol: dummySymbols[selectedIndex][index],
//       );
//     },
//   ),

// 🔄 Animated GridView Switcher
// AnimatedSwitcher(
//   duration: const Duration(milliseconds: 300),
//   transitionBuilder: (child, animation) {
//     return FadeTransition(
//       opacity: animation,
//       child: SlideTransition(
//         position: Tween<Offset>(
//           begin: const Offset(0.1, 0),
//           end: Offset.zero,
//         ).animate(animation),
//         child: child,
//       ),
//     );
//   },
//   child: //gridview.builder ),

// class HMCardItem extends StatelessWidget {
//   const HMCardItem({super.key, required this.imgPath});
//   final String imgPath;
//   @override
//   Widget build(BuildContext context) {
//     return HMCardForm(
//       cardModel: CardModel(
//         title: 'بيت ثلاثة دور',
//         location: 'صنعاء - شارع المقالح',
//         propertyType: 'بيت',
//         price: '100000 ريال يمني',
//         img: AssetsData.propertyJpg,
//         likes: null,
//         date: null,
//       ),
//     );
//     // Container(
//     //   // padding: Funcs.hItemPadding(),
//     //   width: Funcs.respWidth(fract: 0.46, context: context),
//     //   decoration: Funcs.cardDecoration(null, 12),
//     //   child: CardForm(
//     //     cardModel: CardModel(
//     //       title: 'بيت ثلاثة دور',
//     //       location: 'صنعاء - شارع المقالح',
//     //       propertyType: 'بيت',
//     //       price: '100000 ريال يمني',
//     //       img: AssetsData.propertyJpg,
//     //       likes: null,
//     //       date: null,
//     //     ),
//     //   ),
//     // );
//   }
// }

// class HMCardForm extends StatelessWidget {
//   const HMCardForm({super.key, required this.cardModel});
//   final CardModel cardModel;
//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 193.3407 / 289,
//       child: HMCardBox(cardModel: cardModel),
//       // Column(
//       //   crossAxisAlignment: CrossAxisAlignment.end,
//       //   children: [
//       //     CardPropertyImage(imgPath: cardModel.img),
//       //     SizedBox(height: 10),
//       //     CardDateTxt(date: cardModel.date ?? DateTime.now()),
//       //     SizedBox(height: 10),
//       //     CardTitleWid(text: cardModel.title),
//       //     SizedBox(height: 15),
//       //     DetailIcoLine(
//       //       text: cardModel.location,
//       //       icoPath: AssetsData.locationSvg,
//       //     ),
//       //     DetailIcoLine(
//       //       text: cardModel.propertyType,
//       //       icoPath: AssetsData.buildingSvg,
//       //     ),
//       //     DetailIcoLine(text: cardModel.price, icoPath: AssetsData.tagSvg),
//       //     Spacer(), //////
//       //     CardSeperatedBtns(cardModel: cardModel),
//       //   ],
//       // ),
//     );
//   }
// }

// class HMCardBox extends StatelessWidget {
//   const HMCardBox({super.key, required this.cardModel});
//   final CardModel cardModel;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding:
//           Funcs.hItemPadding(), //EdgeInsets.symmetric(horizontal: 6.0, vertical: 12),
//       decoration: Funcs.cardDecoration(null, 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           CardPropertyImage(imgPath: cardModel.img),
//           // SizedBox(height: 10),
//           Spacer(flex: 2),
//           CardDateTxt(date: cardModel.date ?? DateTime.now()),
//           // SizedBox(height: 10),
//           Spacer(flex: 2),
//           CardTitleWid(text: cardModel.title),
//           // SizedBox(height: 15),
//           Spacer(flex: 3),
//           DetailIcoLine(
//             text: cardModel.location,
//             icoPath: AssetsData.locationSvg,
//           ),
//           DetailIcoLine(
//             text: cardModel.propertyType,
//             icoPath: AssetsData.buildingSvg,
//           ),
//           DetailIcoLine(text: cardModel.price, icoPath: AssetsData.tagSvg),
//           Spacer(flex: 3), //or Expanded( child: Column(),),
//           CardSeperatedBtns(cardModel: cardModel),
//         ],
//       ),
//     );
//   }
// }

// class HTCard extends StatelessWidget {
//   const HTCard({
//     super.key,
//     required this.name,
//     required this.img,
//     this.onTap,
//     this.advCount = '150',
//   });
//   final String name, img, advCount;
//   final void Function()? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return HTCardForm(
//       imgPath: img,
//       sectionName: name,
//       onTap: onTap,
//       advCount: advCount,
//     );
//   }
// }

// class HTCardForm extends StatelessWidget {
//   const HTCardForm({
//     super.key,
//     required this.imgPath,
//     required this.sectionName,
//     required this.onTap,
//     required this.advCount,
//   });

//   final String imgPath;
//   final String sectionName;
//   final void Function()? onTap;
//   final String advCount;

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 192 / 244,
//       child: SectCardBox(
//         imgPath: imgPath,
//         sectionName: sectionName,
//         onTap: onTap,
//         advCount: advCount,
//       ),
//     );
//   }
// }

// class HTCardBox extends StatelessWidget {
//   const HTCardBox({
//     super.key,
//     required this.imgPath,
//     required this.sectionName,
//     required this.onTap,
//     required this.advCount,
//   });

//   final String imgPath;
//   final String sectionName;
//   final void Function()? onTap;
//   final String advCount;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12),
//       decoration: Funcs.cardDecoration(null, 12),
//       child: Column(
//         children: [
//           SectCardImg(svgPath: imgPath, label: sectionName),
//           Spacer(),
//           TailBtn(onTap: onTap, advCount: advCount),
//         ],
//       ),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//       context,
//       controller: _controller,
//       screens: const [HomePage(), ProfilePage(), SettingsPage()],
//       items: [
//         PersistentBottomNavBarItem(
//           icon: Icon(Icons.home),
//           title: "Home",
//           activeColorPrimary: Colors.blue,
//           inactiveColorPrimary: Colors.grey,
//         ),
//         PersistentBottomNavBarItem(
//           icon: Icon(Icons.person),
//           title: "Profile",
//           activeColorPrimary: Colors.blue,
//           inactiveColorPrimary: Colors.grey,
//         ),
//         PersistentBottomNavBarItem(
//           icon: Icon(Icons.settings),
//           title: "Settings",
//           activeColorPrimary: Colors.blue,
//           inactiveColorPrimary: Colors.grey,
//         ),
//       ],
//       navBarStyle: NavBarStyle.style6, // Try different styles!
//       backgroundColor: Colors.white,
//       confineToSafeArea: true,
//       handleAndroidBackButtonPress: true,
//       resizeToAvoidBottomInset: true,
//       stateManagement: true,
//       hideNavigationBarWhenKeyboardAppears: true,
//     );
//   }
// }

// 🏠 Tab Views (can include Scaffold if needed)

////////////////////////Custom Navigation bar from documentation
// PersistentTabController _controller = PersistentTabController(initialIndex: 0);

// class CustomNavBarWidget extends StatelessWidget {
//   final int selectedIndex;
//   final List<PersistentBottomNavBarItem>
//   items; // NOTE: You CAN declare your own model here instead of `PersistentBottomNavBarItem`.
//   final ValueChanged<int> onItemSelected;

//   const CustomNavBarWidget({
//     super.key,
//     this.selectedIndex = 0,
//     required this.items,
//     required this.onItemSelected,
//   });

//   Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected) {
//     return Container(
//       alignment: Alignment.center,
//       height: 60.0,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Flexible(
//             child: IconTheme(
//               data: IconThemeData(
//                 size: 26.0,
//                 color:
//                     isSelected
//                         ? (item.activeColorSecondary ?? item.activeColorPrimary)
//                         : item.inactiveColorPrimary ?? item.activeColorPrimary,
//               ),
//               child: item.icon,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 5.0),
//             child: Material(
//               type: MaterialType.transparency,
//               child: FittedBox(
//                 child: Text(
//                   item.title!,
//                   style: TextStyle(
//                     color:
//                         isSelected
//                             ? (item.activeColorSecondary ??
//                                 item.activeColorPrimary)
//                             : item.inactiveColorPrimary,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 12.0,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Container(
//         width: double.infinity,
//         height: 60.0,
//         child: Row(
//           mainAxisAlignment: navBarEssentials.navBarItemsAlignment,
//           children:
//               items.map((item) {
//                 int index = items.indexOf(item);
//                 return Flexible(
//                   child: GestureDetector(
//                     onTap: () {
//                       onItemSelected(index);
//                     },
//                     child: _buildItem(item, selectedIndex == index),
//                   ),
//                 );
//               }).toList(),
//         ),
//       ),
//     );
//   }
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView.custom(
//       context,
//       controller: _controller,
//       screens: [
//         CustomNavBarScreen(
//           //You can declare route settings for custom navigation bar screen here
//           routeAndNavigatorSettings: RouteAndNavigatorSettings(
//             initialRoute: "/mainBody",
//             routes: {
//               "/first": (final context) => const MainScreen2(),
//               "/second": (final context) => const MainScreen3(),
//             },
//           ),
//           screen: MainScreen(
//             menuScreenContext: widget.menuScreenContext,
//             scrollController: _scrollControllers.first,
//           ),
//         ),
//         CustomNavBarScreen(
//           screen: MainScreen(
//             menuScreenContext: widget.menuScreenContext,
//             scrollController: _scrollControllers[1],
//           ),
//         ),
//         CustomNavBarScreen(
//           screen: MainScreen(
//             menuScreenContext: widget.menuScreenContext,
//             scrollController: _scrollControllers[2],
//           ),
//         ),
//         CustomNavBarScreen(
//           screen: MainScreen(
//             menuScreenContext: widget.menuScreenContext,
//             scrollController: _scrollControllers[3],
//           ),
//         ),
//         CustomNavBarScreen(
//           screen: MainScreen(
//             menuScreenContext: widget.menuScreenContext,
//             scrollController: _scrollControllers.last,
//           ),
//         ),
//       ],
//       itemCount: 5,
//       isVisible: true,
//       hideOnScrollSettings: HideOnScrollSettings(
//         hideNavBarOnScroll: true,
//         scrollControllers: _scrollControllers,
//       ),
//       backgroundColor: Colors.grey.shade900,
//       customWidget: CustomNavBarWidget(
//         items: _navBarsItems(),
//         onItemSelected: (final index) {
//           //Scroll to top for custom widget. For non custom widget, declare property `scrollController` in `PersistentBottomNavBarItem`.
//           if (index == _controller.index) {
//             _scrollControllers[index].animateTo(
//               0,
//               duration: const Duration(milliseconds: 200),
//               curve: Curves.ease,
//             );
//           }
//           setState(() {
//             _controller.index = index; // THIS IS CRITICAL!! Don't miss it!
//           });
//         },
//         selectedIndex: _controller.index,
//       ),
//     );
//   }
// }

////////////////////////Default Navigation bar from documentation
// class MyApp extends StatelessWidget {
//   const MyApp({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//         context,
//         controller: _controller,
//         screens: _buildScreens(),
//         items: _navBarsItems(),
//         handleAndroidBackButtonPress: true, // Default is true.
//         resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
//         stateManagement: true, // Default is true.
//         hideNavigationBarWhenKeyboardAppears: true,
//         popBehaviorOnSelectedNavBarItemPress: PopActionScreensType.all,
//         padding: const EdgeInsets.only(top: 8),
//         backgroundColor: Colors.grey.shade900,
//         isVisible: true,
//         animationSettings: const NavBarAnimationSettings(
//             navBarItemAnimation: ItemAnimationSettings( // Navigation Bar's items animation properties.
//                 duration: Duration(milliseconds: 400),
//                 curve: Curves.ease,
//             ),
//             screenTransitionAnimation: ScreenTransitionAnimationSettings( // Screen transition animation on change of selected tab.
//                 animateTabTransition: true,
//                 duration: Duration(milliseconds: 200),
//                 screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
//             ),
//         ),
//         confineToSafeArea: true,
//         navBarHeight: kBottomNavigationBarHeight,
//         navBarStyle: _navBarStyle, // Choose the nav bar style with this property
//       );
//   }
// }
