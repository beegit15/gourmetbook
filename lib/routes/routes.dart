import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gourmetbook/View/HomePage/HomePage.dart';
import 'package:gourmetbook/View/forgetPass/ForgotPass.dart';
import 'package:gourmetbook/View/login/login.dart';
import 'package:gourmetbook/View/signUp/signup_screen.dart';
import 'package:gourmetbook/View/splash/splash.dart';

// later home page can have more elemetns
enum Routes {
  home,
  login,
  SignUp,
  PassRecovery,
  etage,
  etiquetage,
  rapidRead,
  about,
  splash,
  findAsset,
  readers,
  application,
  led,
  bip,
  batterie,
  profiles,
  settings;

  static Map<Routes, String> get _routes => {
        Routes.splash: '/',
        Routes.home: '/homepage',
        Routes.PassRecovery: '/PassRecovery',
        Routes.etiquetage: '/etiquetage',
        Routes.settings: '/settings',
        Routes.etage: '/etage',
        Routes.rapidRead: '/rapidRead',
        Routes.about: '/about',
        Routes.readers: '/settings/readers',
        Routes.application: '/settings/Application',
        Routes.led: '/settings/led',
        Routes.bip: '/settings/bip',
        Routes.batterie: '/settings/batterie',
        Routes.findAsset: '/findAsset',
        Routes.profiles: '/settings/profiles',
        Routes.SignUp: '/signUp',
        Routes.login: '/login'
      };

  static Map<Routes, Widget Function(BuildContext context, GoRouterState state)>
      get _builders => {
            Routes.login: (context, state) => const LoginScreen(),
            Routes.SignUp: (context, state) => const SignUpScreen(),
            Routes.splash: (context, state) => const Splash(),
            Routes.home: (context, state) => HomePage(),
            Routes.PassRecovery: (context, state) => ForgotPass(),
          };

  static String getRoute(Routes route) => _routes[route]!;

  static String getRouteFromPath(String path) {
    final route =
        _routes.entries.firstWhere((element) => element.value == path);
    return route.key.toString();
  }

  static String getRouteFromIndex(int index) {
    final route = _routes.entries.elementAt(index);
    return route.key.toString();
  }

  String get route => _routes[this]!;

  Widget Function(BuildContext context, GoRouterState state) get builder =>
      _builders[this]!;
}
