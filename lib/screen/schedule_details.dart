import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movers/controllers/map_page_controller.dart';
import 'package:movers/controllers/transport_details_controller.dart';
import 'package:movers/shared/app_card.dart';
import 'package:movers/shared/custom_btn.dart';
import 'package:movers/shared/styles.dart';
import 'package:movers/shared/vertical_spacing.dart';
import 'package:movers/utils/constants.dart';

class ScheduleDetails extends StatelessWidget {
  final MapPageController mapController = Get.find();
  final TransportDetailsController transportDetailsController = Get.find();
  // const ScheduleDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: colorPrimaryDark,
              title: Text("Schedule Details"),
            ),
            body: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  child: GoogleMap(
                    initialCameraPosition: mapController.cameraPosition,
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
                          color: colorAccent,
                          title: mapController
                              .pickupAddress.value.placeFormattedAddress
                              .toString()),
                      VerticalSpacing(),
                      titleSub(
                          color: colorAccent,
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
                      Text(
                        "Scheduled date & time",
                        style: greyTitleStyle,
                      ),
                      VerticalSpacing(
                        height: 5.0,
                      ),
                      Text(
                        "${transportDetailsController.movingDate.value} at ${transportDetailsController.movingTime.value}",
                        style: mediumTitleStyle,
                      ),
                      VerticalSpacing(
                        height: 5.0,
                      ),
                      Divider(),
                      Text(
                        "Selected Vehicle Type",
                        style: greyTitleStyle,
                      ),
                      VerticalSpacing(height: 5.0),
                      Text(
                        transportDetailsController.selectedVehicle.value,
                        style: mediumTitleStyle,
                      ),
                      VerticalSpacing(
                        height: 5.0,
                      ),
                      Divider(),
                      VerticalSpacing(),
                      Text(
                        "Total amount to pay",
                        style: greyTitleStyle,
                      ),
                      VerticalSpacing(height: 5.0),
                      Text(
                        "Ksh ${transportDetailsController.fareEstimate(mapController.tripDirectionDetails.value)}",
                        style: mediumTitleStyle,
                      )
                    ],
                  ),
                ),
                VerticalSpacing(
                  height: 15,
                ),
                Center(
                  child: CustomBtn(
                    text: "Submit my Request",
                    press: () {
                      print("submiting my request");
                    },
                  ),
                )
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: mediumTitleStyle,
              ),
            ],
          ),
        )
      ],
    );
  }
}
