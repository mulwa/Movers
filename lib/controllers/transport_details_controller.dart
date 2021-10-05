import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movers/models/direction_details.dart';

class TransportDetailsController extends GetxController {
  var selectedVehicle = "".obs;
  List<String> vehicleType = ["Pick Up", "Small Truck", "Large Truck"];
  RxString movingDate = "".obs;
  RxString movingTime = "".obs;

  void setVehicleType(String value) {
    selectedVehicle = value.obs;
    update();
  }

  setMovingDate() {
    DatePicker.showDatePicker(Get.context!,
        showTitleActions: true,
        minTime: DateTime.now().add(Duration(days: 1)),
        maxTime: DateTime.now().add(Duration(
          days: 90,
        )), onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      print('confirm $date');
      var formatter = new DateFormat('dd-MM-yyyy');
      String formattedDate = formatter.format(date);
      movingDate.value = formattedDate;
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  setMovingTime() {
    DatePicker.showTimePicker(Get.context!,
        showTitleActions: true, showSecondsColumn: false, onChanged: (date) {
      print('change $date in time zone ' +
          date.timeZoneOffset.inHours.toString());
    }, onConfirm: (date) {
      print('confirm $date');
      var formatter = new DateFormat('dd-MM-yyyy');
      String formattedTime = DateFormat('kk:mm:a').format(date);
      movingTime.value = formattedTime;
    }, currentTime: DateTime.now());
  }

  int fareEstimate(DirectionDetails details) {
    double defaultFare = 50.0;
    double distanceFare = (details.distanceValue! / 1000) * 20;
    double timeFare = (details.durationValue! / 60) * 10;

    double totalFare = defaultFare + distanceFare + timeFare;
    return totalFare.truncate();
  }
}
