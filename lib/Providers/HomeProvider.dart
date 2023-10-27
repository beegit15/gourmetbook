import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gourmetbook/Models/advert.dart';
import 'package:gourmetbook/Models/failure.dart';
import 'package:gourmetbook/View/HomePage/HomePage.dart';
import 'package:gourmetbook/View/HomePage/exploreView/service/explore_service.dart';
import 'package:gourmetbook/routes/goRouter.dart';
import "package:latlong2/latlong.dart" as latLng;

class homeProvider with ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  homeProvider() {
    _state = AppState.IDLE;
    adverts = [];
    init();
  }
  Advert? selectedAdvert = null;
  selectAdvert(Advert x) {
    selectedAdvert = x;
    notifyListeners();
  }

  double mapButtonOpacity = 1.0;

  double bottomBarHeight = kBottomNavigationBarHeight;
  BuildContext? ctx;
  setctx(BuildContext context) {
    ctx = context;
  }

  void listen() {
    final size = draggableScrollController.isAttached
        ? draggableScrollController.size
        : 0.0;

    if (size < 0.121) {
      mapButtonOpacity = 0.0;

      bottomBarHeight = 0;
      notifyListeners();
    } else {
      mapButtonOpacity = draggableScrollController.size;
      bottomBarHeight = draggableScrollController.size *
          (kBottomNavigationBarHeight +
              MediaQueryData.fromView(View.of(ctx!)).padding.bottom);
      notifyListeners();
    }
  }

  void addL(BuildContext context) {
    draggableScrollController.addListener(listen);
  }

  void rmListner(BuildContext context) {
    if (draggableScrollController.isAttached) {
      draggableScrollController.removeListener(listen);
    }
  }

  double get size => draggableScrollController.isAttached
      ? draggableScrollController.size
      : 0.0;

  changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  AppState? _state = AppState.IDLE;
  AppState get state => _state!;

  set changeState(AppState state) {
    _state = state;
    notifyListeners();
  }

  Failure? _failure;
  Failure get failure => _failure!;
  set setFailure(Failure failure) {
    _failure = failure;
    notifyListeners();
  }

  List<Advert>? adverts = [];
  // Get adverts
  Future<void> getAdverts() async {
    try {
      changeState = AppState.LOADING;
      adverts = await ExploreService.instance.getAdverts();
      changeState = AppState.IDLE;
    } on Failure catch (e) {
      setFailure = e;
      changeState = AppState.ERROR;
      adverts = [];
    }
  }

  List<Advert> init() {
    try {
      List<Advert> listAdv = [];
      Stream<QuerySnapshot> x =
          FirebaseFirestore.instance.collection('Adverts').snapshots();
      x.listen((QuerySnapshot querySnapshot) {
        final firestoreList = querySnapshot.docs;
        adverts = firestoreList
            .map((e) => Advert.fromJson(e.data() as Map<String, dynamic>))
            .toList();
        notifyListeners();

        print(firestoreList.first.data());
      });
      return listAdv;
    } on SocketException {
      throw Failure('SocketException :( Check your internet connection');
    } on HttpException {
      throw Failure(' HttpException :(');
    } on FormatException {
      throw Failure('Format Exception :(');
    } catch (e) {
      throw Failure('Unexpected error :(');
    }
  }

  // Filter
  int? _selectedFilterIndex;
  get selectedFilterIndex => _selectedFilterIndex;
  set setSelectedFilterIndex(int? index) {
    _selectedFilterIndex = index;
    notifyListeners();
  }

  getMatkers() {
    List<Marker> markers = [];
    for (Advert i in adverts!) {
      markers.add(Marker(
          point: latLng.LatLng(i.location.latitude, i.location.longitude),
          child: InkWell(
              onTap: () {
                selectAdvert(i);
                goRouter.push("/details");
              },
              child: const Icon(Icons.location_on))));
    }
    return markers;
  }

  MapController mapController = MapController();

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
    latLng.LatLng center =
        latLng.LatLng(currentLocation.latitude, currentLocation.longitude);

    mapController.moveAndRotate(center, 10.0, 0.0);
  }
}
