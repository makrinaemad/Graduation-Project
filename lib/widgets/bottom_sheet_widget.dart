import 'package:arrange_gp/widgets/time_picker_textField.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'date_picker_text_field.dart';
import 'dropDown_list.dart';
import 'forecast_button.dart';
import 'gradient_divider.dart';
import 'map.dart';

class BottomSheetWidget extends StatefulWidget {
  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  String _pickedLocation = '';

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Wrap with ListView
      //physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true, // Set shrinkWrap to true
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        MyAdvancedDropdown(),
        // TextFormField(
        //   readOnly: true,
        //   decoration: InputDecoration(
        //     labelText: 'Pickup Location',
        //     labelStyle: const TextStyle(
        //       color: Constants.primaryColor,
        //       fontSize: 18,
        //     ),
        //     border: InputBorder.none,
        //     suffixIcon: IconButton(
        //       icon: const Icon(Icons.location_on, color: Constants.primaryColor),
        //       onPressed: () {
        //
        //         _openMapPage(context);
        //       },
        //     ),
        //   ),
        //   controller: TextEditingController(text: _pickedLocation),
        //   onTap: () {
        //     _openMapPage(context);
        //   },
        // ),
        // const GradientDivider(),
        // const TextField(
        //   decoration: InputDecoration(
        //     hintText: 'Enter location',
        //   ),
        // ),
        const SizedBox(height: 16.0),
        DatePickerTextField(),
        const SizedBox(height: 16.0),
        TimePickerTextField(),
        const SizedBox(height: 50.0), // Adjust the height here
        const ForecastButton(),
        const SizedBox(height: 16.0),
      ],
    );
  }

  void _openMapPage(BuildContext context) async {
    final pickedAddress = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Map5(
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
// void _openMapPage(BuildContext context) async {
//   final pickedAddress = await Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => Map3(
//         onAddressPicked: (address) {
//           // Handle the picked address here
//         },
//       ),
//     ),
//   );
//
//   // Handle the picked address returned from Map3
// }
