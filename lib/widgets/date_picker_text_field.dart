import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../cubit/forecast cubit/forecast_cubit.dart';
import 'gradient_divider.dart'; // Import the intl package for date formatting

class DatePickerTextField extends StatefulWidget {
  @override
  _DatePickerTextFieldState createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  DateTime? _selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Constants.primaryColor),
            buttonTheme: const  ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
              colorScheme: ColorScheme.light(primary: Constants.primaryColor),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      context.read<ForecastCubit>().date= _selectedDate;

      print(context.read<ForecastCubit>().date);
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Format the selected date to display only the date portion
    String formattedDate = _selectedDate != null
        ? DateFormat('dd_MM_yyyy').format(_selectedDate!)
        : '';
    return Column(
      children: [
        TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            labelText: 'Pickup date',
            labelStyle: const TextStyle(
              color: Constants.primaryColor,
              fontSize: 18,
            ),
            // contentPadding: EdgeInsets.only(
            //     left: MediaQuery.of(context).size.width * 0.04,
            //     right: MediaQuery.of(context).size.width * 0.04),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_today, color: Constants.primaryColor),
              onPressed: () {
                _selectDate(context);
              },
            ),
          ),
          controller: TextEditingController(text: formattedDate),
          onTap: () {
            _selectDate(context);
          },
        ),
        GradientDivider(),
      ],
    );
  }
}
