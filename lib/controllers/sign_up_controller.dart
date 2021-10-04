import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController, passwordController;
  late FocusNode emailFocusNode, passwordFocusNode;
  Rx<bool> passwordVisible = true.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  String? validateAddress(String value) {
    if (value.isEmpty) {
      return "Address can not be empty";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Password can not be empty";
    }
    return null;
  }

  changePasswordVisibility() {
    this.passwordVisible.value = !this.passwordVisible.value;
    print(this.passwordVisible.value);
  }

  emailEditingComplete() {
    FocusScope.of(Get.context!).requestFocus(passwordFocusNode);
  }
}
