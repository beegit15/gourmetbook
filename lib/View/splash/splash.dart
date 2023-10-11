import 'package:flutter/material.dart';
import 'package:gourmetbook/Providers/authProvider.dart';
import 'package:gourmetbook/helpers/const.dart';
import 'package:gourmetbook/widgets/widgetRingAnimator.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<Auth>(context, listen: true);
    authProvider.init();
    return Scaffold(
        backgroundColor: kPrimaryLightColor,
        body: Stack(
          children: <Widget>[
            Center(
                child: WidgetRingAnimator(
              size: 120,
              ringIcons: const [
                'assets/images/store.png',
                'assets/images/product.png',
                'assets/images/cart.png',
                'assets/images/rupee.png',
                'assets/images/delivery.png',
              ],
              ringIconsSize: 3,
              ringIconsColor: const Color.fromARGB(255, 22, 22, 22)!,
              ringAnimation: Curves.linear,
              ringColor: kPrimaryColor,
              reverse: false,
              ringAnimationInSeconds: 10,
              child: Container(
                child: Material(
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                      'assets/images/app_logo.png',
                      color: Colors.green,
                      height: 65,
                    ),
                    radius: 45.0,
                  ),
                ),
              ),
            )),
            Center(
              child: AvatarGlow(
                glowColor: Colors.lightGreen,
                endRadius: 200.0,
                duration: Duration(milliseconds: 2000),
                repeat: true,
                showTwoGlows: true,
                repeatPauseDuration: Duration(milliseconds: 100),
                child: Material(
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                      'assets/images/app_logo.png',
                      color: Colors.green,
                      height: 65,
                    ),
                    radius: 45.0,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
