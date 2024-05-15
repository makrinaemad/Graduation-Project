import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/screens/admin/update_camera/edit_camera.dart';

import 'package:graduation_project/shared/style/button.dart';

import 'add_camera.dart';

class  AdminHome extends StatelessWidget {
  static const String routName="AdminHome";
  const AdminHome ({super.key});

  @override
  Widget build(BuildContext context) {
    return  Stack( 
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.jpg"), // <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
           body: Center(
             child: Column(
               children: [
                 SizedBox(height: 90,),
    Center(
      child: Container(
        width: 135, // Adjust width to make the button larger
        height: 145,
      decoration: BoxDecoration(
      image: DecorationImage(
      image: AssetImage("assets/images/profile.png"), // <-- BACKGROUND IMAGE
      fit: BoxFit.cover,
      ),
      ),
      ),
    ),

                 SizedBox(height: 130,),
                InkWell(

                  onTap: () {
                  //////
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddCamera()),
                    );
                  },
                  child: CustomButton(label: 'Add Camera', image_path: 'assets/images/button1.png', c: Colors.black,),
                )
                 ,
SizedBox(height: 42,)
,
 InkWell(
    onTap: () {
  //////////////
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditCamera()),
      );
    },
    child: CustomButton(label: 'Update Camera', image_path: 'assets/images/button1.png', c: Colors.black,),
    )
,

    ],
             ),
           )
        ),
      ],
    );
  }
}
