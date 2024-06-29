import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final String? Function(String?)? validator; // Update the type here
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Color textColor;
  const CustomTextFormField({
    super.key,
    this.obscureText = false,
    required this.labelText,
    required this.validator,
    required this.controller,
    required this.keyboardType,
   this.textColor= Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.005,
      ),
      child: TextFormField(
        style: TextStyle(color:textColor),
        textInputAction: TextInputAction.next,
        obscureText: obscureText,
        validator: validator, // Update here
        cursorColor: Color(0xff076092),
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Color(0xff076092),
            fontSize: 18,

          ),
          contentPadding: const EdgeInsets.only(bottom: 4),
          border:UnderlineInputBorder(),

        ),

      ),
    );
  }
}
