// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:graduation_project/shared/style/button.dart';
//
// import '../../shared/style/gradient_divider.dart';
// import '../../shared/style/text_field.dart';
//
// class UserSetting extends StatelessWidget {
//   static const String routName="setting";
//   const UserSetting({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         backgroundColor: Color.fromRGBO(14,46,92,1),
//       ),
//       body: Column(
//         children: [
//
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 100, // Adjust width to make the button larger
//                     height: 120,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage("assets/images/profile.png"), // <-- BACKGROUND IMAGE
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 25),
//                 CustomTextFormField(
//                 labelText: 'First name',
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a first name';
//                   }
//                   return null;
//                 },
//                 controller: TextEditingController(),
//                 keyboardType: TextInputType.text,
//               ),
//                   GradientDivider(),
//                   CustomTextFormField(
//                     labelText: 'Last name',
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a last name';
//                       }
//                       return null;
//                     },
//                     controller: TextEditingController(),
//                     keyboardType: TextInputType.text,
//                   ),
//                   GradientDivider(),
//                   CustomTextFormField(
//                     labelText: 'Email',
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter valid email';
//                       }
//                       return null;
//                     },
//                     controller: TextEditingController(),
//                     keyboardType: TextInputType.emailAddress,
//                   ),
//                   GradientDivider(),// Use the GradientDivider here
//               CustomTextFormField(
//                 labelText: 'Password',
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   return null;
//                 },
//                 controller: TextEditingController(),
//                 keyboardType: TextInputType.visiblePassword,
//               ), GradientDivider(),
//                   SizedBox(height: 110),
//                   InkWell(
//                     onTap: () {
//                       //////
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(builder: (context) => AddCamera()),
//                       // );
//                     },
//                     child:CustomButton( label: 'Save', imagePath: 'assets/images/button2.png', c: Colors.white,icon: null),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
