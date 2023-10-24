import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gourmetbook/View/HomePage/exploreView/View/exploreMap.dart';
import 'package:gourmetbook/View/Profile/Profile.dart';
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
          ? ExploreMap()
          : provider.currentIndex == 3
              ? Profile()
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
        selectedItemColor: ColorName.blue,
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
                  ? ColorName.blue
                  : ColorName.darkGrey,
            ),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Assets.svg.icFav.svg(
              color: provider.currentIndex == 1
                  ? ColorName.blue
                  : ColorName.darkGrey,
              height: 25,
            ),
            label: "Wishlists",
          ),
          BottomNavigationBarItem(
            icon: Assets.svg.icInbox.svg(
              color: provider.currentIndex == 2
                  ? ColorName.blue
                  : ColorName.darkGrey,
              height: 25,
            ),
            label: "Reservations",
          ),
          BottomNavigationBarItem(
            icon: Assets.svg.icProfile.svg(
              color: provider.currentIndex == 3
                  ? ColorName.blue
                  : ColorName.darkGrey,
              height: 25,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
