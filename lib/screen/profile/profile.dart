import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movers/controllers/login_controller.dart';
import 'package:movers/shared/app_card.dart';
import 'package:movers/shared/styles.dart';
import 'package:movers/shared/vertical_spacing.dart';

class ProfilePage extends GetView<LoginController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSpacing(),
                    Divider(),
                    VerticalSpacing(),
                    Text(
                      controller.userModel.value.phoneNumber!,
                      style: mediumTitleStyle,
                    ),
                    VerticalSpacing(),
                    Divider(),
                    VerticalSpacing(),
                    Text(
                      controller.userModel.value.fullName!,
                      style: mediumTitleStyle,
                    ),
                    VerticalSpacing(),
                    Divider(),
                    VerticalSpacing(),
                    Text(
                      controller.userModel.value.emailAddress!,
                      style: mediumTitleStyle,
                    ),
                    VerticalSpacing(),
                    Divider()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
