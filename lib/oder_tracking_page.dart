import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart' as lo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemapdemo/constrant.dart';
import 'package:location/location.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(23.847879799999998, 90.2575646);
  static const LatLng destination = LatLng(23.7932126, 90.2713349);
  late double flat, flon, lLat, lLon;
  List<LatLng> polylineCoordinates = [];

  //get current location
  Location location = Location();
  LocationData? currentLocation;
  void getCurrentLocation() {
    //location.enableBackgroundMode(enable: true);
    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
        print("This is my current location: $currentLocation");
      });
    });
  }

  //show polyline from source to destination
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(
            point.latitude,
            point.longitude,
          ),
        ),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentLocation();
    getPolyPoints();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //getCurrentLocation();
    return Scaffold(
        appBar: AppBar(),
        body: currentLocation == null
            ? Center(child: Text("Loading"))
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: sourceLocation,
                  // target: LatLng(
                  //     currentLocation!.latitude!, currentLocation!.longitude!),
                  zoom: 13.5,
                ),
                polylines: {
                  Polyline(
                    polylineId: PolylineId("route"),
                    points: polylineCoordinates,
                    color: primaryColor,
                    width: 6,
                  )
                },
                markers: {
                  Marker(
                    markerId: MarkerId("source"),
                    position: sourceLocation,
                  ),
                  // Marker(
                  //     markerId: MarkerId("source"),
                  //     position: LatLng(currentLocation!.latitude!,
                  //         currentLocation!.longitude!)),
                  Marker(
                    markerId: MarkerId("destination"),
                    position: destination,
                  )
                },
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(FontAwesomeIcons.diamondTurnRight),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  Future<void> _create() async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Your Location'),
                ),
                TextField(
                  // keyboardType:
                  //     const TextInputType.text,
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Destination',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    child: const Text('Create'),
                    onPressed: () async {
                      from();
                      to();
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          );
        });
  }

  from() async {
    List<lo.Location> locations =
        await lo.locationFromAddress(_nameController.text);
    flat = locations[0].latitude;
    flon = locations[0].longitude;
    print('this is one: ${locations[0].latitude}');
    print('this is one: ${locations[0].longitude}');
    // print('this is two: ${locations[1].latitude}');
    // print('this is two: ${locations[1].longitude}');
  }

  to() async {
    List<lo.Location> locations =
        await lo.locationFromAddress(_priceController.text);
    lLat = locations[0].latitude;
    lLon = locations[0].longitude;
    print('this is one: ${locations[0].latitude}');
    print('this is one: ${locations[0].longitude}');
    // print('this is two: ${locations[1].latitude}');
    // print('this is two: ${locations[1].longitude}');
  }
}
