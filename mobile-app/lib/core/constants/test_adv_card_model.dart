// class AdvDetailsModal extends AdvCardEntity {
//   final List<String> imgs;
//   final String? mapLocationLink,
//       advFloorsCount,
//       advRoomsCount,
//       advKitchensCount,
//       advBathroomsCount,
//       advHallsCount;
//   final String detAdvId,
//       detDate,
//       detTitle,
//       location,
//       detPropType,
//       detPrice,
//       currency,
//       advCity,
//       advArea,
//       advAdditionalInfo,
//       detLikesCount;
//   final AdvOwner advOwner;
//   final Pkg? package;
//   final bool detIsPrem, isNegotiable;
//   final bool? detState;

//   AdvDetailsModal({
//     required this.imgs,
//     required this.detAdvId,
//     required this.detDate,
//     required this.detTitle,
//     required this.advOwner,
//     this.package,
//     required this.location,
//     required this.detPropType,
//     required this.detPrice,
//     required this.currency,
//     required this.detLikesCount,
//     required this.detIsPrem,
//     required this.isNegotiable,
//     this.mapLocationLink,
//     this.detState,
//     required this.advCity,
//     required this.advArea,
//     required this.advAdditionalInfo,
//     this.advFloorsCount,
//     this.advRoomsCount,
//     this.advKitchensCount,
//     this.advBathroomsCount,
//     this.advHallsCount,
//   }) : super(
//          advCardId: detAdvId,
//          img: imgs.isNotEmpty ? imgs[0] : '',
//          date: detDate,
//          title: detTitle,
//          adress: '$advCity - $location',
//          section: detPropType,
//          price: '$detPrice $currency',
//          likesCount: detLikesCount,
//          isPremium: detIsPrem,
//          state: detState,
//        );

//   factory AdvDetailsModal.fromJson(Map<String, dynamic> json) {
//     return AdvDetailsModal(
//       imgs: List<String>.from(json['imgs']),
//       detAdvId: json['detAdvId'],
//       detDate: json['detDate'],
//       detTitle: json['detTitle'],
//       advOwner: AdvOwner.fromJson(json['advOwner']),
//       package: json['package'] != null ? Pkg.fromJson(json['package']) : null,
//       location: json['location'],
//       detPropType: json['detPropType'],
//       detPrice: json['detPrice'],
//       currency: json['currency'],
//       detLikesCount: json['detLikesCount'],
//       detIsPrem: json['detIsPrem'],
//       isNegotiable: json['isNegotiable'],
//       mapLocationLink: json['mapLocationLink'],
//       detState: json['detState'],
//       advCity: json['advCity'],
//       advArea: json['advArea'],
//       advAdditionalInfo: json['advAdditionalInfo'],
//       advFloorsCount: json['advFloorsCount'],
//       advRoomsCount: json['advRoomsCount'],
//       advKitchensCount: json['advKitchensCount'],
//       advBathroomsCount: json['advBathroomsCount'],
//       advHallsCount: json['advHallsCount'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'imgs': imgs,
//       'detAdvId': detAdvId,
//       'detDate': detDate,
//       'detTitle': detTitle,
//       'advOwner': advOwner.toJson(),
//       'package': package?.toJson(),
//       'location': location,
//       'detPropType': detPropType,
//       'detPrice': detPrice,
//       'currency': currency,
//       'detLikesCount': detLikesCount,
//       'detIsPrem': detIsPrem,
//       'isNegotiable': isNegotiable,
//       'mapLocationLink': mapLocationLink,
//       'detState': detState,
//       'advCity': advCity,
//       'advArea': advArea,
//       'advAdditionalInfo': advAdditionalInfo,
//       'advFloorsCount': advFloorsCount,
//       'advRoomsCount': advRoomsCount,
//       'advKitchensCount': advKitchensCount,
//       'advBathroomsCount': advBathroomsCount,
//       'advHallsCount': advHallsCount,
//     };
//   }
// }


// class AdvOwner {
//   final String id, img, name, phone;
//   final String? whatsappNumber;

//   AdvOwner({
//     required this.id,
//     required this.img,
//     required this.name,
//     required this.phone,
//     this.whatsappNumber,
//   });

