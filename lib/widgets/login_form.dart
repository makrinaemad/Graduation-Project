import 'dart:convert';
import 'package:arrange_gp/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/user_state.dart';

import '../screens/change_password_screen.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/forget _password_screen.dart';
import '../screens/register_screen.dart';
import 'custom_button.dart';
import 'custom_textfield.dart';
import 'gradient_divider.dart';

class LoginForm extends StatelessWidget {
   LoginForm({super.key});



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("success"),
              ),
            );
            // context.read<UserCubit>().getUserProfile();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditPasswordScreen(),
              ),
            );
          } else if (state is SignInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          }
        },
      builder: (context,state) {
        return Form(
          key: context.read<UserCubit>().signInFormKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextFormField(
                  labelText: 'Email',
                  validator: context.read<UserCubit>().ValidEmail,
                  controller: context.read<UserCubit>().signInEmail,
                  keyboardType: TextInputType.text,
                ),

                const GradientDivider(),
                //const CustomDivider(),
                const SizedBox(height: 20.0),
                CustomTextFormField(
                  obscureText: true,
                  labelText: 'Password',
                  validator: context.read<UserCubit>().passwordValidator,
                  controller: context.read<UserCubit>().signInPassword,
                  keyboardType: TextInputType.text,
                ),

                const GradientDivider(),
                //const CustomDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPasswordScreen()),
                        );
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
                state is SignInLoading
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
                        if (context.read<UserCubit>().signInValidateAndSave()) {
                          context.read<UserCubit>().signIn();
                        }
                      },
                      text: 'Sign in'),
                ),
                const SizedBox(
                  height: 30,
                ),
                // const Text(
                //   'Sign in with google account?',
                //   style: TextStyle(color: Colors.white, fontSize: 14),
                // ),
                // const SizedBox(
                //   height: 60,
                // ),
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
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()),
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
    );
  }
}
