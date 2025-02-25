import 'package:flutter/material.dart';
import 'package:movers/utils/constants.dart';

Widget createDrawerHeader({String? username}) {
  return DrawerHeader(
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    child: Container(
      margin: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              Icon(
                Icons.account_circle,
                color: colorOrange,
                size: 30,
              ),
              SizedBox(
                width: 15.0,
              ),
              Text(
                username!,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
