import 'package:cloud_firestore/cloud_firestore.dart';

enum AppState { IDLE, LOADING, ERROR }

enum AdvertFilterType {
  NONE,
  DESIGN,
  OMG,
  SURFING,
  ARCTIC,
  TROPICAL,
  WINDMILLS
}

class Advert {
  String id;
  final String country;
  final String city;
  final List<String> advertPhotos;
  final double reservationprice;
  final String availableDate;
  final GeoPoint location;
  final Rating? rating;
  final int filterTypeId;
  final String publisher;
  final String publisherUid;
  List<MenuItem>? menuItems;

  Advert({
    required this.id,
    required this.publisher,
    required this.publisherUid,
    required this.country,
    required this.city,
    required this.advertPhotos,
    required this.reservationprice,
    required this.availableDate,
    required this.location,
    this.rating,
    this.menuItems,
    required this.filterTypeId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'country': country,
        'city': city,
        //  'province': province,
        'advert_photos': advertPhotos,
        'reservationprice': reservationprice,
        'available_date': availableDate,
        'location': location,
        'rating': rating != null ? rating!.toJson() : null,
        'filter_type_id': filterTypeId,
        'publisher': publisher,
        'publisherUid': publisherUid,
        'menuItems':
            menuItems == null ? [] : menuItems!.map((e) => e.toJson()).toList(),
      };

  factory Advert.fromJson(Map<String, dynamic> json) {
    List<dynamic>? menuItemsJson = json['menuItems'];
    List<MenuItem>? menuItems = [];
    if (menuItemsJson != null) {
      menuItems =
          menuItemsJson.map((itemJson) => MenuItem.fromJson(itemJson)).toList();
    }

    return Advert(
      id: json['id'],
      country: json['country'],
      city: json['city'],
      //  province: json['province'],
      advertPhotos: List<String>.from(json['advert_photos'].map((x) => x)),
      reservationprice: double.parse(json['reservationprice'].toString()),
      availableDate: json['available_date'],
      location: json['location'],
      rating: Rating.fromJson(json['rating']),
      filterTypeId: json['filter_type_id'],
      publisher: json['publisher'],
      publisherUid: json['publisherUid'],
      menuItems: menuItems,
    );
  }
}

class Location {
  final double latitude;
  final double longitude;

  Location(this.latitude, this.longitude);

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  static Location fromJson(Map<String, dynamic> json) => Location(
        json['latitude'],
        json['longitude'],
      );
}

class MenuItem {
  String? itemImg;
  String? itemName;
  double? itemPrice;
  String? itemAmount;

  MenuItem(this.itemImg, this.itemName, this.itemPrice, this.itemAmount);

  Map<String, dynamic> toJson() => {
        'itemImg': itemImg,
        'itemName': itemName,
        'itemPrice': itemPrice,
        'itemAmount': itemAmount,
      };

  static MenuItem fromJson(Map<String, dynamic> json) => MenuItem(
        json['itemImg'],
        json['itemName'],
        json['itemPrice'],
        json['itemAmount'],
      );
}

class Rating {
  final double rate;
  final int review;

  Rating(this.rate, this.review);

  Map<String, dynamic> toJson() => {
        'rate': rate,
        'review': review,
      };
  static Rating? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    } else {
      return Rating(
        json['rate'],
        json['review'],
      );
    }
  }
}
