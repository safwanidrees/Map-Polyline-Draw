library map_polyline_draw;

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_polyline_draw/provider/location_provider.dart';

class MapPolyLineDraw extends StatefulWidget {
  final String apiKey;

  /// Map Api Key
  final MapPoint firstPoint;

  /// Marker One Longitude and Latitude
  final MapPoint secondPoint;

  /// Marker Two Longitude and Latitude
  final Color lineColor;

  ///Polyline Color
  final int lineWidth;

  /// Polyline width
  final int firstMarkerIconWidth;

  ///First Marker icon Width
  final int secondMarkerIconWidth;

  ///Second Marker Icon Width
  final String? firstPointMarkerIcon;

  ///First Marker Icon
  final String? secondPointMarkerIcon;

  ///Second Marker Icon
  final double mapZoom;

  ///Map Zoom
  final MapTypes mapTypes;

  ///Map Type
  final Function? mapOnTap;

  ///Map OnTap
  final bool trafficEnable;

  ///Map Traffic Enabled
  final bool myLocationEnabled;

  ///My Location Enabled
  final bool showMarkerOne;

  /// First Marker icon Hide/Show
  final bool showMarkerTwo;

  /// Second Marker icon Hide/Show
  final String? markerOneInfoText;

  /// First Marker Info Window
  final String? markerTwoInfoText;

  /// Second Marker Info Window
  final Function? markerOneOnTap;

  /// Marker One Tap
  final Function? markerTwoOnTap;

  /// Marker Two Tap

  MapPolyLineDraw(
      {required this.apiKey,
      required this.firstPoint,
      required this.secondPoint,
      this.lineWidth = 3,
      this.lineColor = Colors.black,
      this.firstMarkerIconWidth = 100,
      this.secondMarkerIconWidth = 100,
      this.mapZoom = 14,
      this.firstPointMarkerIcon,
      this.secondPointMarkerIcon,
      this.mapTypes = MapTypes.normal,
      this.mapOnTap,
      this.trafficEnable = false,
      this.myLocationEnabled = false,
      this.showMarkerOne = true,
      this.showMarkerTwo = true,
      this.markerOneInfoText,
      this.markerTwoInfoText,
      this.markerOneOnTap,
      this.markerTwoOnTap});
  @override
  _MapPolyLineDrawState createState() => _MapPolyLineDrawState();
}

