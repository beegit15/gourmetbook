import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gourmetbook/Providers/authProvider.dart';
import 'package:gourmetbook/View/signUp/signup_screen.dart';
import 'package:gourmetbook/helpers/const.dart';
import 'package:gourmetbook/routes/goRouter.dart';
import 'package:gourmetbook/widgets/alreadyHaveAccount.dart';
import 'package:gourmetbook/widgets/buttton.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<Auth>(context, listen: true);
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: authProvider.emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: authProvider.passController,
              textInputAction: TextInputAction.done,
              obscureText: authProvider.showPassworld,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: InkWell(
                      onTap: () {
                        //change the passworld
                        authProvider.toggleShowPassworld();
                      },
                      child: Icon(
                        authProvider.showPassworld
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: kPrimaryColor,
                      )),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  goRouter.push("/PassRecovery");
                },
                child: const Text(
                  "forget your passworld ?",
                  style: TextStyle(color: kPrimaryColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: MyElevatedButton(
              gradient: const LinearGradient(colors: [
                Color.fromARGB(255, 159, 75, 237),
                Color.fromARGB(255, 14, 119, 247),
              ]),
              borderRadius: BorderRadius.circular(20),
              onPressed: () {
                authProvider.signInWithEmailAndPassword(
                    authProvider.emailController.value.text,
                    authProvider.passController.value.text);
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              goRouter.push("/signUp");
            },
          ),
        ],
      ),
    );
  }
}
