

import '../core/api/end_ponits.dart';

class VerifyCodeModel {
  final String message;

  VerifyCodeModel({required this.message});
  factory VerifyCodeModel.fromJson(Map<String, dynamic> jsonData) {
    return VerifyCodeModel(message: jsonData[ApiKey.message]);
  }
}
