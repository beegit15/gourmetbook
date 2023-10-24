import 'package:flutter/material.dart';
import 'package:gourmetbook/Models/advert.dart';
import 'package:gourmetbook/Providers/HomeProvider.dart';
import 'package:gourmetbook/View/HomePage/Components/advert_card_widget.dart';
import 'package:gourmetbook/View/details/components/menuItemWidget.dart';
import 'package:gourmetbook/widgets/buttton.dart';
import 'package:provider/provider.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<homeProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              AdvertCardWidget(advert: provider.selectedAdvert!),
              ...getMenuItems(provider.selectedAdvert!.menuItems!),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: MyElevatedButton(
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 159, 75, 237),
                    Color.fromARGB(255, 14, 119, 247),
                  ]),
                  borderRadius: BorderRadius.circular(20),
                  onPressed: () {
                    // addProvider.uploadAdvert(
                    //   addProvider.nameController.value.text,
                    //   addProvider.countryController.value.text,
                    //   addProvider.cityController.value.text,
                    //   addProvider.priceController.value.text,
                    //   context,
                    //   authProvider.userModel!.displayName!,
                    //   authProvider.userModel!.uid,
                    // );
                  },
                  child: Text(
                    "Reserve And Pay",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getMenuItems(List<MenuItem> menuItems) {
    List<MenuItemWidget> _menuItems = [];
    for (MenuItem x in menuItems!) {
      _menuItems.add(MenuItemWidget(
          itemName: x.itemName,
          itemAmount: x.itemPrice.toString(),
          itemImg: x.itemImg!));
    }
    return _menuItems;
  }
}
