import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart" as latLng;

import 'package:gourmetbook/Providers/HomeProvider.dart';
import 'package:gourmetbook/Providers/authProvider.dart';
import 'package:gourmetbook/View/HomePage/Components/scroll_to_hide_widget.dart';
import 'package:gourmetbook/generation/assets.gen.dart';

import 'package:gourmetbook/helpers/const.dart';

import 'package:provider/provider.dart';

DraggableScrollableController draggableScrollController =
    DraggableScrollableController();

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<homeProvider>(context, listen: true);
    return Scaffold(
      body: provider.currentIndex == 0
          ? FlutterMap(
              options: const MapOptions(
                initialCenter: latLng.LatLng(51.509364, -0.128928),
                zoom: 3.2,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
              ],
            )
          : Scaffold(),
      bottomNavigationBar: buildBottomBar(context),
    );
  }

  Widget buildBottomBar(BuildContext context) {
    var provider = Provider.of<homeProvider>(context, listen: true);
    return ScrollToHideWidget(
      child: BottomNavigationBar(
        selectedFontSize: 12,
        unselectedFontSize: 11.5,
        iconSize: 25,
        currentIndex: provider.currentIndex,
        selectedItemColor: ColorName.red,
        unselectedIconTheme: const IconThemeData(color: ColorName.grey),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          provider.changeIndex(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Assets.svg.icSearch.svg(
              height: 25,
              color: provider.currentIndex == 0
                  ? ColorName.red
                  : ColorName.darkGrey,
            ),
            label: "explore",
          ),
          BottomNavigationBarItem(
            icon: Assets.svg.icFav.svg(
              color: provider.currentIndex == 1
                  ? ColorName.red
                  : ColorName.darkGrey,
              height: 25,
            ),
            label: "wishlists",
          ),
          BottomNavigationBarItem(
            icon: Assets.svg.icAirbnb.svg(
              color: provider.currentIndex == 2
                  ? ColorName.red
                  : ColorName.darkGrey,
              height: 25,
            ),
            label: "trips",
          ),
          BottomNavigationBarItem(
            icon: Assets.svg.icInbox.svg(
              color: provider.currentIndex == 3
                  ? ColorName.red
                  : ColorName.darkGrey,
              height: 25,
            ),
            label: "inbox",
          ),
          BottomNavigationBarItem(
            icon: Assets.svg.icProfile.svg(
              color: provider.currentIndex == 4
                  ? ColorName.red
                  : ColorName.darkGrey,
              height: 25,
            ),
            label: "profile",
          ),
        ],
      ),
    );
  }
}
