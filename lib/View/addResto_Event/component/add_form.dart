import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gourmetbook/Models/advert.dart';
import 'package:gourmetbook/Providers/HomeProvider.dart';
import 'package:gourmetbook/Providers/addRestoEventsprovider.dart';
import 'package:gourmetbook/Providers/authProvider.dart';
import 'package:gourmetbook/View/addResto_Event/component/addMenu.dart';
import 'package:gourmetbook/View/addResto_Event/component/carousel_slider_picker.dart';
import 'package:gourmetbook/View/login/login.dart';
import 'package:gourmetbook/View/signUp/component/popUpMenu.dart';
import 'package:gourmetbook/helpers/const.dart';
import 'package:gourmetbook/routes/goRouter.dart';
import 'package:gourmetbook/widgets/alreadyHaveAccount.dart';
import 'package:gourmetbook/widgets/buttton.dart';
import 'package:provider/provider.dart';

class AddForm extends StatelessWidget {
  final ScrollController controller;

  AddForm({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var addProvider = Provider.of<addRestoEventProvider>(context, listen: true);
    var authProvider = Provider.of<Auth>(context, listen: true);
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: addProvider.nameController,
            //  keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "name",
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
                initialValue: addProvider.getItemSelectedValue(),
                onMenuItemSelected: addProvider.onMenuItemSelected,
                selectedValue: addProvider.selectedValuFromPopUpMenu,
                menuList: const [
                  PopupMenuItem(
                    value: 1,
                    child: ListTile(
                      leading: Icon(
                        Icons.event,
                      ),
                      title: Text("Event"),
                    ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem(
                    value: 2,
                    child: ListTile(
                      leading: Icon(Icons.restaurant),
                      title: Text("Restaurant"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: defaultPadding),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: defaultPadding),
                      child: TextFormField(
                        controller: addProvider.countryController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        cursorColor: kPrimaryColor,
                        onSaved: (email) {},
                        decoration: const InputDecoration(
                          hintText: "country",
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Icon(Icons.flag),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      //  obscureText: true,
                      controller: addProvider.cityController,
                      cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        hintText: "city",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.location_city),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: defaultPadding, bottom: defaultPadding),
            child: Container(
                decoration: const BoxDecoration(
                  color: ColorName.lightGrey,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                height: MediaQuery.of(context).size.height * 0.5,
                padding: const EdgeInsets.only(
                    top: defaultPadding, bottom: defaultPadding),
                child: CarouselSliderPicker(images: addProvider.images)),
          ),
          const SizedBox(height: defaultPadding / 2),
          Padding(
            padding: const EdgeInsets.only(top: defaultPadding),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                        //  height: kMinInteractiveDimension,
                        //width: double.infinity,
                        decoration: const BoxDecoration(
                          color: kPrimaryLightColor,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          // borderSide: BorderSide.none,
                        ),
                        child: ListTile(
                          minLeadingWidth: 5,
                          contentPadding: EdgeInsets.only(right: 2),
                          leading: const Icon(
                            Icons.timelapse,
                            color: kPrimaryColor,
                          ),
                          title: Text(
                            addProvider.avaibelity,
                            maxLines: 1,
                          ),
                          onTap: () {
                            addProvider.selectTimeRange(context);
                          },
                        )),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: defaultPadding),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        //  obscureText: true,
                        keyboardType: TextInputType.number,
                        controller: addProvider.priceController,
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
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: AddMenuItems(menuItems: addProvider.menuItems),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Hero(
              tag: "signup_btn",
              child: MyElevatedButton(
                gradient: const LinearGradient(colors: [
                  Color.fromARGB(255, 159, 75, 237),
                  Color.fromARGB(255, 14, 119, 247),
                ]),
                borderRadius: BorderRadius.circular(20),
                onPressed: () {
                  addProvider.uploadAdvert(
                    addProvider.nameController.value.text,
                    addProvider.countryController.value.text,
                    addProvider.cityController.value.text,
                    addProvider.priceController.value.text,
                    context,
                    authProvider.userModel!.displayName!,
                    authProvider.userModel!.uid,
                  );
                },
                child: Text(
                  "Publish your advert".toUpperCase(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: defaultPadding * 3,
          )
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
