import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:movers/models/address_model.dart';
import 'package:movers/models/direction_details.dart';
import 'package:movers/utils/helper_methods.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

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

  var tripDirectionDetails = DirectionDetails().obs;

  RxList<LatLng> polylineCordinates = RxList<LatLng>([]);

  var mapPolyline = Set<Polyline>().obs;
  var markers = Set<Marker>().obs;
  var circle = Set<Circle>().obs;

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

  Future<void> getDirection() async {
    print("hello");

    var pickLatLng =
        LatLng(pickupAddress.value.latitude!, pickupAddress.value.longitude!);
    var destinationLatLng = LatLng(destinationAddress.value.latitude!,
        destinationAddress.value.longitude!);

    var details =
        await HelperMethods.getDirectionDetails(pickLatLng, destinationLatLng);
    print(details?.encodedPoints);

    tripDirectionDetails.value = details!;

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> results =
        polylinePoints.decodePolyline(details.encodedPoints!);
    polylineCordinates.clear();
    if (results.isNotEmpty) {
      results.forEach((PointLatLng points) {
        polylineCordinates.add(LatLng(points.latitude, points.longitude));
      });
    }
    mapPolyline.clear();

    Polyline polyline = Polyline(
        polylineId: PolylineId('polyid'),
        color: Color.fromARGB(255, 95, 109, 237),
        points: polylineCordinates,
        jointType: JointType.round,
        width: 4,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true);

    mapPolyline.add(polyline);

    // make polyline to fit into the map
    LatLngBounds bounds;
    if (pickLatLng.latitude > destinationLatLng.latitude &&
        pickLatLng.longitude > destinationLatLng.longitude) {
      bounds =
          LatLngBounds(southwest: destinationLatLng, northeast: pickLatLng);
    } else if (pickLatLng.longitude > destinationLatLng.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(pickLatLng.latitude, destinationLatLng.longitude),
          northeast: LatLng(destinationLatLng.latitude, pickLatLng.longitude));
    } else if (pickLatLng.latitude > destinationLatLng.latitude) {
      bounds = LatLngBounds(
          southwest: LatLng(destinationLatLng.latitude, pickLatLng.longitude),
          northeast: LatLng(pickLatLng.latitude, destinationLatLng.longitude));
    } else {
      bounds =
          LatLngBounds(southwest: pickLatLng, northeast: destinationLatLng);
    }
    mapController?.value
        .animateCamera(CameraUpdate.newLatLngBounds(bounds, 70));
    Marker pickUpMarker = Marker(
        markerId: MarkerId('pickup'),
        position: pickLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(
            title: pickupAddress.value.placeName, snippet: "My Location"));

    Marker destinationMarker = Marker(
        markerId: MarkerId('destination'),
        position: destinationLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(
            title: destinationAddress.value.placeName, snippet: "Destination"));

    markers.add(pickUpMarker);
    markers.add(destinationMarker);

    Circle pickUpCircle = Circle(
        circleId: CircleId('pickup'),
        strokeColor: Colors.green,
        strokeWidth: 3,
        radius: 12,
        center: pickLatLng,
        fillColor: Colors.green);

    Circle destinationCircle = Circle(
        circleId: CircleId('destination'),
        strokeColor: Colors.cyanAccent,
        strokeWidth: 3,
        radius: 12,
        center: destinationLatLng,
        fillColor: Colors.amberAccent);

    circle.add(pickUpCircle);
    circle.add(destinationCircle);

    update();
  }
}
