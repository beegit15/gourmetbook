import 'package:gourmetbook/Models/advert.dart';
import 'package:time_range/time_range.dart';

class Reservation {
  String id;
  String advertId;
  String userId;
  String ownerId;

  String reservationStartTime;
  String reservationDay;
  String reservationEndTime;

  bool confirmed;

  List<MenuItem>? menuItems;

  Reservation({
    required this.id,
    required this.advertId,
    required this.userId,
    required this.ownerId,
    this.menuItems,
    required this.reservationEndTime,
    required this.reservationStartTime,
    required this.reservationDay,
    required this.confirmed,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'advertId': advertId,
        'userId': userId,
        'reservationEndTime': reservationEndTime,
        'reservationStartTime': reservationStartTime,
        'reservationDay': reservationDay,
        'confirmed': confirmed,
        'ownerId': ownerId,
        'menuItems':
            menuItems == null ? [] : menuItems!.map((e) => e.toJson()).toList(),
      };

  factory Reservation.fromJson(Map<String, dynamic> json) {
    List<dynamic>? menuItemsJson = json['menuItems'];
    List<MenuItem>? menuItems = [];
    if (menuItemsJson != null) {
      menuItems =
          menuItemsJson.map((itemJson) => MenuItem.fromJson(itemJson)).toList();
    }

    return Reservation(
      id: json['id'],
      ownerId: json['ownerId'],
      advertId: json['advertId'],
      reservationEndTime: json['reservationEndTime'],
      reservationStartTime: json['reservationStartTime'],
      reservationDay: json['reservationDay'],
      confirmed: json['confirmed'],
      userId: json['userId'],
      menuItems: menuItems,
    );
  }
}
