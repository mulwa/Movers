import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movers/models/direction_details.dart';
import 'package:movers/utils/request_helper.dart';
import 'package:movers/utils/constants.dart';

class HelperMethods {
  static Future<DirectionDetails?> getDirectionDetails(
      LatLng startPosition, LatLng endPosition) async {
    print("here");
    print("Lat ${startPosition.longitude}");
    print("Long ${endPosition.longitude}");
    DirectionDetails directionDetails = new DirectionDetails();
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=$MAPKEY');

    try {
      var res = await RequestHelper.getRequest(url);
      print(res);
      if (res == 'failed') {
        return null;
      }

      directionDetails.durationText =
          res['routes'][0]['legs'][0]['duration']['text'];
      directionDetails.durationValue =
          res['routes'][0]['legs'][0]['duration']['value'];
      directionDetails.distanceText =
          res['routes'][0]['legs'][0]['distance']['text'];
      directionDetails.distanceValue =
          res['routes'][0]['legs'][0]['distance']['value'];
      directionDetails.encodedPoints =
          res['routes'][0]['overview_polyline']['points'];
    } catch (e) {
      print(e);
      return null;
    }
    return directionDetails;
  }

  static int fareEstimate(DirectionDetails details) {
    // default fare = Ksh 100
    // per km ksh 30
    //  per min Ksh 20

    double defaultFare = 50.0;
    double distanceFare = (details.distanceValue! / 1000) * 20;
    double timeFare = (details.durationValue! / 60) * 10;

    double totalFare = defaultFare + distanceFare + timeFare;
    return totalFare.truncate();
  }
}
