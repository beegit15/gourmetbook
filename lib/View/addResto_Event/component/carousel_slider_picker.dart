import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gourmetbook/Providers/addRestoEventsprovider.dart';
import 'package:gourmetbook/generation/assets.gen.dart';
import 'package:gourmetbook/helpers/const.dart';
import 'package:provider/provider.dart';

class CarouselSliderPicker extends StatefulWidget {
  final List<String> images;
  const CarouselSliderPicker({super.key, required this.images});

  @override
  State<CarouselSliderPicker> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSliderPicker> {
  late PageController _pageController;
  int activePage = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          itemCount: widget.images.length + 1,
          controller: _pageController,
          onPageChanged: (page) {
            setState(() {
              activePage = page;
            });
          },
          itemBuilder: (context, index) {
            if (widget.images.length == index) {
              var provider =
                  Provider.of<addRestoEventProvider>(context, listen: false);
              return InkWell(
                child: Assets.icon.addImage.image(
                  height: 20,
                  width: 20,
                ),
                onTap: () {
                  provider.pickImage(false);
                },
              );
            } else {
              return Image.file(
                File(widget.images[index]),
                fit: BoxFit.cover,
                // TODO errorBuilder
                // TODO loadingBuilder
              );
            }
          },
        ),
        // INDICATORS
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: indicators(widget.images.length, activePage),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(defaultPadding) * .3,
        width: 7,
        height: 7,
        decoration: BoxDecoration(
            color:
                currentIndex == index ? ColorName.white : ColorName.lightGrey,
            shape: BoxShape.circle),
      );
    });
  }
}
