import 'package:flutter/material.dart';
import 'package:googlemapdemo/tracking_screen.dart';
import 'package:location/location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Location location = Location();
  LocationData? currentLocation;
  void getCurrentLocation() {
    //location.enableBackgroundMode(enable: true);

    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
        // sourceLocation =
        //     LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
        // destination =
        //     LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const TrackingScreen(),
    );
  }
}
