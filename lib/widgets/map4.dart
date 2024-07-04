import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

import '../../constants.dart';
import 'bottom_sheet_widget.dart';

class Map4 extends StatefulWidget {
  final Function(String) onAddressPicked;
  const Map4({Key? key, required this.onAddressPicked}) : super(key: key);

  @override
  State<Map4> createState() => _Map4State();
}

class _Map4State extends State<Map4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlutterLocationPicker(
            initPosition: LatLong(23, 89),
            showSearchBar: false,
            showSelectLocationButton: true,
            showZoomController: false,
            showLocationController: false,
            showCurrentLocationPointer: false,
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
              // minimumSize: MaterialStateProperty.all<Size>(
              //   Size(50, 50), // Set the desired width and height
              // ),
              fixedSize: MaterialStateProperty.all<Size>(
                Size(50, 50), // Set the desired width and height
              ),
            ),
            selectedLocationButtonTextstyle:
                const TextStyle(fontSize: 18, color: Colors.white),
            selectLocationButtonText: 'Start Forcasting',
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
              showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return BottomSheetWidget();
            },
          ); // Return the BottomSheetWidget here

              // widget.onAddressPicked(pickedData.address);
              // Navigator.pop(context);
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
            }));
  }
}
