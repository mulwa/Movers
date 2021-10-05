import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movers/controllers/transport_details_controller.dart';
import 'package:movers/screen/schedule_details.dart';
import 'package:movers/shared/app_card.dart';
import 'package:movers/shared/custom_btn.dart';
import 'package:movers/shared/vertical_spacing.dart';
import 'package:movers/utils/constants.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

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
              Text(
                "What size vehicle dro you prefer ?",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
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
                                          "Great for a couple of items or multiple small items")
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
              VerticalSpacing(),
              Text(
                "Set moving date ",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
              VerticalSpacing(),
              GestureDetector(
                onTap: () async {
                  controller.setMovingDate();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5.0,
                            offset: Offset(0.7, 0.7))
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.date_range,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Obx(() => Text(
                            controller.movingDate.isEmpty
                                ? "Moving Date"
                                : controller.movingDate.value,
                            style: TextStyle(
                              fontSize: 16.0,
                            )))
                      ],
                    ),
                  ),
                ),
              ),
              VerticalSpacing(),
              Text(
                " Set moving time ",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
              VerticalSpacing(),
              GestureDetector(
                onTap: () async {
                  controller.setMovingTime();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5.0,
                            offset: Offset(0.7, 0.7))
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.time_to_leave,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Obx(() => Text(
                            controller.movingTime.isEmpty
                                ? "Moving Time"
                                : controller.movingTime.value,
                            style: TextStyle(
                              fontSize: 16.0,
                            )))
                      ],
                    ),
                  ),
                ),
              ),
              VerticalSpacing(
                height: 15.0,
              ),
              Center(
                child: CustomBtn(
                  text: "Continue",
                  press: () {
                    Get.to(ScheduleDetails());
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
