

import '../core/api/end_ponits.dart';

class ChangePasswordModel {
  final String message;

  ChangePasswordModel({required this.message});
  factory ChangePasswordModel.fromJson(Map<String, dynamic> jsonData) {
    return ChangePasswordModel(message: jsonData[ApiKey.message]);
  }
}
