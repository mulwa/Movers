import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movers/controllers/login_controller.dart';
import 'package:movers/screen/authentication/sign_up.dart';
import 'package:movers/shared/app_card.dart';
import 'package:movers/shared/custom_btn.dart';
import 'package:movers/shared/custom_input_decoration.dart';
import 'package:movers/shared/styles.dart';
import 'package:movers/shared/vertical_spacing.dart';
import 'package:movers/utils/constants.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

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
    return Obx(
      () => TextFormField(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return SafeArea(
      child: Scaffold(
        body: ListView(children: [
          Text(
            "Enter your number",
            style: mediumTitleStyle,
          ),
          VerticalSpacing(),
          Text("We will sent a code to verify you mobile number"),
          Positioned(
              top: 100.0,
              child: Container(
                margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 30),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width - 32.0,
                child: AppCard(
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: <Widget>[
                        VerticalSpacing(),
                        Text("Sign In", style: TextStyle(fontSize: 18)),
                        VerticalSpacing(
                          height: 20,
                        ),
                        _buildEmailField(),
                        VerticalSpacing(),
                        _buildPasswordField(),
                        VerticalSpacing(),
                        CustomBtn(
                            text: "Login",
                            press: () async {
                              return;
                            }),
                        VerticalSpacing(),
                        Center(
                          child: RichText(
                            text: TextSpan(
                                text: "New User ? ",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.0),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: " Create an account",
                                      style: TextStyle(
                                          color: colorPrimaryDark,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w400),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.to(SignUpPage());
                                          // Navigator.of(context).push(
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             SignUpPage()));
                                        })
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}
