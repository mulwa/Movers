import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:movers/models/address_model.dart';
import 'package:movers/models/instruction_model.dart';

class DeliveryController extends GetxController {
  RxString movingTime = "".obs;
  Rx<Address> pickUpAddress = Address().obs;
  Rx<Address> destinationAddress = Address().obs;
  Rx<PhoneNumber> number = PhoneNumber(isoCode: 'KE').obs;
  Rx<Instruction> pickUpInstructions = Instruction().obs;
  Rx<Instruction> dropOffInstructions = Instruction().obs;

  late TextEditingController phoneNumberController, instructionController;
  @override
  onInit() {
    phoneNumberController = TextEditingController();
    instructionController = TextEditingController();
    super.onInit();
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
    update();
  }

  addPickUpInstructions(Instruction instruction) {
    pickUpInstructions.value = instruction;
    debugPrint(instruction.instructions);
    clearInput();
    print(instruction.instructions);
    update();
  }

  addOffInstructions(Instruction instruction) {
    dropOffInstructions.value = instruction;
    debugPrint(instruction.instructions);
    clearInput();
    print(instruction.instructions);
    update();
  }

  clearInput() {
    this.phoneNumberController.text = "";
    this.instructionController.text = "";
  }
}
