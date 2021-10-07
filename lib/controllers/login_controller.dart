import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:movers/screen/authentication/sign_up.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController phoneNumberController, optController;
  RxString initialCountry = 'KE'.obs;
  RxString currentOtpText = ''.obs;
  Rx<PhoneNumber> number = PhoneNumber(isoCode: 'KE').obs;
  StreamController<ErrorAnimationType>? errorController;

  @override
  void onInit() {
    super.onInit();
    phoneNumberController = TextEditingController();
    optController = TextEditingController();
    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  void onClose() {
    super.onClose();
    phoneNumberController.dispose();
    optController.dispose();
  }

  void verifyOpt() {
    print('Verifying otp:' + currentOtpText.value);
    if (currentOtpText.value.length != 4 || currentOtpText.value != '1234') {
      errorController!.add(ErrorAnimationType.shake);
    } else {
      Get.to(SignUpPage());
    }
  }
}
