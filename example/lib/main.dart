import 'package:flutter/material.dart';
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
        //These three are compulsory to add otherwise it will generate error
        apiKey: "YOUR_API_KEY",
        firstPoint: MapPoint(24.9402897, 67.0770537),
        secondPoint: MapPoint(24.9242722, 67.0794189),
        mapTypes: MapTypes.satellite,
        mapOnTap: (point) {
          print(point.toString());
        },
        myLocationEnabled: true,
        markerOneOnTap: () {
          print("Marker One Tap");
        },
        markerTwoOnTap: () {
          print("Marker Two Tap");
        },
        trafficEnable: true,
        markerOneInfoText: "First Point",
        markerTwoInfoText: "Second Point",
        showMarkerOne: true,
        showMarkerTwo: true,
        firstPointMarkerIcon: 'assets/images/map.png',
        secondPointMarkerIcon: 'assets/images/map.png',
        lineColor: Colors.green,
        lineWidth: 10,
        mapZoom: 10,
        firstMarkerIconWidth: 120,
        secondMarkerIconWidth: 120,
      ),
    );
  }
}
