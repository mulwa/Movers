import 'package:flutter/material.dart';
import 'package:movers/screen/drawer/drawerheader.dart';
import 'package:movers/screen/drawer/draweritem.dart';
import 'package:movers/shared/styles.dart';
import 'package:movers/shared/vertical_spacing.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          createDrawerHeader(username: "Christopher Mulwa"),
          VerticalSpacing(
            height: 15.0,
          ),
          createDrawerItem(
              icon: Icons.group,
              text: "Profile",
              onTap: () {
                Navigator.pop(context);
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