//   factory AdvOwner.fromJson(Map<String, dynamic> json) {
//     return AdvOwner(
//       id: json['id'],
//       img: json['img'],
//       name: json['name'],
//       phone: json['phone'],
//       whatsappNumber: json['whatsappNumber'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'img': img,
//       'name': name,
//       'phone': phone,
//       'whatsappNumber': whatsappNumber,
//     };
//   }
// }

// class Pkg {
//   final String type, 
//   startDate;

//   Pkg({required this.type, required this.startDate});

//   factory Pkg.fromJson(Map<String, dynamic> json) {
//     return Pkg(type: json['type'], startDate: json['startDate']);
//   }

//   Map<String, dynamic> toJson() {
//     return {'type': type, 'startDate': startDate};
//   }

//   PackageType get pkgType =>
//       (type == '0')
//           ? PackageType.fund
//           : (type == '1')
//           ? PackageType.special
//           : PackageType.golden;

//   PckgInfModel get pkgModel => PckgInfModel(
//     type: pkgType,
//     startDate: WidH.str2date(startDate),
//     frame: WidH.strToint(pkgType.frame),
//   );
// }

// class AdvDetailsModal extends AdvCardEntity {
//   final List<String> imgs;
//   final String? mapLocationLink,
//       advFloorsCount,
//       advRoomsCount,
//       advKitchensCount,
//       advBathroomsCount,
//       advHallsCount;
//   final String detAdvId,
//       detDate,
//       detTitle,
//       location,
//       detPropType,
//       detPrice,
//       currency,
//       advCity,
//       advArea,
//       advAdditionalInfo,
//       detLikesCount;
//   final AdvOwner advOwner;
//   final Pkg? package;
//   final bool detIsPrem, isNegotiable;
//   final bool? detState;
//   AdvDetailsModal({
//     required this.imgs,
//     required this.detAdvId,
//     required this.detDate,
//     required this.detTitle,
//     required this.advOwner,
//     this.package,
//     required this.location,
//     required this.detPropType,
//     required this.detPrice,
//     required this.currency,
//     required this.detLikesCount,
//     required this.detIsPrem,
//     required this.isNegotiable,
//     this.mapLocationLink,
//     this.detState,
//     required this.advCity,
//     required this.advArea,
//     required this.advAdditionalInfo,
//     this.advFloorsCount,
//     this.advRoomsCount,
//     this.advKitchensCount,
//     this.advBathroomsCount,
//     this.advHallsCount,
//   }) : super(
//          advCardId: detAdvId,
//          img: imgs[0],
//          date: detDate,
//          title: detTitle,
//          adress: '$advCity - $location',
//          propType: detPropType,
//          price: '$detPrice $currency',
//          likesCount: detLikesCount,
//          isPrem: detIsPrem,
//          state: detState,
//        );
// }

// class AdvOwner {
//   final String id, img, name, phone;
//   final String? whatsappNumber;
//   AdvOwner({
//     required this.id,
//     required this.img,
//     required this.name,
//     required this.phone,
//     this.whatsappNumber,
//   });
// }

// class Pkg {
//   final String type, //either '0' or '1' or '2'
//       startDate; //in 'yyyy/M/d' formatt
//   Pkg({required this.type, required this.startDate});

//   PackageType get pkgType =>
//       (type == '0')
//           ? PackageType.fund
//           : (type == '1')
//           ? PackageType.special
//           : PackageType.golden;

//   PckgInfModel get pkgModel => PckgInfModel(
//     type: pkgType,
//     startDate: WidH.str2date(startDate),
//     frame: WidH.strToint(pkgType.frame),
//   );
// }

/* 
cardId
cardImg
cardDate
cardTitle
cardLocation
cardPropType
cardPrice
cardLikesCount
cardIsLikedByMe
cardIsFavedByMe
cardIsPremium
*/

/* 
advId
advImgs
advTitle
advLocation
advLocationLink
advPropType
advPrice
advLikesCount

advOwner
advCity
advArea
advAdditionalInfo
cardIsPremium

advIsLikedByMe
advIsFavedByMe

advFloorsCount
advRoomsCount
advKitchensCount
advBathroomsCount
advHallsCount
*/
