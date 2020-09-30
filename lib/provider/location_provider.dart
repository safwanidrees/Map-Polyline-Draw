import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_polyline_draw/helper/location_helper.dart';

class LocationProvider {
  static LatLng firstPoint;
  static LatLng secondPoint;
  static final Set<Marker> markers = {};
  static final Set<Polyline> polyLines = {};
  static GoogleMapController mapController;
  static LocationHelper locationHelper = LocationHelper();

  // Draw PolineLine Function
  static Future<void> drawLine({
    String apiKey, // Map Api Key
    LatLng firstPoint, // Marker One Longitude and Latitude
    LatLng secondPoint, // Marker Two Longitude and Latitude
    Color lineColor, //Polyline Color
    Uint8List firstmarkerIcon, //First Marker icon
    Uint8List secondmarkerIcon, //Second Marker Icon
    int lineWidth, // Polyline width
    bool showFirstMarker, // First Marker icon Hide/Show
    bool showSecondMarker, // Second Marker icon Hide/Show
    String info1, //Marker One Info Window Text
    String info2, //Marker Two Info Window Text
    Function markerOneOnTap, //Marker One onTap
    Function markerTwoOnTap, //Marker Two onTap
  }) async {
    _addMarker(
        firstPoint: firstPoint,
        secondPoint: secondPoint,
        firstmarkerIcon: firstmarkerIcon,
        secondmarkerIcon: secondmarkerIcon,
        showSecondMarker: showSecondMarker,
        showFirstmarker: showFirstMarker,
        info1: info1,
        info2: info2,
        markerTwoOnTap: markerTwoOnTap,
        markerOneOnTap: markerOneOnTap);

//Getting information from Google Map Api
    String route = await locationHelper.getRouteCoordinates(
        firstPoint, secondPoint, apiKey);

    createPolyline(route, lineColor, lineWidth);
  }

//Creating Polyline
  static void createPolyline(
      String encondedPolyline, Color lineColor, int lineWidth) {
    polyLines.add(Polyline(
        polylineId: PolylineId(secondPoint.toString()),
        width: lineWidth,
        points: convertingToLatLng(decodedPolyline(encondedPolyline)),
        color: lineColor));
  }

  static List decodedPolyline(String poly) {
    var list1 = poly.codeUnits;
    var list2 = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    // Repeating this until all attributes are decoded
    do {
      var shift = 0;
      int value = 0;
      // Decoding value of one attribute
      do {
        c = list1[index] - 63;
        value |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      //if value is negative
      if (value & 1 == 1) {
        value = ~value;
      }
      var value1 = (value >> 1) * 0.00001;
      list2.add(value1);
    } while (index < len);
    //Adding to previous value
    for (var i = 2; i < list2.length; i++) list2[i] += list2[i - 2];
    return list2;
  }

  // Add Marker on the Map
  static void _addMarker(
      {LatLng firstPoint,
      LatLng secondPoint,
      Uint8List firstmarkerIcon,
      Uint8List secondmarkerIcon,
      bool showFirstmarker,
      bool showSecondMarker,
      String info1,
      String info2,
      Function markerOneOnTap,
      Function markerTwoOnTap}) {
    showFirstmarker
        ? markers.add(Marker(
            onTap: markerOneOnTap,
            markerId: MarkerId("marker1"),
            position: firstPoint,
            infoWindow: info1 == null ? null : InfoWindow(title: info1),
            icon: firstmarkerIcon == null
                ? BitmapDescriptor.defaultMarker
                : BitmapDescriptor.fromBytes(firstmarkerIcon)))
        : null;

    showSecondMarker
        ? markers.add(Marker(
            onTap: markerTwoOnTap,
            markerId: MarkerId(secondPoint.toString()),
            position: secondPoint,
            infoWindow: info2 == null ? null : InfoWindow(title: info2),
            icon: secondmarkerIcon == null
                ? BitmapDescriptor.defaultMarker
                : BitmapDescriptor.fromBytes(secondmarkerIcon)))
        : null;
  }

  static List<LatLng> convertingToLatLng(List pointsofList) {
    List<LatLng> convertedList = <LatLng>[];
    for (int i = 0; i < pointsofList.length; i++) {
      if (i % 2 != 0) {
        convertedList.add(LatLng(pointsofList[i - 1], pointsofList[i]));
      }
    }
    return convertedList;
  }

  static void onCameraMove(CameraPosition position) {
    secondPoint = position.target;
  }

  static void onCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
