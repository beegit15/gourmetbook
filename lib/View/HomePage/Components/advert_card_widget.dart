import 'package:flutter/material.dart';
import 'package:gourmetbook/Models/advert.dart';
import 'package:gourmetbook/Providers/authProvider.dart';
import 'package:gourmetbook/View/HomePage/Components/carousel_slider.dart';
import 'package:gourmetbook/generation/assets.gen.dart';
import 'package:gourmetbook/helpers/const.dart';
import 'package:provider/provider.dart';

class AdvertCardWidget extends StatelessWidget {
  final Advert advert;

  const AdvertCardWidget({Key? key, required this.advert}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var images = advert.advertPhotos;
    var authProvider = Provider.of<Auth>(context, listen: true);

    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 235, 235, 235),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE (square)
          Stack(
            children: [
              DecoratedBox(
                decoration: const BoxDecoration(
                  color: ColorName.lightGrey,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * .9,
                    child: CarouselSlider(images: images),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      size: 25,
                      color: authProvider.isfav(advert.id)
                          ? ColorName.red
                          : ColorName.white,
                    ),
                    onPressed: () {
                      authProvider.addToWishList(advert.id);
                    },
                  ),
                ),
              )
            ],
          ),

          Padding(
              padding: const EdgeInsets.only(top: defaultPadding),
              child: Text('${advert.name}')),
          // LOCATION and Star Rating
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(' ${advert.country}'),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 15,
                    ),
                    if (advert.rating != null)
                      Text(advert.rating!.rate.toString()),
                  ],
                )
              ],
            ),
          ),

          // DATE
          Text('${advert.availableDate} - ${advert.availableDate}'),

          // PRICE / NIGHT
          Padding(
            padding: EdgeInsets.only(top: defaultPadding),
            child: Text("Reservation Price :  ${advert.reservationprice}"),
          ),
        ],
      ),
    );
  }
}
