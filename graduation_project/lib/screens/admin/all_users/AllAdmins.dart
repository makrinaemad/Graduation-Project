//UserListScreen

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/RoadModel.dart';
import 'package:graduation_project/models/UserModel.dart';


import '../../../models/CamModel.dart';
import '../../../shared/remote/api_manager.dart';
import '../admin_home.dart';
import '../drawer_screen.dart';
import 'UserItem.dart';


class AdminListScreen extends StatelessWidget {
  static const String routName="Admins";
  const AdminListScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed:() {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminHome()));},
        ),
        backgroundColor: Color.fromRGBO(14,46,92,1),
      ),
      body: Column(

        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30),

          FutureBuilder(
            future: Future.wait([
              ApiManager.getUsers("user/"),
              // ApiManager.getMethod2("road/"),
            ]),

            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                );
              }
              if (snapshot.hasError ) {
                return Center(
                  child: Column(
                    children: [
                      Text( snapshot.error?.toString() ?? "Has Error"),
                      TextButton(onPressed: () {}, child: const Text("try again"))
                    ],
                  ),
                );
              }
              var users = (snapshot.data?[0] as UserModel).result??[];

              return
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      if(users[index].isAdmin ==true){

                        return
                          UserItem(users[index]);

                    }
                      else {
                        return SizedBox.shrink(); // Empty container example
                      }
                    },
                    itemCount: users.length,
                  ),
                );
            },
          )
        ],
      ),
      endDrawer: DrawerScreen(),
    );

  }
// Future<List<dynamic>> fetchData() async {
//   final List<Future<dynamic>> futures = [
//     CamModel(),
//     RoadModel(),
//   ];
//
//   return Future.wait(futures);
// }
}
