import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movers/controllers/sign_up_controller.dart';
import 'package:movers/screen/authentication/login.dart';
import 'package:movers/shared/app_card.dart';
import 'package:movers/shared/custom_btn.dart';
import 'package:movers/shared/custom_input_decoration.dart';
import 'package:movers/shared/styles.dart';
import 'package:movers/shared/vertical_spacing.dart';
import 'package:movers/utils/constants.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({Key? key}) : super(key: key);

  Widget _buildEmailField() {
    return TextFormField(
      decoration: CustomInputDecoration(
        labelText: 'Email Address',
      ),
      keyboardType: TextInputType.emailAddress,
      controller: controller.emailController,
      focusNode: controller.emailFocusNode,
      textInputAction: TextInputAction.done,
      validator: (value) {
        return controller.validateAddress(value!);
      },
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: CustomInputDecoration(
        labelText: 'Full Name',
      ),
      keyboardType: TextInputType.emailAddress,
      controller: controller.nameController,
      focusNode: controller.nameFocusNode,
      textInputAction: TextInputAction.next,
      onEditingComplete: controller.nameEditingComplete,
      validator: (value) {
        return controller.validateName(value!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 150.0, right: 10.0, left: 10.0),
              height: MediaQuery.of(context).size.height,
              child: AppCard(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: <Widget>[
                      VerticalSpacing(
                        height: 15,
                      ),
                      Center(
                          child: Text(
                        "Please provide the following information",
                        style: mediumTitleStyle,
                        textAlign: TextAlign.center,
                      )),
                      VerticalSpacing(),
                      _buildNameField(),
                      VerticalSpacing(),
                      _buildEmailField(),
                      VerticalSpacing(),
                      CustomBtn(
                        text: "Save",
                        press: () async {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
