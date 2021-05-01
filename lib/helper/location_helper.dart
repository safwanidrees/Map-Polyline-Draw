import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class LocationHelper {
  Future<String> getRouteCoordinates(
      LatLng l1, LatLng l2, String apiKey) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";

    http.Response response = await http.get(Uri.parse(url));
    print(response);
    var responceData = jsonDecode(response.body);
    if (responceData["status"] != "REQUEST_DENIED") {
      Map values = responceData;
      return values["routes"][0]["overview_polyline"]["points"];
    } else {
      return responceData["error_message"];
    }
  }
}
