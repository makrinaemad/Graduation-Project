

import '../core/api/end_ponits.dart';

class UserModel {
  final String email;
  final String phone;
  final String name;
  final Map<String, dynamic> address;

  UserModel({
    required this.email,
    required this.phone,
    required this.name,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      email: jsonData['user'][ApiKey.email],
      phone: jsonData['user'][ApiKey.phone],
      name: jsonData['user'][ApiKey.name],
      address: jsonData['user'][ApiKey.address],
    );
  }
}
