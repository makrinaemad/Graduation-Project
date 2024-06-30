import 'dart:convert';
import 'package:arrange_gp/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/gradient_divider.dart';
import 'login_screen.dart';

class EditPasswordScreen extends StatelessWidget {
  // final String email;
  EditPasswordScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is EditProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("success"),
              ),
            );
            // context.read<UserCubit>().getUserProfile();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegisterScreen(),
              ),
            );
          } else if (state is EditProfileFailure) {
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
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     SizedBox(
                    //       height: MediaQuery.of(context).size.height * 0.05,
                    //     ),
                    //     Row(
                    //       children: [
                    //         Padding(
                    //           padding: const EdgeInsets.only(
                    //               top: 16, bottom: 16, right: 4, left: 16),
                    //           child: Image.asset(
                    //             'assets/images/only_logo.png',
                    //             height: 80,
                    //             width: 80,
                    //           ),
                    //         ),
                    //         const Column(
                    //           children: [
                    //             Text(
                    //               'TRAFFIC',
                    //               style: TextStyle(
                    //                 fontSize: 20,
                    //                 fontFamily: "CodeDemo",
                    //                 color: Colors.white,
                    //               ),
                    //             ),
                    //             Text(
                    //               'DETECTOR',
                    //               style: TextStyle(
                    //                 fontSize: 16,
                    //                 fontFamily: "CodeDemo",
                    //                 color: Color(0xff3FBEDA),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Form(
                            key: context.read<UserCubit>().editProfileFormKey,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
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
                                    controller: context.read<UserCubit>().editProfileName,
                                    keyboardType: TextInputType.text,
                                  ),
                                  const GradientDivider(),
                                  CustomTextFormField(
                                    labelText: 'Email',
                                    validator: context.read<UserCubit>().ValidEmail,
                                    controller: context.read<UserCubit>().editProfileemail,
                                    keyboardType: TextInputType.text,
                                  ),
                                  const GradientDivider(),
                                  CustomTextFormField(
                                    labelText: 'address',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your address';
                                      }
                                      return null;
                                    },
                                    controller: context.read<UserCubit>().editProfileAddress,
                                    keyboardType: TextInputType.text,
                                  ),
                                  const GradientDivider(),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  CustomTextFormField(
                                    labelText: 'car license',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your car license';
                                      }
                                      return null;
                                    },
                                    controller: context.read<UserCubit>().editProfileCarLicense,
                                    keyboardType: TextInputType.text,
                                  ),
                                  const GradientDivider(),
                                  CustomTextFormField(
                                    obscureText: true,
                                    labelText: 'Password',
                                    validator: context.read<UserCubit>().passwordValidator,
                                    controller: context.read<UserCubit>().editProfilePassword,
                                    keyboardType: TextInputType.text,
                                  ),

                                  const GradientDivider(),// Use the GradientDivider here
                                  SizedBox(height: 90),
                                  state is EditProfileLoading
                                      ? const SizedBox(
                                    height:20,
                                    width:20,
                                    child: CircularProgressIndicator(color:Colors.white),
                                  ):
                                  ElevatedButton(
                                    onPressed: (){
                                      if (context.read<UserCubit>().editProfileValidateAndSave()) {
                                        context.read<UserCubit>().editProfile();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:  Colors.white,
                                      textStyle: const TextStyle(color: Color(0xff0E2F5C)),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    ),
                                    child: const Text(
                                      'Update',
                                      style: TextStyle(color: Color(0xff0E2F5C), fontSize: 16),
                                    ),
                                  ),
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

