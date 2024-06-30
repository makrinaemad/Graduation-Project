import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cache/cache_helper.dart';
import '../core/api/api_consumer.dart';
import '../core/api/end_ponits.dart';
import '../core/errors/exceptions.dart';
import '../models/change_password_model.dart';
import '../models/edit_profile_model.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';
import '../models/forgot_password_model.dart';
import '../models/reset_password_model.dart';
import '../models/user_model.dart';
import '../models/verify_code_model.dart';

class UserRepository {
  final ApiConsumer api;

  UserRepository({required this.api});
  Future<Either<String, LoginModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.post(
        EndPoint.login,
        data: {
          ApiKey.email: email,
          ApiKey.password: password,
        },
      );
      final user = LoginModel.fromJson(response);
      final decodedToken = JwtDecoder.decode(user.token);
      CacheHelper().saveData(key: ApiKey.token, value: user.token);
      CacheHelper().saveData(key: ApiKey.id, value: decodedToken[ApiKey.id]);
      return Right(user);
    } on ServerException catch (e) {
      return Left(e.errModel.message);
    }
  }
  Future<Either<String, RegisterModel>> SignUp({
    required String name,
    required String email,
    required String password,
    required String address,
    required String car_license,
  }) async {
    try {
      final response = await api.post(
        EndPoint.register,
        data: {
          ApiKey.email: email,
          ApiKey.password:password,
          ApiKey.address:address,
          ApiKey.name:name,
          ApiKey.car_license:car_license
        },
      );
      final signUpModel = RegisterModel.fromJson(response);
      return Right(signUpModel);
    } on ServerException catch (e) {
      return Left(e.errModel.message);
    }
  }
  // Future<Either<String, RegisterModel>> signUp({
  //   required String name,
  //   required String email,
  //   required String password,
  //   required String address,
  //   required String car_license,
  // }) async {
  //   try {
  //     final response = await api.post(
  //       EndPoint.register,
  //       isFromData: true,
  //       data: {
  //         'name': name,
  //         'email': email,
  //         'password': password,
  //         'address': address,
  //         'car_license': car_license,
  //       },
  //     );
  //
  //     print('Response: $response'); // Log the response for debugging
  //
  //     // Check if the response is null
  //     if (response == null) {
  //       return Left('Server returned null response');
  //     }
  //
  //     // Parse the JSON response to RegisterModel
  //     final signUpModel = RegisterModel.fromJson(response);
  //     return Right(signUpModel);
  //   } on ServerException catch (e) {
  //     return Left(e.errModel.message);
  //   } catch (e) {
  //     return Left('An unknown error occurred: $e');
  //   }
  // }


  Future<Either<String, ForgotPasswordModel>> ForgotPassword({
    required String email,
  }) async {
    try {
      final response = await api.post(
        EndPoint.forgot,
        data: {
          ApiKey.email: email,
        },
      );
      final forgotPasswordModel = ForgotPasswordModel.fromJson(response);
      return Right(forgotPasswordModel);
    } on ServerException catch (e) {
      return Left(e.errModel.message);
    }
  }
  Future<Either<String, VerifyCodeModel>> verifyCode({
    required var code,
  }) async {
    try {
      final response = await api.post(
        EndPoint.verifyCode,
        data: {
          ApiKey.code: code,
        },
      );
      final verifyCodeModel = VerifyCodeModel.fromJson(response);
      return Right(verifyCodeModel);
    } on ServerException catch (e) {
      return Left(e.errModel.message);
    }
  }
  Future<Either<String, ResetPasswordModel>> resetPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.put(
        EndPoint.resetPass,
        data: {
          ApiKey.email:email,
          ApiKey.password: password,
        },
      );
      final resetPasswordModel = ResetPasswordModel.fromJson(response);
      return Right(resetPasswordModel);
    } on ServerException catch (e) {
      return Left(e.errModel.message);
    }
  }

  Future<Either<String, ChangePasswordModel>> changePassword({
    required String newPassword,
    required String currentPassword,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      if (token == null) {
        return Left("Token is missing");
      }

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      final response = await api.patch(
        EndPoint.changePass,
        data: {
          'newpass': newPassword,
          'password': currentPassword,
        },
        headers: headers,
      );

      final changePasswordModel = ChangePasswordModel.fromJson(response);
      return Right(changePasswordModel);
    } on ServerException catch (e) {
      return Left(e.errModel.message);
    }
  }
  Future<Either<String, EditProfileModel>> editProfile({
    required String password,
    required String email,
    required String car_license,
    required String address,
    required String name,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      if (token == null) {
        return Left("Token is missing");
      }

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      final response = await api.patch(
        EndPoint.update,
        data: {
          'name': name,
          'password': password,
          'email':email,
          'address':address,
          'car_license':car_license,
        },
        headers: headers,
      );

      final editProfileModel = EditProfileModel.fromJson(response);
      return Right(editProfileModel);
    } on ServerException catch (e) {
      return Left(e.errModel.message);
    }
  }

}


