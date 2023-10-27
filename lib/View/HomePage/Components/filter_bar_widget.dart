import 'package:flutter/material.dart';
import 'package:gourmetbook/Providers/HomeProvider.dart';
import 'package:gourmetbook/helpers/const.dart';
import 'package:gourmetbook/helpers/product_constants.dart';
import 'package:provider/provider.dart';

class FilterBarWidget extends StatefulWidget {
  const FilterBarWidget({super.key});

  @override
  State<FilterBarWidget> createState() => _FilterBarWidgetState();
}

class _FilterBarWidgetState extends State<FilterBarWidget> {
  //

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<homeProvider>(context, listen: true);

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: ProductConstants.instance.filterNames.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _onFilterTap(provider, index),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(top: defaultPadding),
                  child: Image.asset(
                    ProductConstants.instance.filterIcons[index],
                    height: 20,
                    width: 20,
                  ),
                ),
                Text(ProductConstants.instance.filterNames[index]),
                const Spacer(),
                Container(
                  margin: EdgeInsets.only(bottom: defaultPadding / 2),
                  height: 5,
                  width: 5,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    color: provider.selectedFilterIndex == index
                        ? ColorName.black
                        : Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onFilterTap(viewModel, index) async {
    // TODO: Implement filter logic
    viewModel.setSelectedFilterIndex = index;
  }
}
