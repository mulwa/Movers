import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:movers/models/address_model.dart';

class MapPageController extends GetxController {
  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(-1.129154, 36.995559),
    zoom: 14.4746,
  );
  Rx<GoogleMapController>? mapController;

  late CameraPosition cameraPosition;
  late Position position;

  var pickupAddress = Address().obs;
  var fromAddress = ''.obs;
  var destinationAddress = Address().obs;
  var toAddress = ''.obs;

  @override
  void onInit() {
    setUpPositionLocator();
    super.onInit();
  }

  void setUpPositionLocator() async {
    print("current location called");
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    LatLng currentLatLng = LatLng(position.latitude, position.longitude);
    cameraPosition = new CameraPosition(target: currentLatLng, zoom: 14);
    mapController?.value
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void updatePickupAddress(Address pickup) {
    pickupAddress.value = pickup;
    fromAddress.value = pickup.placeFormattedAddress!;
    update();
  }

  void updateDestinationAddress(Address address) {
    destinationAddress.value = address;
    toAddress.value = address.placeFormattedAddress!;
    update();
  }
}
