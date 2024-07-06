import 'package:flutter/material.dart';
import 'package:graduation_project/models/ForcastingDataModel.dart';
import 'package:graduation_project/screens/user/user_forcast/show_result.dart';
import 'package:graduation_project/screens/user/user_forcast/time_picker_textField.dart';

import '../../../shared/constant/constant.dart';
import '../../../shared/constant/constants.dart';
import '../drower_screen.dart';
import 'date_picker_text_field.dart';


class ForecastButton extends StatelessWidget {
  const ForecastButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return //UnconstrainedBox(
       ElevatedButton(
         onPressed: () {
              String date=formatDate(selectedDate!);
              String time =formatTime(selectedDateTime!);
           RoadData road=RoadData(roadId: roadId, date: date, time: time);
           print("${road.roadId}       ${road.date}           ${road.time}");
Navigator.push(
             context,
             MaterialPageRoute(builder: (context) =>  ShowForecastingResultScreen(roadData: road,)),
           );

         },
         style: ElevatedButton.styleFrom(
           backgroundColor: Constants.primaryColor,
           textStyle: const TextStyle(color: Colors.black),
           shape:
               RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
         ),
         child: const Text(
           'Forecast',
           style: TextStyle(
             color: Colors.white,
             fontSize: 16,
             fontWeight: FontWeight.w500,
           ),
         ),
       );
   // ); //InkWell(
    //   onTap: () {
    //     // Handle onTap
    //   },
    //   child: Container(
    //     width: 25, // Adjust the width here
    //     height: 48,
    //     decoration: BoxDecoration(
    //       color: Color(0xff076092),
    //       borderRadius: BorderRadius.circular(5),
    //     ),
    //     child: const Center(
    //       child: Text(
    //         'Forecast',
    //         style: TextStyle(
    //           color: Colors.white,
    //           fontSize: 16,
    //           fontWeight: FontWeight.w500,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
