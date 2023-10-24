import 'package:flutter/material.dart';
import 'package:gourmetbook/Models/UserModel.dart';
import 'package:gourmetbook/Models/advert.dart';
import 'package:gourmetbook/Providers/HomeProvider.dart';
import 'package:gourmetbook/Providers/authProvider.dart';
import 'package:gourmetbook/View/HomePage/Components/advert_card_widget.dart';
import 'package:gourmetbook/View/HomePage/HomePage.dart';
import 'package:gourmetbook/View/addResto_Event/addResto_Event.dart';
import 'package:gourmetbook/generation/assets.gen.dart';
import 'package:gourmetbook/helpers/const.dart';
import 'package:gourmetbook/helpers/context_extension.dart';
import 'package:gourmetbook/helpers/product_constants.dart';
import 'package:gourmetbook/routes/goRouter.dart';
import 'dart:ui' as ui;

import 'package:provider/provider.dart';

class ExploreView extends StatelessWidget {
  final ScrollController controller;
  const ExploreView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var draggableHeight = MediaQuery.of(context).size.height -
        (defaultPadding +
            114 +
            MediaQueryData.fromWindow(ui.window).padding.bottom);
    var provider = Provider.of<homeProvider>(context, listen: true);
    //provider.changeMapButtonOpacity(context.mounted);
    var authProvider = Provider.of<Auth>(context, listen: true);

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
              color: ColorName.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24)),
              boxShadow: ProductConstants.instance.defaultShadow),
          child: authProvider.userModel!.userType != UserType.User
              ? AddResto_Event(
                  controller: controller,
                )
              : Column(
                  children: [
                    provider.state == AppState.ERROR
                        ? _buildError(context)
                        : _advertList(context),
                  ],
                ),
        ),

        // APPLE SHEET LINE

        _advertDataText(draggableHeight, context),

        _sheetLine(),
        _mapButton(context),
      ],
    );
  }

  Expanded _advertList(BuildContext context) {
    var provider = Provider.of<homeProvider>(context, listen: true);

    var adverts = provider.adverts;
    return Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.separated(
          separatorBuilder: (context, index) =>
              SizedBox(height: defaultPadding),
          controller: controller,
          padding:
              const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 48),
          shrinkWrap: true,
          itemCount: adverts!.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                provider.selectAdvert(adverts[index]);
                goRouter.push("/details");
              },
              child: Container(
                padding: index == 0
                    ? EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * .14,
                      )
                    : EdgeInsets.zero,
                child: AdvertCardWidget(advert: adverts[index]),
              ),
            );
          },
        ),
      ),
    );
  }

  Align _mapButton(BuildContext context) {
    var provider = Provider.of<homeProvider>(context, listen: true);
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () {
          draggableScrollController.animateTo(.1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear);
          controller.animateTo(0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear);
        },
        child: Container(
          margin: EdgeInsets.only(bottom: context.mediumValue),
          width: 90,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            color: ColorName.black.withOpacity(provider.mapButtonOpacity),
          ),
          child: Container(
            padding: context.mapButtonPadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Map",
                    style: TextStyle(
                        color: ColorName.white
                            .withOpacity(provider.mapButtonOpacity))),
                const SizedBox(
                  width: 5,
                ),
                Assets.svg.icMap.svg(
                    height: 16,
                    color:
                        ColorName.white.withOpacity(provider.mapButtonOpacity)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Align _advertDataText(double draggableHeight, BuildContext context) {
    var provider = Provider.of<homeProvider>(context, listen: true);

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
          padding: EdgeInsets.only(top: draggableHeight * .05),
          child: Text(provider.adverts!.isEmpty
              ? "no_exact_matches"
              : "x_adverts_found : ${provider.adverts!.length.toString()}")),
    );
  }

  Align _sheetLine() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        width: 40,
        height: 4,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: ColorName.lightGrey,
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    var provider = Provider.of<homeProvider>(context, listen: true);

    return Center(
      child: Text(provider.failure.message),
    );
  }
}
