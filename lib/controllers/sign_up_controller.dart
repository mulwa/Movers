import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController, nameController;
  late FocusNode emailFocusNode, nameFocusNode;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    nameController = TextEditingController();

    emailFocusNode = FocusNode();
    nameFocusNode = FocusNode();
  }

  String? validateAddress(String value) {
    if (value.isEmpty) {
      return "Address can not be empty";
    }
    return null;
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return "Name cannot be empty";
    }
    return null;
  }

  nameEditingComplete() {
    FocusScope.of(Get.context!).requestFocus(emailFocusNode);
  }
}
