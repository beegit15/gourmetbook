import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gourmetbook/Models/UserModel.dart';
import 'package:gourmetbook/Models/advert.dart';
import 'package:gourmetbook/Providers/authProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:uuid/uuid.dart';

class addRestoEventProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final List<String> images = [];
  final List<String> menuImages = [];
  final List<MenuItem> menuItems = [];
  MenuItem item = MenuItem(null, null, null, null);
  String avaibelity = "availability";
  String selectedValuFromPopUpMenu = "please select your post type";
  getItemSelectedValue() {
    if (selectedValuFromPopUpMenu == UserType.organizer.name) {
      return 1;
    } else if (selectedValuFromPopUpMenu == UserType.restoOwner.name) {
      return 2;
    } else {
      return 0;
    }
  }

  late Future<TimeOfDay?> selectedTime;
  onMenuItemSelected(int value) {
    if (value == UserType.organizer.index) {
      selectedValuFromPopUpMenu = UserType.organizer.name;
    } else if (value == UserType.restoOwner.index) {
      selectedValuFromPopUpMenu = UserType.restoOwner.name;
    } else {
      selectedValuFromPopUpMenu = "please select your account type";
    }
    notifyListeners();
  }

  Future uploadAdvert(
    String name,
    String country,
    String city,
    String price,
    BuildContext context,
    String publisherName,
    String publisherUid,
  ) async {
    try {
      notifyListeners();
      EasyLoading.show(
          status: 'Publishing...', maskType: EasyLoadingMaskType.black);

      var uuid = Uuid();
      GeoPoint location = await determinePosition();

      if (images.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No image selected'),
          ),
        );
      } else {
        final List<String> _images = [];
        for (String path in images) {
          Reference ref = FirebaseStorage.instance
              .ref()
              .child('adverts')
              .child(path.split('/').last);
          UploadTask uploadTask = ref.putFile(File(path));
          var imageUrl = await (await uploadTask).ref.getDownloadURL();
          _images.add(imageUrl);
        }
        List<MenuItem> _menuItems = menuItems;
        for (MenuItem item in _menuItems) {
          Reference ref = FirebaseStorage.instance
              .ref()
              .child('menus')
              .child(item.itemImg!.split('/').last);
          UploadTask uploadTask = ref.putFile(File(item.itemImg!));
          var imageUrl = await (await uploadTask).ref.getDownloadURL();
          item.itemImg = imageUrl;
        }
        var advert = Advert(
            id: uuid.v1(),
            name: name,
            country: country,
            city: city,
            advertPhotos: _images,
            reservationprice: num.tryParse(price)!.toDouble()!,
            availableDate: avaibelity,
            location: location,
            publisher: publisherName,
            publisherUid: publisherUid,
            menuItems: _menuItems,
            // rating: rating,
            filterTypeId: 1);

        await _fireStore
            .collection("Adverts")
            .doc(advert.id)
            .set(advert.toJson())
            .then((value) {
          EasyLoading.dismiss();
        });
      }
      nameController.clear();
      countryController.clear();
      cityController.clear();
      priceController.clear();
      images.clear();
      menuImages.clear();
      menuItems.clear();
      item = MenuItem(null, null, null, null);
      avaibelity = "availability";
      selectedValuFromPopUpMenu = "please select your post type";
      notifyListeners();
      EasyLoading.dismiss();
    } catch (e) {
      print("Error on the new user registration = " + e.toString());

      notifyListeners();
      return null;
    }
  }

  determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position currentLocation = await Geolocator.getCurrentPosition();

    return GeoPoint(currentLocation.latitude, currentLocation.longitude);
  }

  selectTimeRange(BuildContext context) async {
    TimeRange result = await showTimeRangePicker(
      context: context,
    );
    avaibelity = result.startTime.hour.toString() +
        ":" +
        result.startTime.minute.toString() +
        " to " +
        result.endTime.hour.toString() +
        ":" +
        result.endTime.minute.toString();
    notifyListeners();
    print(result.toString());
  }

  Future pickImage(bool isMenu) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      isMenu ? menuImages.add(image.path) : images.add(image.path);
      notifyListeners();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImage2(bool isMenu) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return null;
      item.itemImg = image.path;
      notifyListeners();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  bool addMenuitem(String itemtitle, String itemprice) {
    print("-----------------------");
    print(itemtitle);
    print(itemprice);
    if (item.itemImg == null) {
      EasyLoading.showError("Please select an image for your menu item!");
      return false;
    } else if (itemtitle.isEmpty) {
      EasyLoading.showError("Please enter a name for your menu item!");
      return false;
    } else if (itemprice.isEmpty) {
      EasyLoading.showError("Please enter your menu item price!");
      return false;
    } else {
      item.itemPrice = double.parse(itemprice);
      item.itemName = itemtitle;

      menuItems.add(item);
      notifyListeners();
      item = MenuItem(null, null, null, null);
      return true;
    }
  }
}
