import 'package:flutter/material.dart';
import 'package:movers/utils/constants.dart';

class CustomInputDecoration extends InputDecoration {
  final String? labelText;
  final String? hintText;

  CustomInputDecoration({this.hintText, this.labelText})
      : super(
            labelText: labelText,
            hintText: hintText,
            hintStyle: TextStyle(
              color: hintColor,
            ),
            contentPadding: EdgeInsets.only(left: 10, top: 8, bottom: 8),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200, width: 1.0),
            ),
            fillColor: Colors.white,
            filled: true);
}
