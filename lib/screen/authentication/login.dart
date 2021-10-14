import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movers/controllers/login_controller.dart';
import 'package:movers/screen/authentication/otp_verification_page.dart';
import 'package:movers/screen/authentication/sign_up.dart';
import 'package:movers/shared/app_card.dart';
import 'package:movers/shared/custom_btn.dart';
import 'package:movers/shared/custom_input_decoration.dart';
import 'package:movers/shared/styles.dart';
import 'package:movers/shared/vertical_spacing.dart';
import 'package:movers/utils/constants.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 5.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Enter your number",
              style: mediumTitleStyle,
            ),
            VerticalSpacing(),
            Text(
              "We will sent a code to verify you mobile number",
              style: greyTitleStyle,
            ),
            VerticalSpacing(),
            Obx(
              () => Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InternationalPhoneNumberInput(
                    // inputBorder: OutlineInputBorder(),
                    inputDecoration:
                        InputDecoration(border: OutlineInputBorder()),
                    initialValue: controller.number.value,
                    textFieldController: controller.phoneNumberController,
                    selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    ),
                    // countries: ["KE"],
                    onInputChanged: (PhoneNumber value) {
                      print(value.phoneNumber);
                      controller.phoneNumber.value = value.phoneNumber!;
                    },
                  ),
                ),
              ),
            ),
            VerticalSpacing(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomBtn(
                    text: "Continue",
                    press: () async {
                      // controller.login();
                      Get.to(OtpVerification());
                    }),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
