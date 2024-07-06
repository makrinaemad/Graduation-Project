import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:graduation_project/screens/Authentication/signup_screen.dart';
import 'package:graduation_project/shared/constant/end_ponits.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../cache/cache_helper.dart';
import '../../models/UserModel.dart';
import '../../shared/constant/constant.dart';
import '../../shared/remote/api_manager.dart';
import '../../shared/style/button.dart';
import '../../shared/style/custom_button.dart';
import '../../shared/style/gradient_divider.dart';
import '../../shared/style/text_field.dart';
import '../admin/admin_home.dart';
import '../user/user_forcast/forcasting_screen.dart';
import 'package:get/get.dart';

import 'forget _password_screen.dart'; // Add this import for Get.put

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;

  final passwordValidator = MultiValidator([
    // RequiredValidator(errorText: 'Please enter password'),
    // MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    // PatternValidator(r'(?=.*?[#?!@$%^&*-])',
    //  errorText: 'passwords must have at least one special character')
  ]);
  final ValidEmail = MultiValidator([
    RequiredValidator(errorText: "Please enter email"),
    EmailValidator(errorText: "Enter valid email id"),
  ]);
  late String password;
  bool isLoading = false;

  Future<void> login() async {
    try {
      setState(() {
        isLoading = true;
      });
      var headers = {"Content-Type": "application/json"};

      var url = Uri.parse(EndPoint.baseUrl + EndPoint.login);
      Map body = {
        'email': emailController.text,
        'password': passwordController.text,
      };

      http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        print(response.body);
        final json = jsonDecode(response.body);
        var token = json['token'];
        print('Token: $token'); // Print the token to check its value

        // Decode the token
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        print('Decoded Token: $decodedToken'); // Print decoded token

        // Save token and ID in SharedPreferences
        await CacheHelper().saveData(key: ApiKey.token, value: token);
        await CacheHelper().saveData(key: ApiKey.id, value: decodedToken[ApiKey.id]);
        print('Token and ID saved in SharedPreferences'); // Confirm the token and ID are saved


          Result? user = await ApiManager().fetchUserByToken(token!);
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
      } else {
        throw jsonDecode(response.body)['message'] ?? "Unknown error occurred";
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Error'),
            contentPadding: EdgeInsets.all(20),
            children: [Text(error.toString())],
          );
        },
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

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
              labelText: 'Email',
              validator: ValidEmail,
              controller: emailController,
              keyboardType: TextInputType.text,
            ),
            const GradientDivider(),
            const SizedBox(height: 20.0),
            CustomTextFormField(
              obscureText: true,
              labelText: 'Password',
              validator: passwordValidator,
              controller: passwordController,
              keyboardType: TextInputType.text,
            ),
            const GradientDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgetPasswordScreen()),
                    );
                    // Implement forgot password functionality here
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  ),
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      decorationThickness: 2.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            SizedBox(
              height: 30,
              width: 140,
              child: CustomButton2(

                onTap: () {
                  if (validateAndSave()) {
                    login();

                  }

                },
                text: 'Sign in',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account?  ',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: const Text(
                    'Sign up',
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
