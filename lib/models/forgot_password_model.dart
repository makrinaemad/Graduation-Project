

import '../core/api/end_ponits.dart';

class ForgotPasswordModel {
  final String message;

  ForgotPasswordModel({required this.message});
  factory ForgotPasswordModel.fromJson(Map<String, dynamic> jsonData) {
    return ForgotPasswordModel(message: jsonData[ApiKey.message]);
  }
}
