import 'package:flutter/material.dart';
import 'package:movers/utils/constants.dart';

Widget createDrawerItem(
    {IconData? icon, String? text, GestureTapCallback? onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(
          icon,
          color: colorOrange,
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            text!,
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                fontSize: 16.0),
          ),
        )
      ],
    ),
    onTap: onTap,
  );
}
