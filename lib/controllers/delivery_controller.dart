import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:movers/models/address_model.dart';

class DeliveryController extends GetxController {
  RxString movingTime = "".obs;
  var pickUpAddress = Address().obs;
  var destinationAddress = Address().obs;
  Rx<PhoneNumber> number = PhoneNumber(isoCode: 'KE').obs;

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
