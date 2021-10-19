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
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 5.0),
            ),
            fillColor: Colors.white,
            filled: true);
}
