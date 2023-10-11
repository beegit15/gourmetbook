import 'package:flutter/material.dart';
import 'package:gourmetbook/Providers/authProvider.dart';
import 'package:gourmetbook/View/login/login.dart';
import 'package:gourmetbook/View/welcome/welcome.dart';
import 'package:gourmetbook/helpers/const.dart';
import 'package:gourmetbook/helpers/text.dart';
import 'package:gourmetbook/helpers/theme.dart';
import 'package:gourmetbook/routes/goRouter.dart';
import 'package:gourmetbook/routes/routes.dart';
import 'package:gourmetbook/widgets/login_form.dart';
import 'package:gourmetbook/widgets/login_signup_btn.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Auth()),
  ], child: const MyApp()));
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
