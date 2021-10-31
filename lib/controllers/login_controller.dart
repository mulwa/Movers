import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:movers/models/user_model.dart';
import 'package:movers/screen/authentication/login.dart';
import 'package:movers/screen/authentication/otp_verification_page.dart';
import 'package:movers/screen/authentication/sign_up.dart';
import 'package:movers/screen/landing_page.dart';
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
  late CollectionReference usersRef;
  RxBool verifyingOtp = false.obs;

  Rx<UserModel> userModel = UserModel().obs;
  late Rx<User?> firebaseUser;

  @override
  void onInit() {
    super.onInit();
    phoneNumberController = TextEditingController();
    optController = TextEditingController();
    usersRef = FirebaseFirestore.instance.collection('users');
    errorController = StreamController<ErrorAnimationType>();
    _auth = FirebaseAuth.instance;
  }

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginPage());
    } else {
      _getUser(user.uid);
      Get.offAll(() => LandingPage());
    }
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
    await _auth.signInWithCredential(credential).then((value) async {
      User? user = value.user;
      print("User Id ${user?.uid} ");
      if (user != null) {
        DocumentSnapshot userSnapshot = await usersRef.doc(user.uid).get();
        if (userSnapshot.exists) {
          print("User Exists continue to booking details");
          _getUser(user.uid);
          Get.to(LandingPage());
        } else {
          print("User don't exist Go to Add user Details");
          Get.to(SignUpPage(
            uid: user.uid,
            phoneNumber: this.phoneNumber.value,
          ));
        }
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

  // _onCodeTimeout(String timeout) {
  //   return null;
  // }

  verifyOpt(String verificationId, String code) async {
    verifyingOtp.value = true;
    print("myVerificationId:::: ${myVerificationId.value}");
    print("OTP::: ${otpCode.value}");
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: myVerificationId.value, smsCode: otpCode.value);

    try {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        User? user = value.user;
        debugPrint("User Id ${user?.uid} ");
        if (user != null) {
          DocumentSnapshot userSnapshot = await usersRef.doc(user.uid).get();
          if (userSnapshot.exists) {
            debugPrint("User Exists continue to booking details");
            _getUser(user.uid);
            Get.to(LandingPage());
          } else {
            debugPrint("User don't exist Go to Add user Details");
            Get.to(SignUpPage(
              uid: user.uid,
              phoneNumber: this.phoneNumber.value,
            ));
          }
        } else {
          debugPrint("User is NUll");
        }
      });
      verifyingOtp.value = false;
      Get.snackbar("Success", "Logged In successfully");
      // _getUser(credential.providerId);
      Get.to(LandingPage());
    } on FirebaseAuthException catch (e) {
      verifyingOtp.value = false;
      print("${e.message}");
      print("Error::::$e");
      Get.snackbar("Error", "${e.message}");
    }
  }

  _getUser(String userId) async {
    userModel.value = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((doc) => UserModel.fromSnapshot(doc));
  }

  void signOut() async {
    await _auth.signOut();
  }
}
