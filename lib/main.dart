import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gourmetbook/.env.dart';
import 'package:gourmetbook/Providers/HomeProvider.dart';
import 'package:gourmetbook/Providers/ReservationProvider.dart';
import 'package:gourmetbook/Providers/addRestoEventsprovider.dart';
import 'package:gourmetbook/Providers/authProvider.dart';
import 'package:gourmetbook/View/login/login.dart';
import 'package:gourmetbook/View/welcome/welcome.dart';
import 'package:gourmetbook/firebase_options.dart';
import 'package:gourmetbook/helpers/const.dart';
import 'package:gourmetbook/helpers/text.dart';
import 'package:gourmetbook/helpers/theme.dart';
import 'package:gourmetbook/routes/goRouter.dart';
import 'package:gourmetbook/routes/routes.dart';
import 'package:gourmetbook/View/login/component/login_form.dart';
import 'package:gourmetbook/widgets/login_signup_btn.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  await Stripe.instance.applySettings();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Auth()),
    ChangeNotifierProvider(create: (_) => homeProvider()),
    ChangeNotifierProvider(create: (_) => ReservationProvider()),
    ChangeNotifierProvider(create: (_) => addRestoEventProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
      builder: EasyLoading.init(builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaleFactor: getTheTextFactorFix(context)),
          child: child!,
        );
      }),
      title: 'Flutter Demo',
      theme: themeData.theme,
    );
  }
}
