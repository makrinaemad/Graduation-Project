import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:graduation_project/screens/user/user_forcast/forcasting_screen.dart';

import 'package:http/http.dart'as http;

import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/constant/end_ponits.dart';
import '../../../shared/style/custom_button.dart';
import '../../../shared/style/gradient_divider.dart';
import '../../../shared/style/text_field.dart';


class ChangePasswordScreen extends StatefulWidget {
  // final String email;
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  // TextEditingController emailController = TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController newpasswordController=TextEditingController();
  TextEditingController confirmnewpasswordController= TextEditingController();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Please enter password'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  bool isLoading = false;
  //LoginController loginController=Get.put(LoginController());
  Future<void> reset() async {
    try {
      setState(() {
        // isLoading = true;
      });

      var headers = {"Content-Type": "application/json"};
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      print('Retrieved Token: $token'); // Print the token to check its value

      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      var url = Uri.parse(EndPoint.baseUrl + EndPoint.changePass);
      Map body = {
        'newpass': newpasswordController.text,
        'password': passwordController.text,
      };

      http.Response response = await http.patch(url, body: jsonEncode(body), headers: headers);
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(response.body);
        showDialog(
          context: Get.context!,
          builder: (context) {
            return const SimpleDialog(
              title: Text('Updates Successfully'),
              contentPadding: EdgeInsets.all(20),
              children: [Text('')],
            );
          },
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ForecastingScreen()),
        );

        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Profile updated Successfully')),
        // );
      } else {
        throw jsonDecode(response.body)['message'] ?? "Unknown error occurred";
      }
    } catch (error) {
      Get.back();
      showDialog(
        context: Get.context!,
        builder: (context) {
          return SimpleDialog(
            title: Text('Error'),
            contentPadding: EdgeInsets.all(20),
            children: [Text(error.toString())],
          );
        },
      );
    }
  }


  @override
  void dispose() {
    super.dispose();
    newpasswordController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 16, right: 4, left: 16),
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
                ],
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: globalFormKey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // CustomTextFormField(
                            //   labelText: 'Email',
                            //   validator: ValidEmail,
                            //   controller: emailController,
                            //   keyboardType: TextInputType.text,
                            // ),
                            //
                            // const GradientDivider(),
                            // //const CustomDivider(),
                            // const SizedBox(height: 20.0),
                            CustomTextFormField(
                              obscureText: true,
                              labelText: 'Password',
                              validator: passwordValidator,
                              controller: passwordController,
                              keyboardType: TextInputType.text,
                            ),

                            const GradientDivider(),
                            CustomTextFormField(
                              obscureText: true,
                              labelText: 'New Password',
                              validator: passwordValidator,
                              controller: newpasswordController,
                              keyboardType: TextInputType.text,
                            ),

                            const GradientDivider(),
                            //const CustomDivider(),
                            const SizedBox(
                              height: 14,
                            ),
                            CustomTextFormField(
                              obscureText: true,
                              labelText: 'Confirm New Password',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm password';
                                }
                                if (value != newpasswordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null; // Return null if validation passes
                              },
                              controller: confirmnewpasswordController,
                              keyboardType: TextInputType.text,
                            ),
                            const GradientDivider(),
                            const SizedBox(
                              height: 32,
                            ),
                            SizedBox(
                              height: 30,
                              width: 140,
                              child: CustomButton2(
                                  onTap: () {
                                    if (validateAndSave()) {
                                      reset();
                                    }
                                  },
                                  text: 'Reset'),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            // const Text(
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