class _MapPolyLineDrawState extends State<MapPolyLineDraw> {
  GoogleMapController? mapController;
  bool _isLoading = false;
  Completer<GoogleMapController> _controller = Completer();
  late MapType type;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.mapTypes) {
      case MapTypes.satellite:
        {
          type = MapType.satellite;
        }
        break;

      case MapTypes.none:
        {
          type = MapType.none;
        }
        break;
      case MapTypes.hybrid:
        {
          type = MapType.hybrid;
        }
        break;
      case MapTypes.terrain:
        {
          type = MapType.terrain;
        }
        break;
      case MapTypes.normal:
        {
          type = MapType.normal;
        }
        break;
      default:
        {
          type = MapType.normal;
        }
        break;
    }

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : GoogleMap(
            myLocationEnabled: widget.myLocationEnabled,
            initialCameraPosition: CameraPosition(
                target: LatLng(
                    widget.firstPoint.latitude, widget.firstPoint.longitude),
                zoom: widget.mapZoom),
            mapType: type,
            compassEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                _controller.complete(controller);
              });
            },
            trafficEnabled: widget.trafficEnable,
            onTap: widget.mapOnTap as void Function(LatLng)?,
            markers: LocationProvider.markers,
            onCameraMove: LocationProvider.onCameraMove,
            polylines: LocationProvider.polyLines,
          );
  }

  Future<void> getData() async {
    /// Clearing Previous Marker and Polyline

    LocationProvider.markers.clear();
    LocationProvider.polyLines.clear();
    try {
      ///Loading Start
      setState(() {
        _isLoading = true;
      });

      /// Applying Condition One
      if (widget.firstPointMarkerIcon == null &&
          widget.secondPointMarkerIcon == null) {
        await LocationProvider.drawLine(
            apiKey: widget.apiKey,
            firstPoint:
                LatLng(widget.firstPoint.latitude, widget.firstPoint.longitude),
            secondPoint: LatLng(
                widget.secondPoint.latitude, widget.secondPoint.longitude),
            lineColor: widget.lineColor,
            lineWidth: widget.lineWidth,
            showFirstMarker: widget.showMarkerOne,
            showSecondMarker: widget.showMarkerTwo,
            info2: widget.markerTwoInfoText,
            info1: widget.markerOneInfoText,
            markerOneOnTap: widget.markerOneOnTap,
            markerTwoOnTap: widget.markerTwoOnTap);
      }

      /// Applying Condition Two
      else if (widget.firstPointMarkerIcon == null) {
        final Uint8List secondmarkerIcon = await getBytesFromAsset(
            widget.secondPointMarkerIcon!, widget.secondMarkerIconWidth);

        await LocationProvider.drawLine(
            apiKey: widget.apiKey,
            firstPoint:
                LatLng(widget.firstPoint.latitude, widget.firstPoint.longitude),
            secondPoint: LatLng(
                widget.secondPoint.latitude, widget.secondPoint.longitude),
            lineColor: widget.lineColor,
            secondmarkerIcon: secondmarkerIcon,
            info2: widget.markerTwoInfoText,
            info1: widget.markerOneInfoText,
            markerOneOnTap: widget.markerOneOnTap,
            markerTwoOnTap: widget.markerTwoOnTap,
            lineWidth: widget.lineWidth,
            showFirstMarker: widget.showMarkerOne,
            showSecondMarker: widget.showMarkerTwo);
      }

      /// Applying Condition Three
      else if (widget.secondPointMarkerIcon == null) {
        final Uint8List firstmarkerIcon = await getBytesFromAsset(
            widget.firstPointMarkerIcon!, widget.firstMarkerIconWidth);

        await LocationProvider.drawLine(
            apiKey: widget.apiKey,
            firstPoint:
                LatLng(widget.firstPoint.latitude, widget.firstPoint.longitude),
            secondPoint: LatLng(
                widget.secondPoint.latitude, widget.secondPoint.longitude),
            lineColor: widget.lineColor,
            firstmarkerIcon: firstmarkerIcon,
            lineWidth: widget.lineWidth,
            info2: widget.markerTwoInfoText,
            info1: widget.markerOneInfoText,
            showFirstMarker: widget.showMarkerOne,
            showSecondMarker: widget.showMarkerTwo,
            markerOneOnTap: widget.markerOneOnTap,
            markerTwoOnTap: widget.markerTwoOnTap);
      }

      /// Applying Condition Four
      else {
        final Uint8List firstmarkerIcon = await getBytesFromAsset(
            widget.firstPointMarkerIcon!, widget.firstMarkerIconWidth);
        final Uint8List secondmarkerIcon = await getBytesFromAsset(
            widget.secondPointMarkerIcon!, widget.secondMarkerIconWidth);

        await LocationProvider.drawLine(
            apiKey: widget.apiKey,
            firstPoint:
                LatLng(widget.firstPoint.latitude, widget.firstPoint.longitude),
            secondPoint: LatLng(
                widget.secondPoint.latitude, widget.secondPoint.longitude),
            firstmarkerIcon: firstmarkerIcon,
            secondmarkerIcon: secondmarkerIcon,
            lineColor: widget.lineColor,
            lineWidth: widget.lineWidth,
            showFirstMarker: widget.showMarkerOne,
            showSecondMarker: widget.showMarkerTwo,
            info2: widget.markerTwoInfoText,
            info1: widget.markerOneInfoText,
            markerOneOnTap: widget.markerOneOnTap,
            markerTwoOnTap: widget.markerTwoOnTap);
      }

      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      throw error;
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData byteData = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
        byteData.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}

class MapPoint {
  double longitude;
  double latitude;
  MapPoint(this.latitude, this.longitude);
}

enum MapTypes {
  none,
  normal,
  satellite,
  terrain,
  hybrid,
}
