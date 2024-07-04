import 'dart:convert';
import 'package:arrange_gp/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../cubit/user cubit/user_cubit.dart';
import '../cubit/user cubit/user_state.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/gradient_divider.dart';
import 'login_screen.dart';

class ChangePasswordScreen extends StatelessWidget {
  // final String email;
   ChangePasswordScreen({super.key});

  TextEditingController confirmnewpasswordController= TextEditingController();




  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
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
          } else if (state is ChangePasswordFailure) {
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
                          key: context.read<UserCubit>().changePasswordFormKey,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomTextFormField(
                                  obscureText: true,
                                  labelText: 'Password',
                                  validator: context.read<UserCubit>().passwordValidator,
                                  controller: context.read<UserCubit>().changePasswordCurrentPass,
                                  keyboardType: TextInputType.text,
                                ),

                                const GradientDivider(),
                                CustomTextFormField(
                                  obscureText: true,
                                  labelText: 'New Password',
                                  validator: context.read<UserCubit>().passwordValidator,
                                  controller: context.read<UserCubit>().changePasswordNewPass,
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
                                    if (value != context.read<UserCubit>().changePasswordNewPass.text) {
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
                                state is ChangePasswordLoading
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
                                        if (context.read<UserCubit>().changePasswordValidateAndSave()) {
                                          context.read<UserCubit>().changePassword();
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
