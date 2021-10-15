import 'package:flutter/material.dart';
import 'package:movers/screen/drawer/appdrawer.dart';
import 'package:movers/shared/app_card.dart';
import 'package:movers/shared/vertical_spacing.dart';

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
              AppCard(
                child: ListTile(
                  title: Text("Move Apartment"),
                  subtitle: Text('Lets help you move to your new Building'),
                  onTap: () {
                    debugPrint('apartment moving');
                  },
                ),
              ),
              VerticalSpacing(),
              AppCard(
                child: ListTile(
                  title: Text("Delivery"),
                  subtitle: Text('Lets help you move to your new Building'),
                  onTap: () {
                    debugPrint('Delivery');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
