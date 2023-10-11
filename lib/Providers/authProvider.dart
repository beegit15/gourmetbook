import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gourmetbook/Models/UserModel.dart';
import 'package:gourmetbook/routes/goRouter.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Registering
}
/*
The UI will depends on the Status to decide which screen/action to be done.

- Uninitialized - Checking user is logged or not, the Splash Screen will be shown
- Authenticated - User is authenticated successfully, Home Page will be shown
- Authenticating - Sign In button just been pressed, progress bar will be shown
- Unauthenticated - User is not authenticated, login page will be shown
- Registering - User just pressed registering, progress bar will be shown

Take note, this is just an idea. You can remove or further add more different
status for your UI or widgets to listen.
 */

class Auth with ChangeNotifier {
  bool _showPassworld = false;
  bool get showPassworld => _showPassworld;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  bool _loading = false;
  bool get loiding => _loading;
  String selectedValuFromPopUpMenu = "please select your account type";
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  late FirebaseAuth _auth;
  late FirebaseFirestore _fireStore;

  //Default status
  Status _status = Status.Uninitialized;
  UserModel? _userModel;
  Status get status => _status;
  UserModel? get userModel => _userModel;
  Stream<UserModel?> get user =>
      _auth.authStateChanges().map(_userFromFirebase);

  onMenuItemSelected(int value) {
    print(value);
    print("heloooooooooooooooooooooooooo");
    if (value == UserType.User.index + 1) {
      selectedValuFromPopUpMenu = UserType.User.name;
    } else if (value == UserType.organizer.index + 1) {
      selectedValuFromPopUpMenu = UserType.organizer.name;
    } else if (value == UserType.restoOwner.index + 1) {
      selectedValuFromPopUpMenu = UserType.restoOwner.name;
    } else {
      selectedValuFromPopUpMenu = "please select your account type";
    }
    notifyListeners();
  }

  getItemSelectedValue() {
    if (selectedValuFromPopUpMenu == UserType.User.name) {
      return 1;
    } else if (selectedValuFromPopUpMenu == UserType.organizer.name) {
      return 2;
    } else if (selectedValuFromPopUpMenu == UserType.restoOwner.name) {
      return 3;
    } else {
      return 0;
    }
  }

  Auth() {
    //initialise object
    _auth = FirebaseAuth.instance;
    _fireStore = FirebaseFirestore.instance;
    //listener for authentication changes such as user sign in and sign out
    _auth.authStateChanges().listen(onAuthStateChanged);
  }

  Future<void> onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _userFromFirebase(firebaseUser);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  UserModel? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }

    return UserModel(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        phoneNumber: user.phoneNumber,
        photoUrl: user.photoURL);
  }

  Future<UserModel?> registerWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      _status = Status.Registering;
      notifyListeners();
      EasyLoading.show(status: 'Regisring...');

      print(email);
      print(password);
      print(username);
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        await _fireStore.collection("users").doc(result.user!.uid).set({
          "username": username,
          "email": result.user!.email,
          "accountType": selectedValuFromPopUpMenu
        }).then((value) {
          EasyLoading.dismiss();
        });
      }
      goRouter.go("/homepage");
      return _userFromFirebase(result.user);
    } catch (e) {
      print("Error on the new user registration = " + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return null;
    }
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      EasyLoading.show(status: 'Regisring...');
      final UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        await _fireStore.collection("users").doc(result.user!.uid).get().then(
          (DocumentSnapshot doc) {
            final data = doc.data() as Map<String, dynamic>;
            UserType? type = userTypeMap[data["accountType"]];

            _userModel = UserModel(
                uid: doc.id,
                displayName: data["username"],
                email: data["email"],
                userType: type!);
            // ...
          },
          onError: (e) => print("Error getting document: $e"),
        );

        EasyLoading.dismiss();
      }

      goRouter.go("/homepage");
      return true;
    } catch (e) {
      print("Error on the sign in = " + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  //Method to handle password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email).then((value) async {
      await EasyLoading.showSuccess('Email Sent!').then((value) {
        goRouter.go("/login");
      });
    });
  }

  //Method to handle user signing out
  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  toggleShowPassworld() {
    _showPassworld = !_showPassworld;
    print("hello");
    notifyListeners();
  }

  init() async {
    _loading = true;
    // notifyListeners();
    if (_auth.currentUser == null) {
      print("zeeeeeb5555");
      _isLoggedIn = false;
      notifyListeners();
      goRouter.go("/login");
    } else {
      await _fireStore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .get()
          .then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          UserType? type = userTypeMap[data["accountType"]];

          _userModel = UserModel(
              uid: doc.id,
              displayName: data["username"],
              email: data["email"],
              userType: type!);
          // ...
        },
        onError: (e) => print("Error getting document: $e"),
      );
      goRouter.go("/homepage");
    }
  }

  login() {
    EasyLoading.show(status: 'loading...');
    print("hello");
    Timer(Duration(seconds: 10), () {
      EasyLoading.dismiss();
    });
  }
}
