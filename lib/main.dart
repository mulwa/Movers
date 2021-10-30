import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movers/controllers/login_controller.dart';
import 'package:movers/screen/authentication/login.dart';
import 'package:movers/screen/landing_page.dart';
import 'package:movers/screen/map_page.dart';
import 'package:movers/utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => {Get.put(LoginController())});
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Movers',
      theme: ThemeData(
          primaryColor: colorPrimary,
          tabBarTheme: TabBarTheme(
              labelStyle: GoogleFonts.montserrat(fontSize: 16),
              unselectedLabelStyle: GoogleFonts.montserrat(fontSize: 16)),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            textTheme:
                GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme),
          ),
          textTheme: GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme)),
      home: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
