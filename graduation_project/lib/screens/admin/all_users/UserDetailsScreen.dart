import 'package:flutter/material.dart';

import '../../../models/UserModel.dart';
import '../../../shared/style/detailsItem.dart';
import '../drawer_screen.dart';

class UserDetailsScreen extends StatelessWidget {
  final Result user;

  UserDetailsScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.name}'),
          backgroundColor: Color.fromRGBO(14,46,92,1)
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          Column(
            children: [
              Image.asset(
                'assets/images/profile.png', // Add your image path here
                width: 180,
                height: 180,
              ),
              SizedBox(height: 15.0),
              buildDetailItem(  label: 'ID', value: user.id,),
              buildDetailItem(  label:'Name', value: user.name,),
              buildDetailItem( label: 'Address', value: user.address??"", ),
              buildDetailItem(  label:'Email', value: user.email,),
              buildDetailItem(  label: 'Admin', value: user.isAdmin,),
              buildDetailItem(  label: 'Premium', value:user.isPremium,),
              buildDetailItem(  label: 'Car License', value:user.carLicense??"",),
              buildDetailItem(label:'Reset Code',  value:user.resetCode??"", ),
              buildDetailItem(  label: 'Last Reset Date', value: user.lastResetDate??"",),
              buildDetailItem( label: 'Verified', value: user.isVerified ??"",),
              buildDetailItem( label: 'Avatar', value: user.avatar??"", ),
            ],
          ),

        ],
      ),
      endDrawer: DrawerScreen(),
    );
  }


}
