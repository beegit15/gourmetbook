import 'package:flutter/material.dart';
import 'package:gourmetbook/Providers/ReservationProvider.dart';
import 'package:gourmetbook/View/reservations/Components/cardButtonComponent.dart';
import 'package:gourmetbook/View/reservations/Components/reservationitem.dart';
import 'package:gourmetbook/helpers/const.dart';
import 'package:gourmetbook/widgets/buttton.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ReservationsView extends StatelessWidget {
  const ReservationsView({super.key});
  @override
  Widget build(BuildContext context) {
    var reservationProvider =
        Provider.of<ReservationProvider>(context, listen: true);

    return SafeArea(
        child: reservationProvider.loading
            ? Center(
                child: Shimmer.fromColors(
                  baseColor: ColorName.white,
                  highlightColor: ColorName.lightGrey,
                  child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Card(
                          color: ColorName.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          child: Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: ColorName.darkGrey
                                                    .withOpacity(0.1),
                                                spreadRadius: 1,
                                                blurRadius: 1,
                                                offset: Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              child: Container(
                                                height: 50,
                                                width: 100,
                                              )),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              )
            : ListView.builder(
                itemCount: reservationProvider.reservations.length,
                itemBuilder: (context, index) {
                  return ReservationItem(
                      reservationModel: reservationProvider.reservations[index],
                      themeFlag: true,
                      onTap: () {});
                }));
  }
}
