import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gourmetbook/Providers/HomeProvider.dart';
import 'package:gourmetbook/View/HomePage/Components/currentLocartion.dart';
import 'package:gourmetbook/View/HomePage/Components/filter_bar_widget.dart';
import 'package:gourmetbook/View/HomePage/Components/search_bar_widget.dart';
import 'package:gourmetbook/View/HomePage/HomePage.dart';
import 'package:gourmetbook/View/HomePage/exploreView/View/exploreview.dart';
import 'package:gourmetbook/generation/assets.gen.dart';
import 'package:gourmetbook/helpers/const.dart';
import 'package:gourmetbook/helpers/context_extension.dart';
import 'package:gourmetbook/helpers/product_constants.dart';
import 'dart:ui' as ui;
import "package:latlong2/latlong.dart" as latLng;
import 'package:provider/provider.dart';

class ExploreMap extends StatelessWidget {
  const ExploreMap({super.key});

  @override
  Widget build(BuildContext context) {
    var draggableHeight = MediaQuery.of(context).size.height -
        (defaultPadding +
            80 +
            MediaQueryData.fromView(View.of(context)).padding.bottom);
    return SafeArea(
      child: Stack(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Stack(
                  children: [
                    // MAP
                    _map(context, draggableHeight),

                    // CURRENT LOCATION BUTTON
                    _currentLocationButton(context)
                  ],
                ),
              ),

              // DRAGGABLE EXPLORE LIST
              _draggableSheet(draggableHeight, context),
            ],
          ),

          // APPBAR
          _appBar(context),
        ],
      ),
    );
  }

  Container _appBar(BuildContext context) {
    return Container(
      //padding: EdgeInsets.only(bottom: context.paddingTop),
      width: double.infinity,
      height: context.paddingTop + 33,
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: ColorName.black.withOpacity(.1),
            offset: const Offset(0, 1),
            blurRadius: 3,
          ),
        ],
      ),
      child:
          // Search Bar
          Padding(
        padding: EdgeInsets.symmetric(horizontal: context.mediumValue),
        child: SearchBarWidget(onTap: () {}),
      ),

      // Filter Bar
      // const Expanded(
      //   child: FilterBarWidget(),
      // ),
    );
  }

  Container _map(BuildContext context, double draggableHeight) {
    var provider = Provider.of<homeProvider>(context, listen: true);

    return Container(
        color: ColorName.red,
        //  margin: EdgeInsets.only(top: (context.paddingTop)),
        //  padding: EdgeInsets.only(top: 55, bottom: draggableHeight * .06),
        width: double.infinity,
        child: FlutterMap(
          mapController: provider.mapController,
          options: const MapOptions(
            initialCenter: latLng.LatLng(51.509364, -0.128928),
            zoom: 3.2,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            CLocationLayer(),
            MarkerLayer(markers: provider.getMatkers()),
          ],
        ));
  }

  Align _currentLocationButton(BuildContext context) {
    var provider = Provider.of<homeProvider>(context, listen: true);

    return Align(
      alignment: Alignment.topRight,
      child: Container(
        height: 81,
        decoration: BoxDecoration(
          boxShadow: ProductConstants.instance.defaultShadow,
        ),
        margin: EdgeInsets.only(
            right: context.normalValue * 1.2, top: context.highValue * 2.5),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                print("here we go");
                provider.determinePosition();
              },
              child: Container(
                padding: const EdgeInsets.all(11),
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: ColorName.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                ),
                child: Assets.svg.icLocation.svg(),
              ),
            ),
            Container(
              width: 40,
              height: 1,
              color: ColorName.lightGrey,
            ),
            Container(
              padding: const EdgeInsets.all(9),
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: ColorName.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
              ),
              child: Assets.svg.icSettings.svg(color: ColorName.black),
            ),
          ],
        ),
      ),
    );
  }

  Align _draggableSheet(double draggableHeight, BuildContext ctx) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: draggableHeight,
        child: DraggableScrollableSheet(
          controller: draggableScrollController,
          snap: true,
          initialChildSize: 1,
          minChildSize: .1,
          maxChildSize: 1,
          builder: (context, scrollController) {
            var provider = Provider.of<homeProvider>(context, listen: true);

            provider.setctx(context);
            provider.addL(context);
            return ExploreView(controller: scrollController);
          },
        ),
      ),
    );
  }
}
