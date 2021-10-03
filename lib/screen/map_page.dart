import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:movers/controllers/map_page_controller.dart';
import 'package:movers/shared/address_input.dart';
import 'package:movers/shared/shifter_divider.dart';
import 'package:movers/utils/constants.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MapPageController _mapPageController = Get.put(MapPageController());
    return SafeArea(
      child: Scaffold(
        body: GetBuilder(
            init: MapPageController(),
            builder: (mapPageController) {
              return Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: _mapPageController.kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _mapPageController.mapController = controller;
                    },
                  ),
                  Positioned(
                    child: Container(
                      // height: ,
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5.0,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7))
                      ]),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 24, top: 30, right: 24, bottom: 30),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AddressInput(
                              icon: Icons.pin_drop_outlined,
                              title: "From",
                              subTitle: "Moving from address",
                              onPress: () {
                                print('from pressed');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlacePicker(
                                      apiKey: MAPKEY, // Put YOUR OWN KEY here.
                                      onPlacePicked: (result) {
                                        print(result);
                                        Navigator.of(context).pop();
                                      },
                                      initialPosition: LatLng(
                                          _mapPageController.position.latitude,
                                          _mapPageController
                                              .position.longitude),

                                      useCurrentLocation: true,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            ShiftDivider(),
                            SizedBox(
                              height: 16,
                            ),
                            AddressInput(
                              icon: Icons.pin_drop_outlined,
                              title: "To",
                              subTitle: "Moving to address",
                              onPress: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlacePicker(
                                      apiKey: MAPKEY, // Put YOUR OWN KEY here.
                                      onPlacePicked: (PickResult result) {
                                        print(result.geometry!.location.lat);
                                        print(result.geometry!.location.lng);
                                        print(result.formattedAddress);
                                        Navigator.of(context).pop();
                                      },
                                      initialPosition: LatLng(
                                          _mapPageController.position.latitude,
                                          _mapPageController
                                              .position.longitude),

                                      useCurrentLocation: true,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            ShiftDivider(),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
