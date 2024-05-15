import 'package:flutter/material.dart';

import 'package:graduation_project/screens/admin/add_camera.dart';
import 'package:graduation_project/screens/admin/admin_home.dart';
import 'package:graduation_project/screens/admin/update_camera/edit_camera.dart';
import 'package:graduation_project/screens/user/premium/page1.dart';
import 'package:graduation_project/screens/user/setting.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AdminHome.routName,
      routes: {
        AdminHome.routName:(context) => AdminHome(),
        EditCamera.routName:(context)=>EditCamera(),
        AddCamera.routName: (context) =>AddCamera(),
        Page1_Premium.routName:(context)=>Page1_Premium(),
        UserSetting.routName:(context)=>UserSetting(),

      },
    );
  }
}


