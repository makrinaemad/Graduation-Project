import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../widgets/map4.dart';
import 'change_password_screen.dart';

class ForecastingScreen extends StatefulWidget {
  const ForecastingScreen({Key? key}) : super(key: key);

  @override
  State<ForecastingScreen> createState() => _ForecastingScreenState();
}

class _ForecastingScreenState extends State<ForecastingScreen> {
  String _pickedLocation = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Traffic Detector', style: TextStyle(color: Colors.white,fontSize:18))),
          backgroundColor: Constants.primaryColor,
          actions: <Widget>[
            IconButton(
              color: Colors.white,
              icon: const Icon(Icons.menu),
              tooltip: 'Menu Icon',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePasswordScreen()/*UserSetting()*/),
                );
              },
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
        // appBar: AppBar(
        //   title: const Text('', style: TextStyle(color: Colors.white)),
        //   backgroundColor: Constants.primaryColor,
        //   actions: <Widget>[
        //     IconButton(
        //       color: Colors.white,
        //       icon: const Icon(Icons.menu,size: 35,),
        //       tooltip: 'Menu Icon',
        //       onPressed: () {},
        //     ),
        //   ],
        //   leading: Container(
        //
        //       margin: const EdgeInsets.all(2), // Adjust margin as needed
        //       width: 50, // Set the desired width
        //       height: 50,
        //       child: const Image(image: AssetImage("assets/images/profile.png"),)),
        //
        // ),
        body: Map4(
          onAddressPicked: (address) {
            // Handle the picked address here if needed
          },
        ), //Column(
        //   children: [
        //     Text(_pickedLocation), // Display picked location here
        //     ElevatedButton(
        //       onPressed: () async {
        //         await _openMapPage(context); // Wait for location picking
        //         showModalBottomSheet(
        //           context: context,
        //           builder: (BuildContext context) {
        //             return BottomSheetWidget(); // Return the BottomSheetWidget here
        //           },
        //         );
        //       },
        //       child: const Text('Select Location and Forecast'),
        //     ),
        //   ],
        // ),
      ),
    );
  }

  Future<void> _openMapPage(BuildContext context) async {
    final pickedAddress = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Map4(
          onAddressPicked: (address) {
            setState(() {
              _pickedLocation = address;
            });
          },
        ),
      ),
    );

    // Handle the picked address returned from Map3
    if (pickedAddress != null) {
      setState(() {
        _pickedLocation = pickedAddress;
      });
    }
  }
}
