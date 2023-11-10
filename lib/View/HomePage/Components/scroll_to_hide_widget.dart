import 'package:flutter/material.dart';
import 'package:gourmetbook/Providers/HomeProvider.dart';
import 'dart:ui' as ui;

import 'package:gourmetbook/View/HomePage/HomePage.dart';
import 'package:provider/provider.dart';

// class ScrollToHideWidget extends StatefulWidget {
//   final Widget child;
//   final Duration duration;
//   const ScrollToHideWidget({
//     Key? key,
//     required this.child,
//     this.duration = const Duration(milliseconds: 200),
//   }) : super(key: key);

//   @override
//   State<ScrollToHideWidget> createState() => _ScrollToHideWidgetState();
// }

// class _ScrollToHideWidgetState extends State<ScrollToHideWidget> {
//   bool isVisible = true;
//   var bottomBarHeight = kBottomNavigationBarHeight +
//       MediaQueryData.fromWindow(ui.window).padding.bottom;

//   @override
//   void dispose() {
//     var provider = Provider.of<homeProvider>(context, listen: false);

//     provider.rmListner(context);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var provider = Provider.of<homeProvider>(context, listen: false);
//     provider.setctx(context);
//     provider.addListner(context);

//     return AnimatedContainer(
//       duration: widget.duration,
//       height: provider.bottomBarHeight,
//       child: Wrap(
//         children: [widget.child],
//       ),
//     );
//   }
// }

class ScrollToHideWidget extends StatelessWidget {
  final Widget child;
  final Duration duration;
  const ScrollToHideWidget({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<homeProvider>(context, listen: true);

    return AnimatedContainer(
      duration: duration,
      height: provider.bottomBarHeight,
      child: Wrap(
        children: [child],
      ),
    );
  }
}
