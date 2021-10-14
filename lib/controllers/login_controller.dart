import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:movers/screen/authentication/otp_verification_page.dart';
import 'package:movers/screen/authentication/sign_up.dart';
import 'package:movers/screen/map_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController phoneNumberController, optController;
  RxString initialCountry = 'KE'.obs;
  RxString currentOtpText = ''.obs;
  Rx<PhoneNumber> number = PhoneNumber(isoCode: 'KE').obs;
  StreamController<ErrorAnimationType>? errorController;
  late final FirebaseAuth _auth;
  RxString otpCode = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString myVerificationId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    phoneNumberController = TextEditingController();
    optController = TextEditingController();
    errorController = StreamController<ErrorAnimationType>();
    _auth = FirebaseAuth.instance;
  }

  @override
  void onClose() {
    super.onClose();
    phoneNumberController.dispose();
    optController.dispose();
  }

  Future<void> login() async {
    print("Login $phoneNumber");
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber.value,
        verificationCompleted: onVerificationCompleted,
        verificationFailed: onVerificationFailed,
        codeSent: onCodeSent,
        codeAutoRetrievalTimeout: (String verificationId) {
          myVerificationId.value = verificationId;
        },
        timeout: Duration(seconds: 60));
  }

  onVerificationCompleted(PhoneAuthCredential credential) async {
    print("verification completed ${credential.smsCode}");
    await _auth.signInWithCredential(credential).then((value) {
      User? user = value.user;
      print("User Id ${user?.uid} ");
      if (user != null) {
        Get.to(MapPage());
      } else {
        print("User is NUll");
      }
    }, onError: (error) {
      print("error $error");
    });
  }

  onVerificationFailed(FirebaseAuthException exception) {
    print("On verification failed $exception");
    if (exception.code == 'invalid-phone-number') {
      print("The phone number entered is invalid!");
    }
  }

  onCodeSent(String verificationId, int? forceResendingToken) {
    print("On Code Sent $verificationId");
    myVerificationId.value = verificationId;
    print("myVerificationId:::: ${myVerificationId.value}");
    print("code sent");
  }

  _onCodeTimeout(String timeout) {
    return null;
  }

  verifyOpt(String verificationId, String code) async {
    print("myVerificationId:::: ${myVerificationId.value}");
    print("OTP::: ${otpCode.value}");
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: myVerificationId.value, smsCode: otpCode.value);

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.snackbar("Success", "Logged In successfully");
      Get.to(MapPage());
    } on FirebaseAuthException catch (e) {
      print("${e.message}");
      print("Error::::$e");
      Get.snackbar("Error", "${e.message}");
    }
  }
}
