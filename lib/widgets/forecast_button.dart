import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../cubit/forecast cubit/forecast_cubit.dart';
import '../screens/show_forecastin_result_screen.dart';

class ForecastButton extends StatelessWidget {
  const ForecastButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return //UnconstrainedBox(
       ElevatedButton(
         onPressed: () {
           context.read<ForecastCubit>().forecast();
           Navigator.push(
             context,
             MaterialPageRoute(
               builder: (context) => (ShowForecastingResultScreen()),
             ),
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
