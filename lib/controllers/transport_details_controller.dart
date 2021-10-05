import 'package:get/get.dart';

class TransportDetailsController extends GetxController {
  var selectedVehicle = "".obs;
  List<String> vehicleType = ["Pick Up", "Small Truck", "Large Truck"];

  void setVehicleType(String value) {
    selectedVehicle = value.obs;
    update();
  }
}
