// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:movers/models/direction_details.dart';
// import 'package:movers/utils/helper_methods.dart';

// class MapProvider extends ChangeNotifier {
//   List<LatLng> polylineCordinates = [];
//   Set<Polyline> _polyline = {};
//   Set<Marker> _markers = {};
//   Set<Circle> _circle = {};
//   late DirectionDetails tripDirectionDetails;

//   Future<void> getDirection() async {
//     print("hello");

//     var pickLatLng =
//         LatLng(pickupAddress.value.latitude!, pickupAddress.value.longitude!);
//     var destinationLatLng = LatLng(destinationAddress.value.latitude!,
//         destinationAddress.value.longitude!);

//     var details =
//         await HelperMethods.getDirectionDetails(pickLatLng, destinationLatLng);
//     print(details?.encodedPoints);

//     tripDirectionDetails = details!;

//     PolylinePoints polylinePoints = PolylinePoints();
//     List<PointLatLng> results =
//         polylinePoints.decodePolyline(details.encodedPoints!);
//     polylineCordinates.clear();
//     if (results.isNotEmpty) {
//       results.forEach((PointLatLng points) {
//         polylineCordinates.add(LatLng(points.latitude, points.longitude));
//       });
//     }
//     _mapPolyline.clear();

//     Polyline polyline = Polyline(
//         polylineId: PolylineId('polyid'),
//         color: Color.fromARGB(255, 95, 109, 237),
//         points: polylineCordinates,
//         jointType: JointType.round,
//         width: 4,
//         startCap: Cap.roundCap,
//         endCap: Cap.roundCap,
//         geodesic: true);

//     _mapPolyline.add(polyline);

//     // make polyline to fit into the map
//     LatLngBounds bounds;
//     if (pickLatLng.latitude > destinationLatLng.latitude &&
//         pickLatLng.longitude > destinationLatLng.longitude) {
//       bounds =
//           LatLngBounds(southwest: destinationLatLng, northeast: pickLatLng);
//     } else if (pickLatLng.longitude > destinationLatLng.longitude) {
//       bounds = LatLngBounds(
//           southwest: LatLng(pickLatLng.latitude, destinationLatLng.longitude),
//           northeast: LatLng(destinationLatLng.latitude, pickLatLng.longitude));
//     } else if (pickLatLng.latitude > destinationLatLng.latitude) {
//       bounds = LatLngBounds(
//           southwest: LatLng(destinationLatLng.latitude, pickLatLng.longitude),
//           northeast: LatLng(pickLatLng.latitude, destinationLatLng.longitude));
//     } else {
//       bounds =
//           LatLngBounds(southwest: pickLatLng, northeast: destinationLatLng);
//     }
//     mapController?.value
//         .animateCamera(CameraUpdate.newLatLngBounds(bounds, 70));
//     Marker pickUpMarker = Marker(
//         markerId: MarkerId('pickup'),
//         position: pickLatLng,
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//         infoWindow: InfoWindow(
//             title: pickupAddress.value.placeName, snippet: "My Location"));

//     Marker destinationMarker = Marker(
//         markerId: MarkerId('destination'),
//         position: destinationLatLng,
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//         infoWindow: InfoWindow(
//             title: destinationAddress.value.placeName, snippet: "Destination"));

//     markers.value.add(pickUpMarker);
//     markers.value.add(destinationMarker);

//     Circle pickUpCircle = Circle(
//         circleId: CircleId('pickup'),
//         strokeColor: Colors.green,
//         strokeWidth: 3,
//         radius: 12,
//         center: pickLatLng,
//         fillColor: Colors.green);

//     Circle destinationCircle = Circle(
//         circleId: CircleId('destination'),
//         strokeColor: Colors.cyanAccent,
//         strokeWidth: 3,
//         radius: 12,
//         center: destinationLatLng,
//         fillColor: Colors.amberAccent);

//     _circle.add(pickUpCircle);
//     _circle.add(destinationCircle);

//     notifyListeners();
//   }
// }
