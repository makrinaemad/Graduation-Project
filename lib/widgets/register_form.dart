import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';
import '../screens/login_screen.dart';
import 'custom_button.dart';
import 'custom_textfield.dart';
import 'gradient_divider.dart';

class RegisterForm extends StatelessWidget {
    RegisterForm({super.key});

   TextEditingController confirmpasswordController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Success"),
            ));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          } else if (state is SignUpFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errMessage),
            ));
          }
        },
        builder: (context, state) {
          return Form(
            key: context.read<UserCubit>().signUpFormKey,
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
                      return null;
                    },
                    controller: context.read<UserCubit>().signUpName,
                    keyboardType: TextInputType.text,
                  ),
                  const GradientDivider(),
                  const SizedBox(height: 14),
                  CustomTextFormField(
                    labelText: 'Email',
                    validator: context.read<UserCubit>().ValidEmail,
                    controller: context.read<UserCubit>().signUpEmail,
                    keyboardType: TextInputType.text,
                  ),
                  const GradientDivider(),
                  const SizedBox(height: 14),
                  CustomTextFormField(
                    labelText: 'Password',
                    obscureText: true,
                    validator: context.read<UserCubit>().passwordValidator,
                    controller: context.read<UserCubit>().signUpPassword,
                    keyboardType: TextInputType.text,
                  ),
                  const GradientDivider(),
                  const SizedBox(height: 14),
                  CustomTextFormField(
                    obscureText: true,
                    labelText: 'Confirm Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter confirm password';
                      }
                      if (value != context.read<UserCubit>().signUpPassword.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    controller: context.read<UserCubit>().signUpConfirmPassword,
                    keyboardType: TextInputType.text,
                  ),
                  const GradientDivider(),
                  const SizedBox(height: 14),
                  CustomTextFormField(
                    labelText: 'Address',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                    controller: context.read<UserCubit>().signUpAddress,
                    keyboardType: TextInputType.text,
                  ),
                  const GradientDivider(),
                  const SizedBox(height: 14),
                  CustomTextFormField(
                    labelText: 'Car License',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your car license';
                      }
                      return null;
                    },
                    controller: context.read<UserCubit>().signUpCarLicense,
                    keyboardType: TextInputType.text,
                  ),
                  const GradientDivider(),
                  const SizedBox(height: 40),
                  state is SignUpLoading
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
                        if (context.read<UserCubit>().signUpValidateAndSave()) {
                          context.read<UserCubit>().signUp();
                        }
                      },
                      text: 'Sign up',
                    ),
                  ),
                  const SizedBox(height: 30),
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
    );
  }
}
