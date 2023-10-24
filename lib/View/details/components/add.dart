import 'package:flutter/material.dart';
import 'package:gourmetbook/helpers/const.dart';

class AddButtonWidget extends StatelessWidget {
  AddButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      child: Icon(
        Icons.add,
        color: ColorName.white,
        size: 20,
      ),
    );
  }
}
