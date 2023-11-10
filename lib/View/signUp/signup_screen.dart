import 'package:flutter/material.dart';
import 'package:gourmetbook/helpers/const.dart';
import 'package:gourmetbook/widgets/backgroung.dart';
import 'package:gourmetbook/widgets/sign_up_top_image.dart';
import 'package:gourmetbook/View/signUp/component/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Center(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: SignUpForm()),
                  // LoginAndSignupBtn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MobileSignupScreen extends StatelessWidget {
  const MobileSignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SignUpScreenTopImage(),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SignUpForm(),
            ),
            const Spacer(),
          ],
        ),
        // const SocalSignUp()
      ],
    );
  }
}
