import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movers/screen/map_page.dart';

class SignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController, nameController;
  late FocusNode emailFocusNode, nameFocusNode;
  late CollectionReference usersRef;
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    nameController = TextEditingController();

    usersRef = FirebaseFirestore.instance.collection('users');

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

  void createUser({required String userId, required String phoneNumber}) {
    loading.value = true;
    usersRef.doc(userId).set({
      "name": nameController.text,
      "emailAddress": emailController.text,
      "phoneNumber": phoneNumber,
    }).then((_) {
      loading.value = false;
      Get.snackbar("Success", "User details Updated Successfully");
      Get.to(MapPage());
    }, onError: (error) {
      loading.value = false;
      print(error);
    });
  }
}
