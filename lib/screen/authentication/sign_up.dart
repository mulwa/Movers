import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movers/controllers/sign_up_controller.dart';
import 'package:movers/screen/authentication/login.dart';
import 'package:movers/shared/app_card.dart';
import 'package:movers/shared/custom_btn.dart';
import 'package:movers/shared/custom_input_decoration.dart';
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
      textInputAction: TextInputAction.next,
      onEditingComplete: controller.emailEditingComplete,
      validator: (value) {
        return controller.validateAddress(value!);
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: inputBackground,
          filled: true,
          hintText: "Password",
          suffixIcon: IconButton(
              icon: Icon(
                controller.passwordVisible.value
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
              onPressed: () {
                controller.changePasswordVisibility();
              })),
      obscureText: controller.passwordVisible.value ? true : false,
      controller: controller.passwordController,
      focusNode: controller.passwordFocusNode,
      textInputAction: TextInputAction.done,
      onEditingComplete: () {},
      validator: (String? value) {
        return controller.validatePassword(value!);
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
                      Text("Sign Up",
                          style: TextStyle(color: textColor, fontSize: 20.0)),
                      VerticalSpacing(
                        height: 15,
                      ),
                      _buildEmailField(),
                      VerticalSpacing(),
                      _buildPasswordField(),
                      VerticalSpacing(),
                      CustomBtn(
                        text: "create account",
                        press: () async {},
                      ),
                      VerticalSpacing(),
                      Center(
                        child: RichText(
                          text: TextSpan(
                              text: "Already have an account?",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                              children: <TextSpan>[
                                TextSpan(
                                    text: " Login",
                                    style: TextStyle(
                                        color: colorPrimaryDark,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.to(LoginPage());
                                      })
                              ]),
                        ),
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
