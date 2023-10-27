import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gourmetbook/Models/UserModel.dart';
import 'package:gourmetbook/Models/advert.dart';
import 'package:gourmetbook/Models/failure.dart';
import 'package:gourmetbook/Models/reservation.dart';
import 'package:gourmetbook/Providers/authProvider.dart';
import 'package:gourmetbook/View/addResto_Event/component/addMenu.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ReservationProvider with ChangeNotifier {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  DateTime? date;
  List<MenuItem> menuItems = [];
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  DateTime? day;
  List<Reservation> reservations = [];
  bool loading = false;
  selectMenuItem(MenuItem x) {
    menuItems.add(x);
    notifyListeners();
  }

  unselectMenuItem(MenuItem x) {
    menuItems.remove(x);
    notifyListeners();
  }

  bool isMenuSelected(MenuItem x) {
    return menuItems.contains(x);
  }

  setTime(TimeOfDay start, TimeOfDay end) {
    startTime = start;
    endTime = end;
    notifyListeners();
  }

  setDay(DateTime x) {
    day = x;
    notifyListeners();
  }

  submitReservation(String advertid, String useruid, String ownerId) async {
    EasyLoading.show(
        status: 'Sending your reservation...',
        maskType: EasyLoadingMaskType.black);
    var uuid = Uuid();

    Reservation reservation = Reservation(
        id: uuid.v1(),
        ownerId: ownerId,
        advertId: advertid,
        userId: useruid,
        reservationEndTime: endTime.toString(),
        reservationStartTime: startTime.toString(),
        reservationDay: day.toString(),
        confirmed: false,
        menuItems: menuItems);

    await _fireStore
        .collection("Reservations")
        .doc(reservation.id)
        .set(reservation.toJson())
        .then((value) {
      date = null;
      menuItems = [];
      startTime = null;
      endTime = null;
      day = null;
      notifyListeners();
      EasyLoading.dismiss();
    });
  }

  getMyReservation(BuildContext context) async {
    loading = true;
    notifyListeners();
    final _auth = Provider.of<Auth>(context, listen: false);
    var uuid = Uuid();

    if (_auth.userModel != null) {
      if (_auth.userModel!.userType == UserType.User) {
        try {
          var response = FirebaseFirestore.instance
              .collection('Reservations')
              .where("userId", isEqualTo: _auth.userModel!.uid)
              .get()
              .then((snapshot) {
            reservations = snapshot.docs
                .map((e) => Reservation.fromJson(e.data()))
                .toList();
            loading = false;

            notifyListeners();
          });
        } on SocketException {
          throw Failure('SocketException :( Check your internet connection');
        } on HttpException {
          throw Failure(' HttpException :(');
        } on FormatException {
          throw Failure('Format Exception :(');
        } catch (e) {
          throw Failure('Unexpected error :(');
        }
      } else {
        try {
          var response = FirebaseFirestore.instance
              .collection('Reservations')
              .where("ownerId", isEqualTo: _auth.userModel!.uid)
              .get()
              .then((snapshot) {
            reservations = snapshot.docs
                .map((e) => Reservation.fromJson(e.data()))
                .toList();
            loading = false;

            notifyListeners();
          });
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
    }
  }

  cancelReservation(Reservation x) {
    try {
      var response = FirebaseFirestore.instance
          .collection('Reservations')
          .doc(x.id)
          .delete()
          .then((snapshot) {
        reservations.remove(x);

        notifyListeners();
      });
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

  confirmeReservation(Reservation x) {
    try {
      x.confirmed = true;
      var response = FirebaseFirestore.instance
          .collection('Reservations')
          .doc(x.id)
          .update({"confirmed": true}).then((snapshot) {
        notifyListeners();
      });
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
}
