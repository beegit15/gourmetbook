import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gourmetbook/helpers/const.dart';

class PopUpMen extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget? icon;
  final Function onMenuItemSelected;
  final String selectedValue;
  final int initialValue;
  PopUpMen(
      {Key? key,
      required this.menuList,
      required this.selectedValue,
      required this.onMenuItemSelected,
      required this.initialValue,
      this.icon})
      : super(key: key);
  final List<IconData> Sicon = [
    Icons.touch_app,
    Icons.person,
    Icons.event,
    Icons.restaurant
  ];
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        itemBuilder: ((context) => menuList),
        //icon: icon,
        onSelected: (value) {
          onMenuItemSelected.call(value as int);
        },
        initialValue: initialValue,
        child: Container(
          height: menuList[initialValue].height,
          child: ListTile(
            leading: Icon(
              Sicon[initialValue],
              color: kPrimaryColor,
            ),
            title: Text(selectedValue),
          ),
        )

        // child: Container(child: Text(selectedValue)),
        );
  }
}
