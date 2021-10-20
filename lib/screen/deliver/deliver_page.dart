import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:movers/controllers/delivery_controller.dart';
import 'package:movers/models/address_model.dart';
import 'package:movers/shared/adress_search.dart';
import 'package:movers/shared/custom_btn.dart';
import 'package:movers/shared/custom_input_decoration.dart';
import 'package:movers/shared/shifter_divider.dart';
import 'package:movers/shared/styles.dart';
import 'package:movers/shared/vertical_spacing.dart';
import 'package:movers/utils/constants.dart';

class DeliverPage extends GetView<DeliveryController> {
  const DeliverPage({Key? key}) : super(key: key);

  Widget _packageDesc() {
    return TextField(
      decoration: CustomInputDecoration(),
      keyboardType: TextInputType.multiline,
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(DeliveryController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Delivery request"),
        ),
        body: Container(
          margin: EdgeInsets.all(16.0),
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  VerticalSpacing(),
                  Text(
                    "What do you want to be delivered",
                    style: GoogleFonts.raleway(
                        fontSize: 16.0, fontWeight: FontWeight.w400),
                  ),
                  VerticalSpacing(),
                  _packageDesc(),
                  VerticalSpacing(),
                  ShiftDivider(),
                  VerticalSpacing(),
                  Obx(
                    () => IconTitle(
                      icon: Icons.place,
                      title: "Package Pick Up address",
                      subTitle: controller.pickUpAddress.value.placeName == null
                          ? ""
                          : controller.pickUpAddress.value.placeName,
                      press: () async {
                        Address pickUpAddress = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddressSearch(
                                      title: "Pick Up",
                                    )));
                        debugPrint(
                            'Hey :: ${pickUpAddress.longitude} : ${pickUpAddress.placeName}');
                        controller.pickUpAddress.value = pickUpAddress;
                      },
                    ),
                  ),
                  VerticalSpacing(),
                  ShiftDivider(),
                  VerticalSpacing(),
                  Obx(
                    () => IconTitle(
                      icon: Icons.place_sharp,
                      title:
                          "Where would you like your package to be delivered",
                      subTitle:
                          controller.destinationAddress.value.placeName == null
                              ? ""
                              : controller.destinationAddress.value.placeName,
                      press: () async {
                        var dropOffAddress = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddressSearch(
                                      title: "Drop off",
                                    )));
                        controller.destinationAddress.value = dropOffAddress;
                      },
                    ),
                  ),
                  VerticalSpacing(),
                  ShiftDivider(),
                  VerticalSpacing(),
                  Obx(
                    () => IconTitle(
                        icon: Icons.schedule,
                        title: "Pick up time for your package",
                        subTitle: controller.movingTime.value.isEmpty
                            ? ""
                            : controller.movingTime.value,
                        press: () {
                          controller.setMovingTime();
                          debugPrint("open time picker");
                        }),
                  ),
                  VerticalSpacing(),
                  ShiftDivider(),
                  VerticalSpacing(),
                  Obx(
                    () => controller.pickUpAddress.value.placeName != null
                        ? IconTitle(
                            icon: Icons.note_add,
                            title:
                                "Pick up instruction at ${controller.pickUpAddress.value.placeName}",
                            subTitle: "Call 0707200314",
                            press: () {
                              Get.bottomSheet(ExtraDetails(
                                type: 'pick',
                              ));

                              debugPrint('open pick up instruction ');
                            },
                          )
                        : Container(),
                  ),
                  VerticalSpacing(),
                  ShiftDivider(),
                  VerticalSpacing(),
                  Obx(
                    () => controller.destinationAddress.value.placeName != null
                        ? IconTitle(
                            icon: Icons.note_add,
                            title:
                                "Drop Off Instructions at ${controller.destinationAddress.value.placeName}",
                            subTitle: "I will Be their",
                            press: () {
                              Get.bottomSheet(ExtraDetails(
                                type: 'drop',
                              ));

                              debugPrint('open pick up address');
                            },
                          )
                        : Container(),
                  )
                ],
              ),
              VerticalSpacing(),
              ShiftDivider(),
              VerticalSpacing(
                height: 15.0,
              ),
              CustomBtn(
                text: "Submit your order",
                press: () {
                  debugPrint("ordering");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ExtraDetails extends GetView<DeliveryController> {
  final String type;
  const ExtraDetails({
    required this.type,
    Key? key,
  }) : super(key: key);

  Widget _buildDescField() {
    return TextField(
      maxLines: 4,
      decoration: CustomInputDecoration(
        labelText: 'Instructions',
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _phoneNumber() {
    return InternationalPhoneNumberInput(
      // inputBorder: OutlineInputBorder(),
      inputDecoration: InputDecoration(border: OutlineInputBorder()),
      initialValue: controller.number.value,
      // textFieldController: controller.phoneNumberController,
      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      ),
      countries: ["KE"],
      onInputChanged: (PhoneNumber value) {
        print(value.phoneNumber);
        // controller.phoneNumber.value = value.phoneNumber!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      // height: MediaQuery.of(context).size.height / 2,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VerticalSpacing(),
          Obx(
            () => Text(
              type == 'pick'
                  ? "Pick up instruction at ${controller.pickUpAddress.value.placeName}"
                  : "Drop Off instruction at ${controller.destinationAddress.value.placeName}",
              style: greyTitleStyle,
            ),
          ),
          VerticalSpacing(),
          _buildDescField(),
          VerticalSpacing(),
          Text(
            "Contact Person",
            style: greyTitleStyle,
          ),
          VerticalSpacing(),
          _phoneNumber(),
          VerticalSpacing(),
          CustomBtn(
            text: "Add",
            press: () {
              print("Hey");
            },
          )
        ],
      ),
    );
  }
}

class IconTitle extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final String? subTitle;
  final VoidCallback? press;

  const IconTitle({
    Key? key,
    this.icon,
    this.title,
    this.press,
    this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: colorOrange,
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: GoogleFonts.raleway(
                      fontSize: 16.0, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  subTitle!,
                  style: GoogleFonts.raleway(
                      textStyle: TextStyle(fontSize: 18.0, color: Colors.grey)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
