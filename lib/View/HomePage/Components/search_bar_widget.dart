import 'package:flutter/material.dart';
import 'package:gourmetbook/View/HomePage/Components/shimmer_widget.dart';
import 'package:gourmetbook/generation/assets.gen.dart';
import 'package:gourmetbook/helpers/const.dart';
import 'package:gourmetbook/helpers/context_extension.dart';
import 'package:gourmetbook/helpers/product_constants.dart';

class SearchBarWidget extends StatelessWidget {
  final VoidCallback onTap;
  const SearchBarWidget({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: EdgeInsets.symmetric(vertical: context.lowValue),
      width: double.infinity,
      height: context.width * .13,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        color: ColorName.white,
        boxShadow: ProductConstants.instance.defaultShadow,
      ),
      child: Row(
        children: [
          // Search Button
          Flexible(child: _searchButton()),

          // Where to ?
          _formField(),
          const Spacer(),

          // Filter Button
          Flexible(child: _filterButton()),
        ],
      ),
    );
  }

  ElevatedButton _searchButton() {
    return ElevatedButton(
      clipBehavior: Clip.none,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(ColorName.white),
        shape: MaterialStateProperty.all<CircleBorder>(
          const CircleBorder(),
        ),
      ),
      onPressed: onTap,
      child: Assets.svg.icSearch.svg(
        height: 18,
        color: ColorName.black,
      ),
    );
  }

  ShimmerWidget _formField() {
    return const ShimmerWidget(
      enabled: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Where to ?"),
          Text(
            'Events • Restaurant • Any week ',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Visibility _filterButton() {
    return Visibility(
      visible: true, // TODO Make visible false during loading state
      child: ElevatedButton(
        clipBehavior: Clip.none,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(ColorName.white),
          shape: MaterialStateProperty.all<CircleBorder>(
            const CircleBorder(),
          ),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
              color: ColorName.black.withOpacity(.1),
            ),
          ),
        ),
        onPressed: onTap,
        child: Assets.svg.icFilter.svg(
          height: 18,
          color: ColorName.black,
        ),
      ),
    );
  }
}
