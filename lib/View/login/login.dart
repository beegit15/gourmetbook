import 'package:flutter/material.dart';
import 'package:gourmetbook/helpers/const.dart';
import 'package:gourmetbook/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                "Sign In",
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
                  child: const LoginForm()),
              // LoginAndSignupBtn(),
            ],
          ),
        ),
      ),
    );
  }
}
