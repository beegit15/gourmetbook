import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:gourmetbook/Models/advert.dart';
import 'package:gourmetbook/Providers/HomeProvider.dart';
import 'package:gourmetbook/Providers/ReservationProvider.dart';
import 'package:gourmetbook/Providers/authProvider.dart';
import 'package:gourmetbook/View/HomePage/Components/advert_card_widget.dart';
import 'package:gourmetbook/View/details/components/menuItemWidget.dart';
import 'package:gourmetbook/helpers/const.dart';
import 'package:gourmetbook/widgets/buttton.dart';
import 'package:provider/provider.dart';
import 'package:time_range/time_range.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<homeProvider>(context, listen: true);
    var authProvider = Provider.of<Auth>(context, listen: true);
    var reservationProvider =
        Provider.of<ReservationProvider>(context, listen: true);

    List<String> startTime = provider.selectedAdvert!.availableDate.split('to');
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              AdvertCardWidget(advert: provider.selectedAdvert!),
              ...getMenuItems(provider.selectedAdvert!.menuItems!, context),
              InkWell(
                onTap: () async {
                  var results = await showCalendarDatePicker2Dialog(
                    context: context,
                    config: CalendarDatePicker2WithActionButtonsConfig(
                      selectedDayHighlightColor: kPrimaryColor,
                      calendarType: CalendarDatePicker2Type.single,
                    ),
                    dialogSize: const Size(325, 400),
                    //value: _dates,
                    borderRadius: BorderRadius.circular(15),
                  );
                  if (results != null) {
                    reservationProvider.setDay(results![0]!);
                  }
                },
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
                    child: reservationProvider.day != null
                        ? Center(
                            child: Text(
                            reservationProvider.day.toString().split(' ')[0],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                        : Center(
                            child:
                                Text("tap to select a your reservation day")),
                  ),
                ),
              ),
              TimeRange(
                fromTitle: Text(
                  'From',
                  style: TextStyle(fontSize: 18, color: ColorName.grey),
                ),
                toTitle: Text(
                  'To',
                  style: TextStyle(fontSize: 18, color: ColorName.grey),
                ),
                titlePadding: 20,
                textStyle: TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.black87),
                activeTextStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                borderColor: ColorName.black,
                backgroundColor: Colors.transparent,
                activeBackgroundColor: kPrimaryColor,
                firstTime: TimeOfDay(
                    hour: int.parse(startTime[1].split(":")[0]),
                    minute: int.parse(startTime[1].split(":")[1])),
                lastTime: TimeOfDay(
                    hour: int.parse(startTime[0].split(":")[0]),
                    minute: int.parse(startTime[0].split(":")[1])),
                timeStep: 60,
                timeBlock: 30,
                onRangeCompleted: (range) {
                  if (range != null) {
                    reservationProvider.setTime(range!.start, range!.end);
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: MyElevatedButton(
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 159, 75, 237),
                    Color.fromARGB(255, 14, 119, 247),
                  ]),
                  borderRadius: BorderRadius.circular(20),
                  onPressed: () {
                    reservationProvider.submitReservation(
                      provider.selectedAdvert!.id,
                      authProvider.userModel!.uid,
                      provider.selectedAdvert!.publisherUid,
                    );
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
                    "Reserve",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getMenuItems(List<MenuItem> menuItems, BuildContext context) {
    var reservationProvider =
        Provider.of<ReservationProvider>(context, listen: true);

    List<InkWell> _menuItems = [];
    for (MenuItem x in menuItems!) {
      _menuItems.add(InkWell(
        onTap: () {
          if (reservationProvider.isMenuSelected(x)) {
            reservationProvider.unselectMenuItem(x);
          } else {
            reservationProvider.selectMenuItem(x);
          }
        },
        child: MenuItemWidget(
            selected: reservationProvider.isMenuSelected(x),
            itemName: x.itemName,
            itemAmount: x.itemPrice.toString(),
            itemImg: x.itemImg!),
      ));
    }
    return _menuItems;
  }
}
