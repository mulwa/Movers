import 'package:flutter/material.dart';

class TransportDetailsPage extends StatelessWidget {
  const TransportDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Transport Details"),
        ),
      ),
    );
  }
}
