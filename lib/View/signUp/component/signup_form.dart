import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gourmetbook/Providers/authProvider.dart';
import 'package:gourmetbook/View/login/login.dart';
import 'package:gourmetbook/View/signUp/component/popUpMenu.dart';
import 'package:gourmetbook/helpers/const.dart';
import 'package:gourmetbook/routes/goRouter.dart';
import 'package:gourmetbook/widgets/alreadyHaveAccount.dart';
import 'package:gourmetbook/widgets/buttton.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<Auth>(context, listen: true);

    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: authProvider.usernameController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your userName",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: defaultPadding),
            child: Container(
              height: kMinInteractiveDimension,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: kPrimaryLightColor,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                // borderSide: BorderSide.none,
              ),
              child: PopUpMen(
                initialValue: authProvider.getItemSelectedValue(),
                onMenuItemSelected: authProvider.onMenuItemSelected,
                selectedValue: authProvider.selectedValuFromPopUpMenu,
                menuList: const [
                  PopupMenuItem(
                    value: 1,
                    child: ListTile(
                      leading: Icon(
                        CupertinoIcons.person,
                      ),
                      title: Text("User"),
                    ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem(
                    value: 2,
                    child: ListTile(
                      leading: Icon(
                        Icons.event,
                      ),
                      title: Text("Events Organizer"),
                    ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem(
                    value: 3,
                    child: ListTile(
                      leading: Icon(Icons.restaurant),
                      title: Text("Restaurant Owner"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: defaultPadding),
            child: TextFormField(
              controller: authProvider.emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (email) {},
              decoration: const InputDecoration(
                hintText: "Your email",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              controller: authProvider.passController,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          Hero(
            tag: "signup_btn",
            child: MyElevatedButton(
              gradient: const LinearGradient(colors: [
                Color.fromARGB(255, 159, 75, 237),
                Color.fromARGB(255, 14, 119, 247),
              ]),
              borderRadius: BorderRadius.circular(20),
              onPressed: () {
                authProvider.registerWithEmailAndPassword(
                    authProvider.emailController.value.text,
                    authProvider.passController.value.text,
                    authProvider.usernameController.value.text);
              },
              child: Text(
                "Sign Up".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              goRouter.go("/login");
            },
          ),
        ],
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(String title) {
    return PopupMenuItem(
      child: Text(title),
    );
  }
}
