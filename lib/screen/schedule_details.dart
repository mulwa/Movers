import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movers/controllers/map_page_controller.dart';
import 'package:movers/controllers/transport_details_controller.dart';
import 'package:movers/shared/app_card.dart';
import 'package:movers/shared/styles.dart';
import 'package:movers/shared/vertical_spacing.dart';

class ScheduleDetails extends StatelessWidget {
  final MapPageController mapController = Get.find();
  final TransportDetailsController transportDetailsController = Get.find();
  // const ScheduleDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Schedule Details"),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 300,
                  child: GoogleMap(
                    initialCameraPosition: mapController.kGooglePlex,
                    polylines: mapController.mapPolyline,
                    markers: mapController.markers,
                    circles: mapController.circle,
                    onMapCreated: (GoogleMapController controller) {
                      mapController.mapController?.value = controller;
                    },
                  ),
                ),
                VerticalSpacing(),
                AppCard(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      titleSub(
                          color: Colors.greenAccent,
                          title: mapController
                              .pickupAddress.value.placeFormattedAddress
                              .toString()),
                      VerticalSpacing(),
                      titleSub(
                          color: Colors.blueAccent,
                          title: mapController
                              .destinationAddress.value.placeFormattedAddress
                              .toString()),
                      VerticalSpacing(),
                      Divider(),
                      VerticalSpacing(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Distance",
                                style: greyTitleStyle,
                              ),
                              Text(
                                mapController
                                    .tripDirectionDetails.value.distanceText!,
                                style: mediumTitleStyle,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Approximate Time",
                                style: greyTitleStyle,
                              ),
                              Text(
                                mapController
                                    .tripDirectionDetails.value.durationText!,
                                style: mediumTitleStyle,
                              )
                            ],
                          )
                        ],
                      ),
                      VerticalSpacing(),
                      Divider(),
                      VerticalSpacing(),
                      Text(transportDetailsController.movingDate.value),
                      VerticalSpacing(),
                      Text(transportDetailsController.movingTime.value)
                    ],
                  ),
                ),
              ],
            )));
  }

  Widget titleSub({required String title, Color? color = Colors.grey}) {
    return Row(
      children: [
        Icon(Icons.place, color: color),
        SizedBox(
          width: 5.0,
        ),
        Column(
          children: [
            Text(
              title,
              style: mediumTitleStyle,
            ),
          ],
        )
      ],
    );
  }
}
