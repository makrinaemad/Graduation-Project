import 'dart:convert';

import 'package:arrange_gp/screens/forget_password_otp.dart';
import 'package:arrange_gp/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/gradient_divider.dart';

class ForgetPasswordScreen extends StatelessWidget {
   ForgetPasswordScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("success"),
              ),
            );
            // context.read<UserCubit>().getUserProfile();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  OTPScreen(email: context.read<UserCubit>().forgotPasswordEmail.text),
              ),
            );
          } else if (state is ForgotPasswordFailure) {
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
                          key: context.read<UserCubit>().forgotPasswordFormKey,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Enter your email to send a verification code to it',style:TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize:16),),
                                const SizedBox(
                                  height: 30,
                                ),
                                CustomTextFormField(
                                  labelText: 'Email',
                                  validator: context.read<UserCubit>().ValidEmail,
                                  controller: context.read<UserCubit>().forgotPasswordEmail,
                                  keyboardType: TextInputType.text,
                                ),
                                const GradientDivider(),
                                const SizedBox(
                                  height: 40,
                                ),
                                state is ForgotPasswordLoading
                                    ? const SizedBox(
                                  height:20,
                                  width:20,
                                  child: CircularProgressIndicator(color:Colors.white),
                                ):
                                SizedBox(
                                  height: 30,
                                  width: 140,
                                  child:  // Show loading indicator
                                  CustomButton(
                                    onTap: () {
                                      if (context.read<UserCubit>().forgotPasswordValidateAndSave()) {
                                        context.read<UserCubit>().forgetPassword();
                                        //register();
                                      }
                                    },
                                    text: 'Send',
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
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
