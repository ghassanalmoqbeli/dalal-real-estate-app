import 'package:dallal_proj/core/constants/test_mock_models.dart';
import 'package:flutter/material.dart';

abstract class Shape {
  double area();
  Color? color();

  factory Shape.circle(double radius) = Circle;
}

class Circle implements Shape {
  final double radius;

  Circle(this.radius);
  @override
  double area() => 3.14 * radius * radius;

  @override
  Color? color() {
    return null;
  }
}

Shape getCircle(double radius) => Shape.circle(radius);

class MaMain {
  void zob() {
    Shape circ = Shape.circle(5); //getCircle(5);
    circ.area();
    PropDal house = PropDal.house(promv, IntRooms('1', '2', '3', '4'), '4');
    house.floors();
    // PropDal lala = PropDal.land(promv);
    // lala.
  }
}

enum PropTypeDal { house, apt, store, land }

enum PropCurrency {
  yer('YER'),
  sar('SAR'),
  usd('USD');

  const PropCurrency(this.val);
  final String val;
}

enum PropOfferTypeDal { rent, full, semi }

class IntRooms {
  final String? rooms, halls, baths, kits;

  IntRooms(this.rooms, this.halls, this.baths, this.kits);
}

class PropFunds {
  final List<String>? imgs;
  final String title, city, area, location, onMap, price; //, currency;
  final String? additionalInfo;
  final bool isNegot;
  final PropOfferTypeDal offerTypeDal;
  final PropTypeDal propTypeDal;
  final PropCurrency currency;

  const PropFunds({
    required this.currency,
    required this.imgs,
    required this.title,
    required this.city,
    required this.area,
    required this.location,
    required this.onMap,
    required this.price,
    required this.additionalInfo,
    required this.isNegot,
    required this.offerTypeDal,
    required this.propTypeDal,
  });
}

class PropAptDal extends PropFunds {
  final IntRooms intRooms;

  PropAptDal({
    required this.intRooms,
    required super.currency,
    required super.imgs,
    required super.title,
    required super.city,
    required super.area,
    required super.location,
    required super.onMap,
    required super.price,
    required super.additionalInfo,
    required super.isNegot,
    required super.offerTypeDal,
    required super.propTypeDal,
  });
}

class PropHouseDal extends PropAptDal {
  final String floors;
  PropHouseDal({
    required this.floors,
    required super.intRooms,
    required super.currency,
    required super.imgs,
    required super.title,
    required super.city,
    required super.area,
    required super.location,
    required super.onMap,
    required super.price,
    required super.additionalInfo,
    required super.isNegot,
    required super.offerTypeDal,
    required super.propTypeDal,
  });
}

abstract class PropDal {
  PropFunds propFunds();
  String? floors();
  IntRooms? intRooms();

  factory PropDal.land(PropFunds propFunds) = Land;
  factory PropDal.store(PropFunds propFunds) = Store;
  factory PropDal.appartment(PropFunds propFunds, IntRooms intRooms) =
      Appartment;
  factory PropDal.house(PropFunds propFunds, IntRooms intRooms, String floors) =
      House;
}

class Land implements PropDal {
  final PropFunds funds;

  Land(this.funds);

  @override
  String? floors() => null;

  @override
  IntRooms? intRooms() => null;

  @override
  PropFunds propFunds() => funds;
}

class Store implements PropDal {
  final PropFunds funds;

  Store(this.funds);

  @override
  String? floors() => null;

  @override
  IntRooms? intRooms() => null;

  @override
  PropFunds propFunds() => funds;
}

class Appartment implements PropDal {
  final PropFunds funds;
  final IntRooms rooms;
  Appartment(this.funds, this.rooms);

  @override
  String? floors() => null;

  @override
  IntRooms? intRooms() => rooms;

  @override
  PropFunds propFunds() => funds;
}

class House implements PropDal {
  final PropFunds funds;
  final IntRooms rooms;
  final String floorz;

  House(this.funds, this.rooms, this.floorz);

  @override
  String? floors() => floorz;

  @override
  IntRooms? intRooms() => rooms;

  @override
  PropFunds propFunds() => funds;
}

class PropOwner {
  final String? pfp;
  final String name;
  final String ownerId;
  final String phone;
  final String whatsApp;
  final String linkToContacts;
  final String linkToWhatsApp;
  PropOwner(
    this.pfp,
    this.name,
    this.ownerId,
    this.phone,
    this.whatsApp,
    this.linkToContacts,
    this.linkToWhatsApp,
  );
}
