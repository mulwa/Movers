import 'package:flutter/material.dart';
import 'package:movers/screen/drawer/appdrawer.dart';
import 'package:movers/shared/app_card.dart';
import 'package:movers/shared/styles.dart';
import 'package:movers/shared/vertical_spacing.dart';
import 'package:movers/utils/constants.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text("Movers"),
        ),
        body: Container(
          margin: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.home_outlined,
                      size: 30,
                      color: colorOrange,
                    ),
                    title: Text(
                      "Schedule Transport",
                      style: mediumTitleStyle,
                    ),
                    subtitle: Text('Schedule and book for later transport'),
                    onTap: () {
                      debugPrint('apartment moving');
                    },
                  ),
                ),
              ),
              VerticalSpacing(),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.track_changes,
                      color: colorOrange,
                      size: 30,
                    ),
                    title: Text(
                      "Get Transport",
                      style: mediumTitleStyle,
                    ),
                    subtitle: Text('Get your transport quest immediately'),
                    onTap: () {
                      debugPrint('apartment moving');
                    },
                  ),
                ),
              ),
              VerticalSpacing(),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.local_shipping_outlined,
                      color: colorOrange,
                      size: 30,
                    ),
                    title: Text(
                      "Delivery",
                      style: mediumTitleStyle,
                    ),
                    subtitle: Text('Lets help you move to your new Building'),
                    onTap: () {
                      debugPrint('Delivery');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
