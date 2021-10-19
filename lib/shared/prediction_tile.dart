import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movers/models/address_model.dart';
import 'package:movers/models/place_prediction.dart';
import 'package:movers/utils/constants.dart';
import 'package:movers/utils/request_helper.dart';
import 'package:provider/provider.dart';

class PridictionTile extends StatelessWidget {
  final Prediction prediction;
  const PridictionTile({
    Key? key,
    required this.prediction,
  }) : super(key: key);

  void getPlaceDetails(String placeID, context) async {
    var url = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeID&key=$MAPKEY");
    var res = await RequestHelper.getRequest(url);
    if (res == 'failed') {
      return;
    }
    if (res['status'] == 'OK') {
      Address address = Address();
      address.placeName = res['result']['name'];
      address.placeId = placeID;
      address.latitude = res['result']['geometry']['location']['lat'];
      address.longitude = res['result']['geometry']['location']['lng'];

      // Get.back(result, address);

      Navigator.pop(context, address);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        getPlaceDetails(prediction.placeId!, context);
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                Icon(Icons.place),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prediction.mainText!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87),
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        prediction.secondaryText!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontSize: 12.0),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
