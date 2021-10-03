import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapPageController extends GetxController {
  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(-1.129154, 36.995559),
    zoom: 14.4746,
  );
  late GoogleMapController mapController;

  late CameraPosition cameraPosition;
  late Position position;

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
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
}
