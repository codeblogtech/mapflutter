import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition singapore =
      CameraPosition(target: LatLng(1.35, 103.87), zoom: 14);

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }

    Marker singaporeMarker = const Marker(
        markerId: MarkerId("Singapore"),
        position: LatLng(1.35, 103.87),
        infoWindow: InfoWindow(
            title: "Singapore", snippet: "Window Info sinppet block"));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        markers: <Marker>{singaporeMarker},
        initialCameraPosition: singapore,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
