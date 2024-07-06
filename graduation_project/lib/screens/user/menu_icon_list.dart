import 'package:flutter/material.dart';
import 'package:graduation_project/screens/user/setting/change_password_screen.dart';
import 'package:graduation_project/screens/user/setting/edit_profile_screen.dart';

import '../../shared/constant/constants.dart';


class MenuIconList extends StatelessWidget {
  const MenuIconList({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.menu,color:Colors.white,size:30), // Use the menu icon here
      onSelected: (value) {
        if (value == "Edit profile") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProfileScreen(),
            ),
          );
        }
        else if (value == "Change password") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangePasswordScreen(),
            ),
          );
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        const PopupMenuItem(
          value: "Edit profile",
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.edit,color: Constants.primaryColor,),
              ),
              Text(
                'Edit profile',
                style: TextStyle(fontSize: 15,color:Constants.primaryColor),
              ),
            ],
          ),
        ),
        const PopupMenuItem(
          value: "Change password",
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.password,color: Constants.primaryColor,),
              ),
              Text(
                'Change password',
                style: TextStyle(fontSize: 15,color:Constants.primaryColor),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
