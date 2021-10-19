import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movers/shared/custom_btn.dart';
import 'package:movers/shared/custom_input_decoration.dart';
import 'package:movers/shared/shifter_divider.dart';
import 'package:movers/shared/styles.dart';
import 'package:movers/shared/vertical_spacing.dart';
import 'package:movers/utils/constants.dart';

class DeliverPage extends StatelessWidget {
  const DeliverPage({Key? key}) : super(key: key);

  Widget _packageDesc() {
    return TextField(
      decoration: CustomInputDecoration(),
      keyboardType: TextInputType.multiline,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  IconTitle(
                    icon: Icons.place,
                    title: "Where would you like your package to pe delivered",
                    subTitle: "Kiambu",
                    press: () {
                      debugPrint("open place picker");
                    },
                  ),
                  VerticalSpacing(),
                  ShiftDivider(),
                  VerticalSpacing(),
                  IconTitle(
                    icon: Icons.place_sharp,
                    title: "Package Pick Up address",
                    subTitle: "Pangani",
                    press: () {
                      debugPrint('open pick up address');
                    },
                  ),
                  VerticalSpacing(),
                  ShiftDivider(),
                  VerticalSpacing(),
                  IconTitle(
                      icon: Icons.schedule,
                      title: "Pick up time for your package",
                      subTitle: "10.00",
                      press: () {
                        debugPrint("open time picker");
                      }),
                  VerticalSpacing(),
                  ShiftDivider(),
                  VerticalSpacing(),
                  IconTitle(
                    icon: Icons.note_add,
                    title: "Pick up instruction at Juja",
                    subTitle: "Call 0707200314",
                    press: () {
                      debugPrint('open pick up instruction ');
                    },
                  ),
                  VerticalSpacing(),
                  ShiftDivider(),
                  VerticalSpacing(),
                  IconTitle(
                    icon: Icons.note_add,
                    title: "Drop Off Instructions at address",
                    subTitle: "I will Be their",
                    press: () {
                      debugPrint('open pick up address');
                    },
                  ),
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
