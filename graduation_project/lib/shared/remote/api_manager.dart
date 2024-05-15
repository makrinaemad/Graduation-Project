import 'dart:convert';

import 'package:graduation_project/models/CamModel.dart';
import 'package:http/http.dart'as http;

import '../constant/constant.dart';
class ApiManager{
  static Future<CamModel> getMethod(String endPoint)async{
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


}