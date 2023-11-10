import 'package:flutter/material.dart';

import 'package:gourmetbook/View/details/components/add.dart';
import 'package:gourmetbook/helpers/const.dart';

class MenuItemWidget extends StatelessWidget {
  final String? itemName;
  final String? itemAmount;
  final String? itemImg;
  final bool selected;

  MenuItemWidget({
    Key? key,
    required this.itemName,
    required this.itemAmount,
    required this.itemImg,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height, width;

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                          itemImg!,
                                        ),
                                      ),
                                    )),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    if (itemName != null)
                                      Text(
                                        itemName!,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "\$",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        if (itemAmount != null)
                                          Text(
                                            itemAmount!,
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0),
                          ),
                        ),
                        child: selected
                            ? Icon(
                                Icons.check,
                                color: ColorName.white,
                                size: 20,
                              )
                            : Icon(
                                Icons.add,
                                color: ColorName.white,
                                size: 20,
                              ),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ],
    );
  }
}
