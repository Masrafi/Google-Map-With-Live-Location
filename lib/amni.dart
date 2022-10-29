import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class Amni extends StatefulWidget {
  const Amni({Key? key}) : super(key: key);

  @override
  State<Amni> createState() => _AmniState();
}

class _AmniState extends State<Amni> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    test();
  }

  test() async {
    List<Location> locations = await locationFromAddress("Savar");
    print('this is one: ${locations[0].latitude}');
    print('this is one: ${locations[0].longitude}');
    print('this is two: ${locations[1].latitude}');
    print('this is two: ${locations[1].longitude}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Masrafi")),
    );
  }
}
