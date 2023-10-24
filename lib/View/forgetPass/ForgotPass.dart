import 'package:flutter/material.dart';
import 'package:gourmetbook/View/forgetPass/component/forgotPassFrom.dart';
import 'package:gourmetbook/helpers/const.dart';
import 'package:gourmetbook/View/login/component/login_form.dart';

class ForgotPass extends StatelessWidget {
  const ForgotPass({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Passworld Lost ?",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: defaultPadding * 2,
              ),
              const Text(
                "Please enter your email",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w100),
              ),
              const SizedBox(height: defaultPadding),
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: const PassLostForm()),
              // LoginAndSignupBtn(),
            ],
          ),
        ),
      ),
    );
  }
}
