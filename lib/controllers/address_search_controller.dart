import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movers/models/place_prediction.dart';
import 'package:movers/utils/constants.dart';
import 'package:movers/utils/request_helper.dart';

class AddressSearchController extends GetxController {
  var destinationPrediction = [].obs;
  late TextEditingController searchController;

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
  }

  void searchPlace(String placeName) async {
    var url = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$MAPKEY&sessiontoken=1234567890&components=country:ke");

    if (placeName.length > 2) {
      var res = await RequestHelper.getRequest(url);
      if (res == 'failed') {
        print('Place search failed Failed');
        return;
      }
      if (res['status'] == 'OK') {
        var predictionJson = res['predictions'];

        var predictionList = (predictionJson as List)
            .map((e) => Prediction.fromJson(e))
            .toList();

        destinationPrediction.value = predictionList;
      }
      update();
    }
  }
}
