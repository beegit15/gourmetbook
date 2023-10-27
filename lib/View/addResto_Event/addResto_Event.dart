import 'package:flutter/material.dart';
import 'package:gourmetbook/View/addResto_Event/component/add_form.dart';
import 'package:gourmetbook/helpers/const.dart';
import 'package:gourmetbook/View/login/component/login_form.dart';

class AddResto_Event extends StatelessWidget {
  final ScrollController controller;
  const AddResto_Event({Key? key, required this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ListView(
        controller: controller,
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: defaultPadding,
          ),
          Align(
            alignment: Alignment.center,
            child: const Text(
              "Add new Event/Restaurant",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: defaultPadding * 2,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: AddForm(controller: controller)),
          ),
          // LoginAndSignupBtn(),
        ],
      ),
    );
  }
}
