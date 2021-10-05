import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movers/controllers/transport_details_controller.dart';
import 'package:movers/shared/app_card.dart';
import 'package:movers/shared/vertical_spacing.dart';
import 'package:movers/utils/constants.dart';

class TransportDetailsPage extends GetView<TransportDetailsController> {
  const TransportDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TransportDetailsController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Transport Details"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Center(
                child: Text(
                  "What size vehicle dro you prefer ?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              VerticalSpacing(),
              Column(
                  children: controller.vehicleType
                      .map((vehicle) => GetBuilder<TransportDetailsController>(
                              builder: (controller) {
                            return Card(
                              child: RadioListTile(
                                  groupValue: controller.selectedVehicle.value,
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        vehicle,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                      Text(
                                          "Great for a couple of items or muiltiple small items")
                                    ],
                                  ),
                                  value: vehicle,
                                  activeColor: colorPrimary,
                                  selectedTileColor: colorPrimary,
                                  onChanged: (val) => controller
                                      .setVehicleType(val.toString())),
                            );
                          }))
                      .toList()),
            ],
          ),
        ),
      ),
    );
  }
}
