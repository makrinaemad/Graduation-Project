import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:graduation_project/screens/admin/admin_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../../models/UserModel.dart';
import '../../../shared/constant/end_ponits.dart';
import '../../../shared/remote/api_manager.dart';
import '../../../shared/style/gradient_divider.dart';
import '../../../shared/style/text_field.dart';
import '../user_forcast/forcasting_screen.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routName = "setting";
  final Result user;
  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController carLicenseController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var token;
  final ValidEmail = MultiValidator([
    RequiredValidator(errorText: "Please enter confirm email"),
    EmailValidator(errorText: "Enter valid email id"),
  ]);

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Please enter password'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);
  @override
  initState()  {
    super.initState();
 // Print the token to check its value
   // Result? user = await ApiManager().fetchUserByToken(token!);
    nameController = TextEditingController(text: widget.user?.name);

 emailController =TextEditingController(text:widget.user?.email);
     addressController = TextEditingController(text:widget.user?.address);
     carLicenseController = TextEditingController(text:widget.user?.carLicense);
   //passwordController = TextEditingController(text:user.;

  }
  Future<void> reset() async {
    try {
      setState(() {
        // isLoading = true;
      });

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token');
      print('Retrieved Token: $token');
      Result? user = await ApiManager().fetchUserByToken(token!);
      var headers = {"Content-Type": "application/json"};
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
      var url = Uri.parse(EndPoint.baseUrl + EndPoint.update);
      Map body = {
        'email': emailController.text,
        'name': nameController.text,
        'address': addressController.text,
        'car_license': carLicenseController.text,
        'password': passwordController.text      };

      http.Response response = await http.patch(url, body: jsonEncode(body), headers: headers);
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(response.body);

        if(user?.isAdmin==false){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ForecastingScreen()
          ),
        );}
        else{

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AdminHome()
            ),
          );
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Updated Successfully')),
        );

        // showDialog(
        //   context: context,
        //   builder: (context) {
        //     return const SimpleDialog(
        //       title: Text('Updated Successfully'),
        //       contentPadding: EdgeInsets.all(20),
        //       children: [Text('')],
        //     );
        //   },
        // );
      } else {
        throw jsonDecode(response.body)['message'] ?? "Unknown error occurred";
      }
    } catch (error) {
     // Get.back();
      showDialog(
        context: context!,
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color.fromRGBO(14, 46, 92, 1),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100, // Adjust width to make the button larger
                        height: 120,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/images/profile.png"), // <-- BACKGROUND IMAGE
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      CustomTextFormField(
                        labelText: 'name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        textColor:  Color.fromRGBO(14,46,92,1),
                      ),
                      const GradientDivider(),
                      SizedBox(height: 10,),
                      CustomTextFormField(
                        labelText: 'Email',
                        validator: ValidEmail,
                        controller: emailController,
                        keyboardType: TextInputType.text,
                        textColor:  Color.fromRGBO(14,46,92,1),
                      ),
                      const GradientDivider(),
                      SizedBox(height: 10,),
                      CustomTextFormField(
                        labelText: 'address',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                        controller: addressController,
                        keyboardType: TextInputType.text,
                        textColor:  Color.fromRGBO(14,46,92,1),
                      ),
                      const GradientDivider(),
                      SizedBox(height: 10,),
                      // const SizedBox(
                      //   height: 14,
                      // ),
                      CustomTextFormField(
                        labelText: 'car license',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your car license';
                          }
                          return null;
                        },
                        controller: carLicenseController,
                        keyboardType: TextInputType.text,
                        textColor:  Color.fromRGBO(14,46,92,1),
                      ),

                      const GradientDivider(),
                      CustomTextFormField(
                        obscureText: true,
                        labelText: 'Password',
                        validator: passwordValidator,
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        textColor:  Color.fromRGBO(14,46,92,1),

                      ),

                      const GradientDivider(),
                      SizedBox(height: 10,),// Use the GradientDivider here
                      SizedBox(height: 90),
                      ElevatedButton(
                        onPressed: (){
                          reset();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff0E2F5C),
                          textStyle: const TextStyle(color: Colors.white),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                        child: const Text(
                          'Update',
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
