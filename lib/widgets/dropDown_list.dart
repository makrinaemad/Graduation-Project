import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../constants.dart';

class MyAdvancedDropdown extends StatefulWidget {
  const MyAdvancedDropdown({super.key});

  @override
  _MyAdvancedDropdownState createState() => _MyAdvancedDropdownState();
}

class _MyAdvancedDropdownState extends State<MyAdvancedDropdown> {
  String? _selectedItem;
  List<String> _dropdownItems = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response = await Dio().get('https://graduation-project-fdvx.onrender.com/road/');
      final List<dynamic> data = response.data;

      setState(() {
        _dropdownItems = data.map((item) => item['name'] as String).toList();
        if (_dropdownItems.isNotEmpty) {
          _selectedItem = _dropdownItems[0];
        }
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: _dropdownItems.isEmpty
              ? CircularProgressIndicator()
              : DropdownButtonFormField<String>(
            value: _selectedItem,
            onChanged: (String? value) {
              setState(() {
                _selectedItem = value!;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Select a road',
              labelStyle:TextStyle(color: Constants.primaryColor),
              floatingLabelStyle:TextStyle(color: Constants.primaryColor),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                color: Constants.primaryColor,
                  // Set border color
              ),),
                suffixIconColor: Constants.primaryColor,
                prefixIconColor:Constants.primaryColor,
            ),
            items: _dropdownItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: Constants.primaryColor),
                    const SizedBox(width: 10),
                    Text(value),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      );
  }
}
