import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart'as http;

import '../../shared/constant/end_ponits.dart';
import '../../shared/style/button.dart';
import '../../shared/style/custom_button.dart';
import '../../shared/style/gradient_divider.dart';
import '../../shared/style/text_field.dart';
import 'login_screen.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
   TextEditingController nameController = TextEditingController();
   TextEditingController passwordController= TextEditingController();
   TextEditingController confirmpasswordController= TextEditingController();
   TextEditingController emailController= TextEditingController();
   TextEditingController addressController= TextEditingController();
 // RegisterationController registerationController=Get.put(RegisterationController());
   bool isLoading = false;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Please enter confirm password'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);
  final ValidEmail = MultiValidator([
    RequiredValidator(errorText: "Please enter confirm email"),
    EmailValidator(errorText: "Enter valid email id"),
  ]);
   final Future <SharedPreferences>_prefs = SharedPreferences.getInstance();
  // @override
  // void initState() {
  //   super.initState();
  //   nameController = TextEditingController();
  //   emailController = TextEditingController();
  //   passwordController = TextEditingController();
  //   //phoneController = TextEditingController();
  //   confirmpasswordController = TextEditingController();
  // }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  // Future<void> register()async{
  //   try{
  //     setState(() {
  //       isLoading = true;
  //     });
  //     //var hearders ={'Content-type':'application/json'};
  //     var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.register);
  //     Map body = {
  //       'name': nameController.text,
  //       'email': emailController.text,
  //       'password': passwordController.text,
  //       'car_license':"#######",
  //       //'phone': phoneController.text,
  //     };
  //
  //       http.Response response=await http.post(url,body: jsonEncode(body));
  //       print('Response Status Code: ${response.statusCode}');
  //       print('Response Body: ${response.body}');
  //     setState(() {
  //       isLoading = false;
  //     });
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const LoginScreen(),
  //       ),
  //     );
  //
  //       // print(response.body);
  //   }
  //   catch(e){
  //     showDialog(context: Get.context!, builder: (contex){
  //       return SimpleDialog(title: Text('Error'),
  //         contentPadding: EdgeInsets.all(20),
  //         children: [Text(e.toString())],
  //       );
  //     });
  //   }
  // }
  //  Future<void> register() async {
  //    try {
  //      setState(() {
  //        isLoading = true;
  //      });
  //
  //      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.register);
  //      Map body = {
  //        'name': nameController.text,
  //        'email': emailController.text,
  //        'password': passwordController.text,
  //        'car_license':"#######",
  //      };
  //
  //      http.Response response = await http.post(url,body: jsonEncode(body));
  //      print('Response Status Code: ${response.statusCode}');
  //      print('Response Body: ${response.body}');
  //
  //      setState(() {
  //        isLoading = false;
  //      });
  //
  //      Navigator.push(
  //        context,
  //        MaterialPageRoute(
  //          builder: (context) => const LoginScreen(),
  //        ),
  //      );
  //    } catch (e) {
  //      setState(() {
  //        isLoading = false;
  //      });
  //
  //      print('Error during registration :$e');
  //      // Handle error
  //    }
  //  }

   Future<void> register() async {
     try {
       // setState(() {
       //   isLoading = true;
       // });
       var headers={'Content-Type':'application/json'};
       var url = Uri.parse(EndPoint.baseUrl + EndPoint.register);
       Map body = {
         'name': nameController.text,
         'email': emailController.text,
         'password': passwordController.text,
         'car_license':"#######",
         'address':addressController.text,
       };

       http.Response response = await http.post(url,body: jsonEncode(body),headers:headers);
       if(response.statusCode >=200 && response.statusCode <= 300){
         print(response.body);
         final json = jsonDecode(response.body);
           var token=json['data']['user']['token'];
           print(token);
           final SharedPreferences? prefs = await _prefs;
           await prefs?.setString('token', token);
           // Get.off(LoginScreen());
         Navigator.push(
           context,
           MaterialPageRoute(
             builder: (context) => LoginScreen(),
           ),
         );
       }else{
         throw jsonDecode(response.body)['message']??"Unknown Error Occurred";
       }
       print('Response Status Code: ${response.statusCode}');
       print('Response Body: ${response.body}');

     }
     catch(error){
       Get.back();
       showDialog(context: Get.context!,
        builder: (contex){
         return SimpleDialog(
           title: Text('Error'),
           contentPadding: EdgeInsets.all(20),
           children: [Text(error.toString())],
         );
     });
     }
   }

   //   setState(() {
   //     isLoading = false;
   //   });
   //
   //   if (response.statusCode == 200) {
   //     // Navigate to the login screen if the registration is successful
   //     Navigator.push(
   //       context,
   //       MaterialPageRoute(
   //         builder: (context) => const LoginScreen(),
   //       ),
   //     );
   //   } else {
   //     // Handle other response status codes if needed
   //   }
   // } catch (e) {
   //   setState(() {
   //     isLoading = false;
   //   });
   //
   //   print('Error during registration :$e');
   // Handle error
   @override
  Widget build(BuildContext context) {
    return Form(
      key: globalFormKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormField(
              labelText: 'Name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }

              },
              controller: nameController,
              keyboardType: TextInputType.text,
            ),
            const GradientDivider(),
            const SizedBox(
              height: 14,
            ),
            // CustomTextFormField(
            //   labelText: 'Phone number',
            //   controller: phoneController,
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'please enter phone number';
            //     }
            //     else{
            //       PhoneValidator();
            //     }
            //   },
            //
            //   keyboardType: TextInputType.text,
            // ),
            // const GradientDivider(),
            // const SizedBox(
            //   height: 14,
            // ),
            CustomTextFormField(
              labelText: 'Email',
              validator: ValidEmail,
              controller: emailController,
              keyboardType: TextInputType.text,
            ),
            const GradientDivider(),
            const SizedBox(
              height: 14,
            ),
            CustomTextFormField(
              labelText: 'Password',
              obscureText: true,
              validator: passwordValidator,
              controller: passwordController,
              keyboardType: TextInputType.text,
            ),
            const GradientDivider(),
            const SizedBox(
              height: 14,
            ),
            CustomTextFormField(
              obscureText: true,
              labelText: 'Confirm Password',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter confirm password';
                }
                if (value != passwordController.text) {
                  return 'Passwords do not match';
                }
                return null; // Return null if validation passes
              },
              controller: confirmpasswordController,
              keyboardType: TextInputType.text,
            ),
            const GradientDivider(),
            const SizedBox(
              height: 14,
            ),
            CustomTextFormField(
              labelText: 'address',
              validator:  (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter your address';
                }

              },
              controller: addressController,
              keyboardType: TextInputType.text,
            ),
            const GradientDivider(),
            const SizedBox(
              height: 40,
            ),

        // isLoading
        //     ? const CircularProgressIndicator(color:Color(0xff1FDEF5) ,strokeWidth : 4.0,):
            SizedBox(
              height: 30,
              width: 140,
              child:  // Show loading indicator
              CustomButton2(
                onTap: () {
                  if (validateAndSave()) {
                    register();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginScreen()),
                    // );
                  }
                },
                text: 'Sign up',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?  ',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    'Sign in',
                    style: TextStyle(color: Color(0xff1FDEF5), fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
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
