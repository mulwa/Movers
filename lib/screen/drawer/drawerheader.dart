import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movers/utils/constants.dart';

Widget createDrawerHeader({String? username}) {
  return DrawerHeader(
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    child: Stack(
      children: <Widget>[
        Positioned(
          bottom: 2.0,
          left: 16.0,
          child: Text(
            username!,
            style: TextStyle(fontSize: 18, color: colorAccent),
          ),
        )
      ],
    ),
  );
}
