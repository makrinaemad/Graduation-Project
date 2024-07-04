import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class Map3 extends StatefulWidget {
  final Function(String) onAddressPicked;
  const Map3({super.key, required this.onAddressPicked});

  @override
  State<Map3> createState() => _Map3State();
}

class _Map3State extends State<Map3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OpenStreetMapSearchAndPick(
        buttonTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        buttonColor: const Color(0xff076092),
        locationPinIconColor: const Color(0xff076092),
        locationPinTextStyle: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 198, 199, 199)),
        buttonText: 'Set Location',
        //buttonHeight: ,
        buttonWidth: 200,
        buttonHeight: 50,
        onPicked: (pickedData) {
          widget.onAddressPicked(pickedData.addressName);
          Navigator.pop(context);
          print(pickedData.latLong.latitude);
          print(pickedData.latLong.longitude);
          print(pickedData.address);
          print(pickedData.addressName);
        },
      ),
    );
  }
}
