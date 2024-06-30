import 'dart:convert';
import 'package:graduation_project/models/CamModel.dart';
import 'package:graduation_project/models/UserModel.dart';
import 'package:http/http.dart'as http;
import '../../models/CamRoadModel.dart';
import '../../models/PlanModel.dart';
import '../../models/RoadModel.dart';
import '../constant/constant.dart';
class ApiManager{
  static Future<CamModel> getCameras(String endPoint)async{
    try{
      Uri url=Uri.https(Base,endPoint
            );
      http.Response response=await http.get(url,headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
     );
      var jsonData=jsonDecode(response.body);
      CamModel Response=CamModel.fromJson(jsonData);

      return Response;}

    catch(e){
      throw(e);
    }

  }
  static Future<PlanModel> getPlans()async{
    String  endPoint="subscription/getPlans";
    try{
      Uri url=Uri.https(Base,endPoint
      );
      http.Response response=await http.get(url,headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      );
      var jsonData=jsonDecode(response.body);
      PlanModel Response=PlanModel.fromJson(jsonData);

      return Response;}

    catch(e){
      throw(e);
    }

  }
  // static Future<CamRoadModel> getSpecificCamera(String endPoint)async{
  //   try{
  //     Uri url=Uri.https(Base,endPoint
  //     );
  //     http.Response response=await http.get(url,headers: {
  //       "Content-Type": "application/json",
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //     );
  //     var jsonData=jsonDecode(response.body);
  //     CamRoadModel Response=CamRoadModel.fromJson(jsonData);
  //
  //     return Response;}
  //
  //   catch(e){
  //     throw(e);
  //   }
  //
  // }
  static Future<CamRoadModel> getSpecificCamera(String endPoint) async {
    try {
      Uri url = Uri.https(Base, endPoint);
      http.Response response = await http.get(url, headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      var jsonData = jsonDecode(response.body);
      CamRoadModel camRoadModel = CamRoadModel.fromJson(jsonData);
      return camRoadModel;
    } catch (e) {
      throw e;
    }
  }


  static Future<RoadModel> getSpecificRoad(String endPoint) async {
    try {
      Uri url = Uri.https(Base, endPoint);
      http.Response response = await http.get(url, headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print('API response: $jsonData');  // Debug: Print the API response
        RoadModel roadModel = RoadModel.fromJson2(jsonData);
        return roadModel;
      } else {
        print('Failed to load road: ${response.statusCode}');  // Debug: Print error code
        throw Exception('Failed to load road');
      }
    } catch (e) {
      print('Error: $e');  // Debug: Print the error
      throw e;
    }
  }

  static Future<List<RoadModel>> getRoads(String endPoint) async {
    try {
      Uri url = Uri.https(Base, endPoint); // Replace 'your_base_url_here' with your actual base URL
      http.Response response = await http.get(url, headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        return parseRoadModels(response.body);
      } else {
        print('Failed to load road models: ${response.reasonPhrase}');
        throw Exception('Failed to load road models: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Failed to load road models: $e');
      throw Exception('Failed to load road models: $e');
    }
  }

  static List<RoadModel> parseRoadModels(String responseBody) {
    final parsed = jsonDecode(responseBody) as List<dynamic>;
    return parsed.map<RoadModel>((json) => RoadModel.fromJson(json)).toList();
  }
  static Future<void> PostRoad(RoadModel road) async {

    // Convert RoadModel instance to JSON
    Map<String, dynamic> jsonData = road.toJson();
    Uri url = Uri.https(Base, 'road/add');
    // Send POST request
    try {
      var response = await http.post(
          url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 201) {
        print('Road created successfully');
      } else {
        print('Failed to create road. Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }
  static Future<void> deleteRoad(int id) async {

    Uri url = Uri.https(Base,'road/$id');
    try {
      var response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('Road with id $id deleted successfully');
      } else {
        print('Failed to delete road with id $id. Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }
  static Future<void> deleteCamera(int id) async {

    Uri url = Uri.https(Base,'camera/$id');
    try {
      var response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('Camera with id $id deleted successfully');
      } else {
        print('Failed to delete camera with id $id. Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }

  static Future<void> updateRoad(RoadModel updatedRoad) async {
    Map<String, dynamic> jsonData = updatedRoad.toJson();
    Uri url = Uri.https(Base,'road/update/${updatedRoad.id}');
     // Assuming API endpoint structure
    final response = await http.patch(
      url,
     // body: updatedRoad.toJson(), // Convert RoadModel to JSON for sending

    headers: <String, String> {'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',},
      body: jsonEncode(jsonData),
    );

    if (response.statusCode == 200) {
      // Road updated successfully
    } else {
      // Handle error if update fails
      throw Exception('Failed to update road');
    }
  }

  static Future<void> updateCamera(Camera updatedCamera) async {
    try {
      Map<String, dynamic> jsonData = updatedCamera.toJsonupdate();
      Uri url = Uri.https(Base, '/road/camera/update/${updatedCamera.id}');

      print("URL: $url");
      print("Headers: ${{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      }}");
      print("Body: $jsonData");

      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 200) {
        print("Camera updated successfully");
      } else {
        print('Failed to update camera. Error ${response.statusCode}: ${response.body}');
        throw Exception('Failed to update camera. Server responded with code ${response.statusCode}');
      }
    } catch (e) {
      print('Exception caught: $e');
      throw Exception('Failed to update camera');
    }
  }

  static Future<void> PostCam(Camera camera) async {
    Map<String, dynamic> jsonData = camera.toJson();
    Uri url = Uri.https(Base, 'camera/add');

    try {
      // Validate required fields
      if (camera.model == null || camera.model!.isEmpty) {
        print("Invalid camera model: ${camera.model}");
        throw Exception("Camera model cannot be null or empty");
      }
      if (camera.road_id == null) {
        print("Invalid road ID: ${camera.road_id}");
        throw Exception("Road ID cannot be null");
      }
      if (camera.active == null) {
        print("Invalid active status: ${camera.active}");
        throw Exception("Active status cannot be null");
      }

      // Additional detailed logging
      print("Sending JSON data: ${jsonEncode(jsonData)}");

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 201) {
        print('Camera added successfully');
      } else {
        print('Failed to add camera. Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }



  static Future<UserModel> getUsers(String endPoint)async{
    try{
      Uri url=Uri.https(Base,endPoint
      );
      http.Response response=await http.get(url,headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      );
      var jsonData=jsonDecode(response.body);
      UserModel Response=UserModel.fromJson(jsonData);

      return Response;}

    catch(e){
      throw(e);
    }

  }

  // static Future<Result> createAdmin(Result user) async {
  //   final response = await http.post(
  //     Uri.parse('$Base/user/Admins'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization': 'Bearer $token',
  //     },
  //     body: jsonEncode(user.toJson()),
  //   );
  //
  //   if (response.statusCode == 201) {
  //     print('Camera added successfully');
  //   } else {
  //     print('Failed to create user Error ${response.statusCode}: ${response.body}');
  //   }
  // }
  static Future<void> createAdmin(Result road) async {

    // Convert RoadModel instance to JSON
    Map<String, dynamic> jsonData = road.toJson();
    Uri url = Uri.https(Base, 'user/Admins');
    // Send POST request
    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 200) {
        print('Road created successfully');
      } else {
        print('Failed to create road. Error ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }
}

