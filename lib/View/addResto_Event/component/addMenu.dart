import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gourmetbook/Models/advert.dart';
import 'package:gourmetbook/Providers/addRestoEventsprovider.dart';
import 'package:gourmetbook/generation/assets.gen.dart';
import 'package:gourmetbook/helpers/const.dart';
import 'package:gourmetbook/widgets/buttton.dart';
import 'package:provider/provider.dart';

class AddMenuItems extends StatefulWidget {
  final List<MenuItem> menuItems;
  const AddMenuItems({super.key, required this.menuItems});

  @override
  State<AddMenuItems> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<AddMenuItems> {
  late PageController _pageController;
  int activePage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1);
  }

  @override
  Widget build(BuildContext context) {
    var authProvider =
        Provider.of<addRestoEventProvider>(context, listen: true);
    return Column(
      children: [
        ...buildMenuItems(),
        InkWell(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                children: [Icon(Icons.add), Text("tap to add a new menu item")],
              ),
            ),
          ),
          // Assets.icon.addImage.image(
          //   fit: BoxFit.cover,
          // ),
          onTap: () {
            _dialogBuilder(context);
            //authProvider.pickImage(true);
          },
        ),
      ],
    );
  }

  List<Widget> buildMenuItems() {
    List<Widget> widgetList = [];
    for (MenuItem x in widget.menuItems) {
      widgetList.add(Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
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
                                image: FileImage(
                                  File(x.itemImg!),

                                  // TODO errorBuilder
                                  // TODO loadingBuilder
                                ),
                              ),
                            )),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              x.itemName!,
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
                                Text(
                                  x.itemPrice.toString(),
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
        ),
      ));
    }
    return widgetList;
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        var provider =
            Provider.of<addRestoEventProvider>(context, listen: true);
        TextEditingController nameCon = TextEditingController();
        TextEditingController priceCon = TextEditingController();

        return Dialog(
          //title: const Text('Add a new menu Item'),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  'Add a new menu Item',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                provider.item.itemImg == null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: InkWell(
                            child: Assets.icon.addImage.image(
                              fit: BoxFit.cover,
                            ),
                            onTap: () {
                              provider.pickImage2(false);
                            },
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 2,
                          child: Container(
                            height: 200,
                            width: 200,
                            child: Image.file(
                              File(provider.item.itemImg!),
                              fit: BoxFit.cover,
                              // TODO errorBuilder
                              // TODO loadingBuilder
                            ),
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    //  obscureText: true,
                    keyboardType: TextInputType.name,
                    controller: nameCon,

                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      hintText: "itemName",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.price_change),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    //  obscureText: true,
                    keyboardType: TextInputType.number,
                    controller: priceCon,

                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      hintText: "price",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.price_change),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyElevatedButton(
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 159, 75, 237),
                        Color.fromARGB(255, 14, 119, 247),
                      ]),
                      borderRadius: BorderRadius.circular(20),
                      onPressed: () {
                        provider.addMenuitem(
                            nameCon.value.text, priceCon.value.text);
                        Navigator.of(context).pop();
                      },
                      child: Text("Add")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyElevatedButton(
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 148, 147, 148),
                        Color.fromARGB(255, 169, 206, 250),
                      ]),
                      borderRadius: BorderRadius.circular(20),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel")),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
