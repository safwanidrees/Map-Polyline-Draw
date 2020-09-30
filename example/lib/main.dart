import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_polyline_draw/map_polyline_draw.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: "Map Polyline Draw",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: MapPolyLineDraw(
        apiKey: "YOUR_API_KEY",
        firstPoint: LatLng(24.8960309, 67.0792159),
        secondPoint: LatLng(24.9425822, 67.0691675),

        /// mapType: MapType.satellite,
        /// mapOnTap: (point) {
        ///   print(point.toString());
        /// },
        /// myLocationEnabled: true,
        /// markerOneOnTap: () {
        ///   print("Marker One Tap");
        /// },
        /// markerTwoOnTap: () {
        ///   print("Marker Two Tap");
        /// },
        /// trafficEnable: true,
        /// markerOneInfoText: "First Point",
        /// markerTwoInfoText: "Second Point",
        /// showMarkerOne: true,
        /// showMarkerTwo: true,
        /// firstPointMarkerIcon: 'assets/images/map.png',
        /// secondPointMarkerIcon: 'assets/images/map.png',
        /// lineColor: Colors.green,
        /// lineWidth: 10,
        /// mapZoom: 10,
        /// firstMarkerIconWidth: 120,
        /// secondMarkerIconWidth: 120,
      ),
    );
  }
}
