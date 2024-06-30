

import '../core/api/end_ponits.dart';

class LoginModel {
  final String token;
  //final String message;
  final String name;
  final String email;
  final String address;
  final String car_license;
  final String reset_date;
  final bool admin;
  LoginModel({required this.email, required this.address, required this.car_license, required this.admin, required this.reset_date, required this.token, required this.name});

  factory LoginModel.fromJson(Map<String, dynamic> jsonData) {
    return LoginModel(
      name:jsonData[ApiKey.name],
      email:jsonData[ApiKey.email],
      address:jsonData[ApiKey.address],
      car_license:jsonData[ApiKey.car_license],
      admin:jsonData[ApiKey.admin],
      reset_date:jsonData[ApiKey.reset_date],
      //message: jsonData[ApiKey.message],
      token: jsonData[ApiKey.token],
    );
  }
}
