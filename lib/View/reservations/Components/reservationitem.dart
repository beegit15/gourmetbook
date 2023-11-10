import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gourmetbook/Models/UserModel.dart';
import 'package:gourmetbook/Models/advert.dart';
import 'package:gourmetbook/Models/reservation.dart';
import 'package:gourmetbook/Providers/HomeProvider.dart';
import 'package:gourmetbook/Providers/ReservationProvider.dart';
import 'package:gourmetbook/Providers/authProvider.dart';
import 'package:gourmetbook/View/reservations/Components/cardButtonComponent.dart';
import 'package:gourmetbook/helpers/const.dart';
import 'package:provider/provider.dart';

class ReservationItem extends StatelessWidget {
  final Reservation reservationModel;
  final bool themeFlag;
  final GestureTapCallback? onTap;

  const ReservationItem({
    Key? key,
    required this.reservationModel,
    this.onTap,
    required this.themeFlag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width / 375;
    var provider = Provider.of<homeProvider>(context, listen: true);
    Advert? advert = provider.adverts!
        .firstWhere((advert) => advert.id == reservationModel.advertId);

    var reservationProvider =
        Provider.of<ReservationProvider>(context, listen: true);
    var authProvider = Provider.of<Auth>(context, listen: true);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(27, 5, 27, 0),
        child: Card(
          color: ColorName.white,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: _width * 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: ColorName.darkGrey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: CachedNetworkImage(
                            imageUrl: advert.advertPhotos[0],
                            imageBuilder: (context, imageProvider) => Container(
                              height: 80,
                              width: 70,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                'Name : ${advert.publisher} ',
                                maxLines: 1,
                                style: TextStyle(
                                  color: ColorName.black,
                                  fontSize: _width * 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 6, top: 2),
                              child: Text(
                                'Country : ${advert.country}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: ColorName.black,
                                  fontSize: _width * 12,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 6, top: 2),
                              child: Text(
                                'Date : ${reservationModel.reservationDay.split(" ")[0]}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: ColorName.black,
                                  fontSize: _width * 12,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 6, top: 2),
                              child: Text(
                                'From: ${reservationModel.reservationStartTime.split("(")[1].split(")")[0]} , To : ${reservationModel.reservationEndTime.split("(")[1].split(")")[0]}  ',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: ColorName.black,
                                  fontSize: _width * 12,
                                ),
                              ),
                            ),
                            if (reservationModel.confirmed)
                              Padding(
                                padding: const EdgeInsets.only(left: 6, top: 2),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_box,
                                      color: ColorName.green1,
                                    ),
                                    Text(
                                      'Confirmed',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: _width * 13,
                                        color: ColorName.green1,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (!reservationModel.confirmed)
                              Padding(
                                padding: const EdgeInsets.only(left: 2, top: 2),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: ColorName.yellow,
                                    ),
                                    Text(
                                      'Waiting for confirmation',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: _width * 13,
                                        color: ColorName.yellow,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                if (authProvider.userModel!.userType != UserType.User)
                  if (!reservationModel.confirmed)
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            //height: 50,
                            child: CardButtonComponent(
                              title: "Confirm",
                              onPressed: () {
                                reservationProvider
                                    .confirmeReservation(reservationModel);
                              },
                              isColored: true,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            //height: 50,
                            child: CardButtonComponent(
                              title: "Cancel",
                              onPressed: () {
                                reservationProvider
                                    .cancelReservation(reservationModel);
                              },
                              isColored: false,
                            ),
                          ),
                        )
                      ],
                    ),
                if (authProvider.userModel!.userType == UserType.User)
                  if (!reservationModel.confirmed)
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      //height: 50,
                      child: CardButtonComponent(
                        title: "Cancel",
                        onPressed: () {
                          reservationProvider
                              .cancelReservation(reservationModel);
                        },
                        isColored: false,
                      ),
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
