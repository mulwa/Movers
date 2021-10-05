import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';

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
        minTime: DateTime.now(),
        maxTime: DateTime.now().add(Duration(
          days: 90,
        )), onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      print('confirm $date');
      movingDate.value = date.toString();
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  setMovingTime() {
    DatePicker.showTimePicker(Get.context!,
        showTitleActions: true, showSecondsColumn: false, onChanged: (date) {
      print('change $date in time zone ' +
          date.timeZoneOffset.inHours.toString());
    }, onConfirm: (date) {
      print('confirm $date');
      movingTime.value = date.toString();
    }, currentTime: DateTime.now());
  }
}
