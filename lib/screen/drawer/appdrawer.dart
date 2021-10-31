import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movers/controllers/login_controller.dart';
import 'package:movers/screen/drawer/drawerheader.dart';
import 'package:movers/screen/drawer/draweritem.dart';
import 'package:movers/screen/profile/profile.dart';
import 'package:movers/shared/styles.dart';
import 'package:movers/shared/vertical_spacing.dart';

class AppDrawer extends GetView<LoginController> {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          createDrawerHeader(username: controller.userModel.value.fullName),
          VerticalSpacing(
            height: 15.0,
          ),
          createDrawerItem(
              icon: Icons.group,
              text: "Profile",
              onTap: () {
                Navigator.pop(context);
                Get.to(ProfilePage());
              }),
          VerticalSpacing(),
          createDrawerItem(
              icon: Icons.history,
              text: "History",
              onTap: () {
                Navigator.pop(context);
              }),
          VerticalSpacing(),
          createDrawerItem(
              icon: Icons.info,
              text: "About",
              onTap: () {
                Navigator.pop(context);
              }),
          VerticalSpacing(),
          Divider(),
          VerticalSpacing(),
          createDrawerItem(
              icon: Icons.info,
              text: "Log out",
              onTap: () {
                controller.signOut();
              }),
          VerticalSpacing(),
          Divider(),
          VerticalSpacing(),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Version 1.0",
                  style: mediumTitleStyle,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
