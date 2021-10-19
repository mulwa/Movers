import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DeliveryController extends GetxController {
  RxString movingTime = "".obs;

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
    update();
  }
}
