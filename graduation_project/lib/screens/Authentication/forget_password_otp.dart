import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:graduation_project/screens/Authentication/reset_password_screen.dart';

import 'package:http/http.dart'as http;

import '../../shared/constant/end_ponits.dart';
import '../../shared/style/custom_button.dart';

class OTPScreen extends StatelessWidget {
  final String email;
  const OTPScreen({super.key, required this.email});


  Future<void> verifyCode(var code) async {
    try {
      var hearders ={"Content-Type": "application/json",};

      var url = Uri.parse(EndPoint.baseUrl + EndPoint.verifyCode);
      Map body = {
        'code': code,
        //'name':'name',
      };

      http.Response response = await http.post(url,body: jsonEncode(body),headers: hearders);
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if(response.statusCode >=200 && response.statusCode <= 300){
        print(response.body);
        final json = jsonDecode(response.body);
        // var token=json['token'];
        // final SharedPreferences? prefs=await _prefs;
        // await prefs?.setString('token', token);
     //   Get.off(ResetPasswordScreen(email: email));
      }
      else{
        throw jsonDecode(response.body)['message']??"unKnown error occurred";
      }
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

    }
    catch(error){
      Get.back();
      showDialog(context: Get.context!, builder: (contex){
        return SimpleDialog(title: Text('Error'),
          contentPadding: EdgeInsets.all(20),
          children: [Text(error.toString())],
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 25, bottom: 16, right: 4, left: 7),
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 80,
                            width: 80,
                          ),
                        ),
                        const Column(
                          children: [
                            Text(
                              'TRAFFIC',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "CodeDemo",
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'DETECTOR',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "CodeDemo",
                                color: Color(0xff3FBEDA),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          //32 150
                          height: 32,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.height * 0.17,
                          ),
                          child: const Text(
                            'Confirmation code',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        OtpTextField(
                          numberOfFields: 6,
                          borderColor: const Color(0xff076092),
                          cursorColor: const Color(0xff076092),
                          focusedBorderColor: const Color(0xff076092),
                          margin: const EdgeInsets.only(right: 10.0),
                          textStyle: const TextStyle(
                              color: Color(0xff076092), fontSize: 18),
                          fillColor: Colors.white,
                          showFieldAsBox: true,
                          filled: true,
                          onCodeChanged: (String code) {},
                          onSubmit: (code) {
                            verifyCode( code);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  ResetPasswordScreen(email: email,),
                            ));
                            print("OTP is => $code");

                          },
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        // TextButton(
                        //   onPressed: () {
                        //
                        //   },
                        //   child: const Text(
                        //     'Resend in 50 seconds',
                        //     style: TextStyle(color: Colors.white),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 32,
                        // ),
                        SizedBox(
                            height: 30,
                            width: 140,
                            child: CustomButton2(onTap: () {


                            }, text: 'Confirm')),
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
