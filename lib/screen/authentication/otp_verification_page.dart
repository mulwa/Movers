import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movers/controllers/login_controller.dart';
import 'package:movers/shared/custom_btn.dart';
import 'package:movers/shared/progressDialog.dart';
import 'package:movers/shared/styles.dart';
import 'package:movers/shared/vertical_spacing.dart';
import 'package:movers/utils/constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerification extends GetView<LoginController> {
  const OtpVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    controller.login();
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => Container(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 10),
            child: controller.verifyingOtp.value
                ? ProgressDialog(
                    status: "Verifying Otp",
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Phone Number Verification',
                        style: mediumTitleStyle,
                        textAlign: TextAlign.center,
                      ),
                      VerticalSpacing(),
                      RichText(
                        text: TextSpan(
                            text: "Enter the code sent to ",
                            children: [
                              TextSpan(
                                  text: "${controller.phoneNumber.value}",
                                  style: mediumTitleStyle),
                            ],
                            style: greyTitleStyle),
                        textAlign: TextAlign.center,
                      ),
                      VerticalSpacing(),
                      PinCodeTextField(
                          appContext: context,
                          length: 6,
                          enablePinAutofill: true,
                          showCursor: false,
                          controller: controller.optController,
                          errorAnimationController: controller.errorController,
                          keyboardType: TextInputType.number,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            inactiveColor: colorPrimary,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: Colors.white,
                          ),
                          onChanged: (value) {
                            controller.currentOtpText.value = value;
                            print(value);
                          }),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: CustomBtn(
                            text: "Verify",
                            press: () {
                              controller.verifyOpt(
                                  controller.myVerificationId.value,
                                  controller.currentOtpText.value);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
