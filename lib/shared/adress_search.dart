import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movers/controllers/address_search_controller.dart';
import 'package:movers/shared/prediction_tile.dart';
import 'package:movers/shared/vertical_spacing.dart';

class AddressSearch extends GetView<AddressSearchController> {
  final String title;
  const AddressSearch({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AddressSearchController());
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7))
              ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 24, top: 20, right: 24, bottom: 20),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back)),
                        Center(
                            child: Text('$title location',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w800)))
                      ],
                    ),
                    VerticalSpacing(
                      height: 15.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextField(
                          controller: controller.searchController,
                          decoration: InputDecoration(
                            hintText: 'Location Address',
                            fillColor: Colors.white,
                            isDense: true,
                            contentPadding:
                                EdgeInsets.only(left: 10, top: 8, bottom: 8),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 5.0),
                            ),
                          ),
                          onChanged: (val) {
                            controller.searchPlace(val);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => (controller.destinationPrediction.length > 0)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8),
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return PridictionTile(
                              prediction:
                                  controller.destinationPrediction[index],
                            );
                          },
                          separatorBuilder: (BuildContext context, index) {
                            return Divider();
                          },
                          itemCount: controller.destinationPrediction.length),
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
