import 'package:flutter/material.dart';

import '../../../models/UserModel.dart';
import '../drawer_screen.dart';

class UserDetailsScreen extends StatelessWidget {
  final Result user;

  UserDetailsScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
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
              _buildDetailItem('ID', user.id),
              _buildDetailItem('Name', user.name),
              _buildDetailItem('Address', user.address),
              _buildDetailItem('Email', user.email),
              _buildDetailItem('Admin', user.isAdmin??"null" ),
              _buildDetailItem('Premium', user.isPremium??"null" ),
              _buildDetailItem('Car License', user.carLicense),
              _buildDetailItem('Reset Code', user.resetCode),
              _buildDetailItem('Last Reset Date', user.lastResetDate),
              _buildDetailItem('Verified', user.isVerified ??"null"),
              _buildDetailItem('Avatar', user.avatar),
            ],
          ),

        ],
      ),
      endDrawer: DrawerScreen(),
    );
  }

  Widget _buildDetailItem(String label, var value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
            ),
          ),
          SizedBox(width: 15.0),
          Expanded(
            flex: 3,
            child: Text(value.toString(),
                style: TextStyle(fontSize: 15),),

          ),
        ],
      ),
    );
  }
}
