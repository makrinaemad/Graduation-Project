import 'dart:convert';

import 'package:arrange_gp/screens/register_screen.dart';
import 'package:arrange_gp/screens/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/user cubit/user_cubit.dart';
import '../cubit/user cubit/user_state.dart';
import '../widgets/custom_button.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OTPScreen extends StatelessWidget {
  final String email;
  const OTPScreen({super.key, required this.email});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
            listener: (context, state) {
              if (state is VerifyCodeSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("success"),
                  ),
                );
                // context.read<UserCubit>().getUserProfile();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResetPasswordScreen(email: context.read<UserCubit>().forgotPasswordEmail.text),
                  ),
                );
              } else if (state is VerifyCodeFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errMessage),
                  ),
                );
              }
            },
      builder: (context,state) {
        return Scaffold(
          body: SafeArea(
            child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.jpg'),
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
                                context.read<UserCubit>().verifyCode(code);
                                print("OTP is => $code");

                              },
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            TextButton(
                              onPressed: () {
                              },
                              child: const Text(
                                'Resend in 50 seconds',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            state is VerifyCodeLoading
                                ? const SizedBox(
                              height:20,
                              width:20,
                              child: CircularProgressIndicator(color:Colors.white),
                            ):
                            SizedBox(
                                height: 30,
                                width: 140,
                                child: CustomButton(onTap: () {}, text: 'Confirm')),
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        );
      }
    );
  }
}
