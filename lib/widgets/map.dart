import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

import '../../constants.dart';
class Map5 extends StatefulWidget {
  final Function(String) onAddressPicked;
  const Map5({Key? key, required this.onAddressPicked}) : super(key: key);

  @override
  State<Map5> createState() => _Map4State();
}

class _Map4State extends State<Map5> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:AppBar(
          title: const Center(child: Text('Traffic Detector', style: TextStyle(color: Colors.white,fontSize:18))),
          backgroundColor: Constants.primaryColor,
          actions: <Widget>[
            IconButton(
              color: Colors.white,
              icon: const Icon(Icons.menu),
              tooltip: 'Menu Icon',
              onPressed: () {},
            ),
            //IconButton
            //Image(image: AssetImage("assets/images/profile.png"))
            // IconButton(
            //   icon: const ImageIcon(
            //     AssetImage("assets/images/only_logo.png"),
            //     size: 24,
            //   ),
            //   tooltip: 'Setting Icon',
            //   onPressed: () {},
            // ), //IconButton
          ],
          leading: Container(
              margin: const EdgeInsets.all(8), // Adjust margin as needed
              width: 32, // Set the desired width
              height: 32,
              child: const Image(image: AssetImage("assets/images/profile.png"),)),

        ),
          body: FlutterLocationPicker(
              zoomButtonsColor: Constants.primaryColor,
              locationButtonsColor: Constants.primaryColor,
              zoomButtonsBackgroundColor: Colors.white,
              locationButtonBackgroundColor: Colors.white,
              initPosition: const LatLong(23, 89),
              showCurrentLocationPointer: true,
              searchbarInputBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Constants.primaryColor), // Set the border color here
                borderRadius: BorderRadius.circular(5),
              ),
              searchbarInputFocusBorderp: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Constants.primaryColor), // Set the border color here
                borderRadius: BorderRadius.circular(5),
              ),
              markerIcon: const Icon(
                Icons.location_pin,
                color: Constants.primaryColor,
              ),
              selectLocationButtonStyle: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Constants.primaryColor),
              ),
              selectedLocationButtonTextstyle:
                  const TextStyle(fontSize: 18, color: Colors.white),
              selectLocationButtonText: 'Set Location',
              initZoom: 11,
              minZoomLevel: 5,
              maxZoomLevel: 16,
              loadingWidget: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Constants.primaryColor), // Set the color here
              ),
              trackMyPosition: true,
              onError: (e) => print(e),
              onPicked: (pickedData) {
                widget.onAddressPicked(pickedData.address);
                Navigator.pop(context);
                print(pickedData.latLong.latitude);
                print(pickedData.latLong.longitude);
                print(pickedData.address);
                print(pickedData.addressData['country']);
              },
              onChanged: (pickedData) {
                print(pickedData.latLong.latitude);
                print(pickedData.latLong.longitude);
                print(pickedData.address);
                print(pickedData.addressData);
              })),
    );
  }
}
