import 'package:flutter/material.dart';
import 'package:gourmetbook/Providers/HomeProvider.dart';
import 'package:gourmetbook/Providers/authProvider.dart';
import 'package:gourmetbook/View/HomePage/Components/advert_card_widget.dart';
import 'package:gourmetbook/helpers/const.dart';
import 'package:gourmetbook/routes/goRouter.dart';
import 'package:provider/provider.dart';

class WishListView extends StatelessWidget {
  const WishListView({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<homeProvider>(context, listen: true);
    var authProvider = Provider.of<Auth>(context, listen: true);

    var adverts = provider.getWishList(authProvider!.userModel!.wishList!);
    return SafeArea(
      child: adverts.isEmpty
          ? Center(
              child: Text("Your wishlist is empty"),
            )
          : ListView.separated(
              separatorBuilder: (context, index) =>
                  SizedBox(height: defaultPadding),
              padding: const EdgeInsets.only(
                  bottom: kFloatingActionButtonMargin + 48),
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
    );
  }
}
