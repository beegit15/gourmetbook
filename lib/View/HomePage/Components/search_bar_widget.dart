import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gourmetbook/Models/advert.dart';
import 'package:gourmetbook/Providers/HomeProvider.dart';
import 'package:gourmetbook/View/HomePage/Components/shimmer_widget.dart';
import 'package:gourmetbook/generation/assets.gen.dart';
import 'package:gourmetbook/helpers/const.dart';
import 'package:gourmetbook/helpers/context_extension.dart';
import 'package:gourmetbook/helpers/product_constants.dart';
import 'package:gourmetbook/routes/goRouter.dart';
import 'package:provider/provider.dart';

class SearchBarWidget extends StatelessWidget {
  final VoidCallback onTap;
  const SearchBarWidget({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<homeProvider>(context, listen: true);
    List<Advert> results = provider.suggestions!;
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: EdgeInsets.symmetric(vertical: context.lowValue),
      width: double.infinity,
      constraints: BoxConstraints(
          minHeight: context.width * .13, maxHeight: context.height),
      //height: context.width * .13,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        color: ColorName.white,
        boxShadow: ProductConstants.instance.defaultShadow,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Row(
              children: [
                // Search Button
                Flexible(child: _searchButton(context)),

                // Where to ?
                _formField(context),
                //   const Spacer(),

                // Filter Button
                Flexible(child: _filterButton(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton _searchButton(BuildContext context) {
    var provider = Provider.of<homeProvider>(context, listen: true);

    return ElevatedButton(
      clipBehavior: Clip.none,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(ColorName.white),
        shape: MaterialStateProperty.all<CircleBorder>(
          const CircleBorder(),
        ),
      ),
      onPressed: () {
        provider.setsearching(true);
      },
      child: Assets.svg.icSearch.svg(
        height: 18,
        color: ColorName.black,
      ),
    );
  }

  ShimmerWidget _formField(BuildContext context) {
    var provider = Provider.of<homeProvider>(context, listen: true);

    return ShimmerWidget(
        enabled: false,
        child: !provider.searching
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Where to ?"),
                  Text(
                    'Events • Restaurant • Any week ',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              )
            : Flexible(
                flex: 4,
                child: TypeAheadField<Advert>(
                  textFieldConfiguration: TextFieldConfiguration(
                      autofocus: true,
                      style: DefaultTextStyle.of(context)
                          .style
                          .copyWith(fontStyle: FontStyle.italic),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide.none,
                        ),
                      )),
                  suggestionsCallback: (pattern) =>
                      provider.onSearchValueChanged(pattern),
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                        title: Text(suggestion.name),
                        leading: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 10,
                            height: MediaQuery.of(context).size.width * .1,
                            child: Image.network(
                              suggestion.advertPhotos[0],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ));
                  },
                  onSuggestionSelected: (suggestion) {
                    provider.selectAdvert(suggestion);
                    goRouter.push("/details");
                  },
                )));
  }

  Visibility _filterButton(BuildContext context) {
    var provider = Provider.of<homeProvider>(context, listen: true);

    return Visibility(
      visible: !provider.searching,
      replacement: ElevatedButton(
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
          onPressed: () {
            provider.setsearching(false);
          },
          child: const Icon(
            Icons.clear,
            size: 18,
            color: ColorName.black,
          )), // TODO Make visible false during loading state
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
