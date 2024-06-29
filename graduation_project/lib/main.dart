import 'package:flutter/material.dart';
import 'package:graduation_project/screens/admin/add-camera/AddCamera_Form.dart';
import 'package:graduation_project/screens/admin/add_road/AddRoadPage.dart';
import 'package:graduation_project/screens/admin/admin_home.dart';
import 'package:graduation_project/screens/admin/get-roads/get_road.dart';
import 'package:graduation_project/screens/admin/get_camera/get_camera.dart';
import 'package:graduation_project/screens/user/premium/page1.dart';
import 'package:graduation_project/screens/user/setting.dart';
void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return
    // MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (_) => RoadsProvider()),
    //   ],
    //   child:

  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AdminHome.routName,
      routes: {
        AdminHome.routName:(context) => AdminHome(),
        EditCamera.routName:(context)=>EditCamera(),
        ShowRoad.routName:(context)=>ShowRoad(),
        CameraForm.routName: (context) =>CameraForm(),
        AddRoadPage.routName:(context) => AddRoadPage(),
        Page1_Premium.routName:(context)=>Page1_Premium(),


      },
  //),
    );
  }
}
//
//
// import 'package:flutter/material.dart';
// import 'package:graduation_project/screens/admin/add_camera/edit_road.dart';
// import 'package:graduation_project/screens/admin/add_camera/RoadsProvider.dart';
// import 'package:provider/provider.dart';
//
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => RoadsProvider()),
//       ],
//       child: MaterialApp(
//         home: AddRoadPage(),
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'package:graduation_project/shared/constant/constant.dart';
// import 'package:http/http.dart' as http;
// class Camera {
//   int? id;
//   String roadId;
//   bool active;
//   String model;
//   String factory;
//   String startService;
//   String dimensions;
//
//   Camera({
//     this.id,
//     required this.roadId,
//     required this.active,
//     required this.model,
//     required this.factory,
//     required this.startService,
//     required this.dimensions,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       'road_id': roadId,
//       'active': active,
//       'model': model,
//       'Factory': factory,
//       'Start_Service': startService,
//       'dimensions': dimensions,
//     };
//   }
// }
//
//
// class ApiManager {
//
//   static Future<void> updateCamera(Camera updatedCamera) async {
//     try {
//       Map<String, dynamic> jsonData = updatedCamera.toJson();
//       Uri url = Uri.https(Base, '/road/camera/update/${updatedCamera.id}');
//
//       print("URL: $url");
//       print("Headers: ${{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $token',
//       }}");
//       print("Body: $jsonData");
//
//       final response = await http.patch(
//         url,
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode(jsonData),
//       );
//
//       if (response.statusCode == 200) {
//         print("Camera updated successfully");
//       } else {
//         print('Failed to update camera. Error ${response.statusCode}: ${response.body}');
//         throw Exception('Failed to update camera. Server responded with code ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Exception caught: $e');
//       throw Exception('Failed to update camera');
//     }
//   }
// }
// void main() async {
//   Camera camera = Camera(
//     id: 93577, // Replace with actual camera ID
//     roadId: '880648',
//     active: true,
//     model: 'test ',
//     factory: 'factory',
//     startService: '10/12/2024',
//     dimensions: '12',
//   );
//
//   try {
//     await ApiManager.updateCamera(camera);
//   } catch (e) {
//     print('Update failed: $e');
//   }
// }
