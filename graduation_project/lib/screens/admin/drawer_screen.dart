import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/screens/admin/admin_home.dart';
import 'package:graduation_project/screens/admin/get-roads/get_road.dart';
import 'package:graduation_project/screens/admin/get_camera/get_camera.dart';

import 'all_users/AllAdmins.dart';
import 'all_users/AllUsers.dart';

class DrawerScreen extends StatelessWidget {
 //  Function onDrawerSelected;
 // static int CATEGORIES=1;
 //  static int SETTINGS=1;
  DrawerScreen();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.stretch,
      //   children: [
      //     Container(
      //       height: 70,
      //       color: Colors.green,
      //       child: Center(child: Text("News App",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),)),
      //     ),
      //     SizedBox(height: 5,),
      //     InkWell(
      //       onTap: (){
      //       //  onDrawerSelected(CATEGORIES);
      //       },
      //       child: Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Text("Categorie",style:TextStyle(fontSize: 18,
      //         ),
      //         ),
      //       ),
      //     ),
      //    // SizedBox(height: 15,),
      //     InkWell(
      //       onTap: (){
      //      //   onDrawerSelected(SETTINGS);
      //       },
      //       child: Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Text("Settings",style:TextStyle(fontSize: 18,
      //         ),),
      //       ),
      //     )
      //   ],
      // ),
      child: Container(
        width: 10,
        height: 10,
        color: Colors.transparent,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(14,46,92,1),
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/logo.png', // Add your image path here
                  width: 120,
                  height: 120,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Handle the tap here.
                Navigator.push(
                    context,
                MaterialPageRoute(builder: (context) => AdminHome()));
                //Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person_2_sharp),
              title: Text('Admins'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminListScreen ()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text('Users'),
              onTap: () {
                // Handle the tap here.UserListScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserListScreen ()),
                );

              },
            ),
            ListTile(
              leading: Icon(Icons.camera_enhance_sharp),
              title: Text('Cameras'),
              onTap: () {
                //////////////
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditCamera()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.edit_road_sharp),
              title: Text('Roads'),
              onTap: () {
                //////////////
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShowRoad()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
