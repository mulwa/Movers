import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:movers/controllers/map_page_controller.dart';
import 'package:movers/models/address_model.dart';
import 'package:movers/screen/transport_details_page.dart';
import 'package:movers/shared/address_input.dart';
import 'package:movers/shared/custom_btn.dart';
import 'package:movers/shared/shifter_divider.dart';
import 'package:movers/utils/constants.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MapPageController _mapPageController = Get.put(MapPageController());
    return SafeArea(
      child: Scaffold(
          body: Obx(() => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
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
                              subTitle: _mapPageController.fromAddress.isEmpty
                                  ? "Enter from address"
                                  : _mapPageController.pickupAddress.value
                                      .placeFormattedAddress,
                              onPress: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlacePicker(
                                      apiKey: MAPKEY, // Put YOUR OWN KEY here.
                                      onPlacePicked: (result) {
                                        print(result);
                                        Address fromAddress = new Address();
                                        fromAddress.latitude =
                                            result.geometry!.location.lat;
                                        fromAddress.longitude =
                                            result.geometry!.location.lng;
                                        fromAddress.placeFormattedAddress =
                                            result.formattedAddress;
                                        fromAddress.placeName = result.name;
                                        fromAddress.placeId = result.id;
                                        _mapPageController
                                            .updatePickupAddress(fromAddress);

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
                              subTitle: _mapPageController.toAddress.isEmpty
                                  ? "Enter Moving to address"
                                  : _mapPageController.destinationAddress.value
                                      .placeFormattedAddress,
                              onPress: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlacePicker(
                                      apiKey: MAPKEY, // Put YOUR OWN KEY here.
                                      onPlacePicked: (PickResult result) {
                                        Address toAddress = new Address();
                                        toAddress.latitude =
                                            result.geometry!.location.lat;
                                        toAddress.longitude =
                                            result.geometry!.location.lng;
                                        toAddress.placeFormattedAddress =
                                            result.formattedAddress;
                                        toAddress.placeName = result.name;
                                        toAddress.placeId = result.id;

                                        _mapPageController
                                            .updateDestinationAddress(
                                                toAddress);

                                        _mapPageController.getDirection();

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
                    _mapPageController.mapPolyline.length > 0
                        ? Expanded(
                            child: GoogleMap(
                              initialCameraPosition:
                                  _mapPageController.cameraPosition,
                              polylines: _mapPageController.mapPolyline,
                              markers: _mapPageController.markers,
                              circles: _mapPageController.circle,
                              onMapCreated: (GoogleMapController controller) {
                                _mapPageController.mapController?.value =
                                    controller;
                              },
                            ),
                          )
                        : Expanded(child: Center(child: Text("waiting"))),
                    _mapPageController.mapPolyline.length > 0
                        ? CustomBtn(
                            text: "Continue",
                            press: () {
                              Get.to(TransportDetailsPage());
                            },
                          )
                        : Container()
                  ],
                ),
              ))),
    );
  }
}
