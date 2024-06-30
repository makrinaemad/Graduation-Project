import 'dart:convert';
import 'package:arrange_gp/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:http/http.dart'as http;
import 'package:form_field_validator/form_field_validator.dart';
import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/gradient_divider.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
   ResetPasswordScreen( {super.key, required this.email});

  TextEditingController confirmpasswordController= TextEditingController();


  // final ValidEmail = MultiValidator([
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("success"),
              ),
            );
            // context.read<UserCubit>().getUserProfile();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          } else if (state is ResetPasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          }
        },
      builder: (context,state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
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
                              'assets/images/only_logo.png',
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
                          key: context.read<UserCubit>().resetPasswordFormKey,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomTextFormField(
                                  obscureText: true,
                                  labelText: 'New Password',
                                  validator: context.read<UserCubit>().passwordValidator,
                                  controller: context.read<UserCubit>().resetPasswordPass,
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
                                      return 'Please enter confirm password';
                                    }
                                    if (value != context.read<UserCubit>().resetPasswordPass.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null; // Return null if validation passes
                                  },
                                  controller: confirmpasswordController,
                                  keyboardType: TextInputType.text,
                                ),
                                const GradientDivider(),
                                const SizedBox(
                                  height: 32,
                                ),
                                state is ResetPasswordLoading
                                    ? const SizedBox(
                                  height:20,
                                  width:20,
                                  child: CircularProgressIndicator(color:Colors.white),
                                ):
                                SizedBox(
                                  height: 30,
                                  width: 140,
                                  child: CustomButton(
                                      onTap: () {
                                        if (context.read<UserCubit>().resetPasswordValidateAndSave()) {
                                          context.read<UserCubit>().resetPassword(email:email);
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
    );
  }
}
