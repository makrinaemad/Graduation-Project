import 'package:arrange_gp/cubit/user%20cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/login_model.dart';
import '../../repositories/user_repository.dart';
import 'package:form_field_validator/form_field_validator.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userRepository) : super(UserInitial());
  final UserRepository userRepository;

  //Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();
  GlobalKey<FormState> verifyCodeFormKey = GlobalKey();
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey();
  GlobalKey<FormState> resetPasswordFormKey = GlobalKey();
  GlobalKey<FormState> changePasswordFormKey = GlobalKey();
  GlobalKey<FormState> editProfileFormKey = GlobalKey();
  TextEditingController resetPasswordEmail = TextEditingController();
  TextEditingController resetPasswordPass = TextEditingController();
  TextEditingController verifcationCode = TextEditingController();
  //Sign in email
  TextEditingController signInEmail = TextEditingController();
  TextEditingController forgotPasswordEmail = TextEditingController();
  //Sign in password
  TextEditingController signInPassword = TextEditingController();

  //Sign Up Form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();

  //Sign up name
  TextEditingController signUpName = TextEditingController();

  //Sign up phone number
  TextEditingController signUpAddress = TextEditingController();
  TextEditingController signUpCarLicense = TextEditingController();

  //Sign up email
  TextEditingController signUpEmail = TextEditingController();

  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  TextEditingController signUpConfirmPassword = TextEditingController();
  TextEditingController changePasswordCurrentPass = TextEditingController();

  //Sign up password
  TextEditingController changePasswordNewPass = TextEditingController();

  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController editProfilePassword = TextEditingController();
  TextEditingController editProfileName = TextEditingController();
  TextEditingController editProfileemail = TextEditingController();

  //Sign up password
  TextEditingController editProfileCarLicense = TextEditingController();

  //Sign up confirm password
  TextEditingController editProfileAddress = TextEditingController();
  LoginModel? user;
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Please enter password'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  final ValidEmail = MultiValidator([
    RequiredValidator(errorText: "Please enter email"),
    EmailValidator(errorText: "Enter valid email id"),
  ]);



  signUp() async {
    emit(SignUpLoading());
    final response = await userRepository.SignUp(
      name: signUpName.text,
      address: signUpAddress.text,
      email: signUpEmail.text,
      password: signUpPassword.text,
      car_license: signUpCarLicense.text,
    );
    response.fold(
          (errMessage) => emit(SignUpFailure(errMessage: errMessage)),
          (registerModel) => emit(SignUpSuccess()),
    );
  }


  signIn() async {
    emit(SignInLoading());
    final response = await userRepository.signIn(
      email: signInEmail.text,
      password: signInPassword.text,
    );
    response.fold(
      (errMessage) => emit(SignInFailure(errMessage: errMessage)),
      (signInModel) => emit(SignInSuccess()),
    );
  }

  forgetPassword() async {
    emit(ForgotPasswordLoading());
    final response = await userRepository.ForgotPassword(
      email: forgotPasswordEmail.text,
    );
    response.fold(
      (errMessage) => emit(ForgotPasswordFailure(errMessage: errMessage)),
      (forgotPasswordModel) => emit(ForgotPasswordSuccess()),
    );
  }

  verifyCode(String code) async {
    emit(VerifyCodeLoading());
    final response = await userRepository.verifyCode(
      code: code,
    );
    response.fold(
      (errMessage) => emit(VerifyCodeFailure(errMessage: errMessage)),
      (verifyCodeModel) => emit(VerifyCodeSuccess()),
    );
  }

  resetPassword({required String email}) async {
    emit(ResetPasswordLoading());
    final response = await userRepository.resetPassword(
      password: resetPasswordPass.text,
      email: email,
    );
    response.fold(
      (errMessage) => emit(ResetPasswordFailure(errMessage: errMessage)),
      (resetPasswordModel) => emit(ResetPasswordSuccess()),
    );
  }
  changePassword() async {
    emit(ChangePasswordLoading());
    final response = await userRepository.changePassword(
      newPassword: changePasswordNewPass.text,
      currentPassword: changePasswordCurrentPass.text,
    );
    response.fold(
          (errMessage) => emit(ChangePasswordFailure(errMessage: errMessage)),
          (changePasswordModel) => emit(ChangePasswordSuccess()),
    );
  }
  editProfile() async {
    emit(EditProfileLoading());
    final response = await userRepository.editProfile(
      password: editProfilePassword.text, email: editProfileemail.text, car_license: editProfileCarLicense.text, address: editProfileAddress.text, name: editProfileName.text,
    );
    response.fold(
          (errMessage) => emit(EditProfileFailure(errMessage: errMessage)),
          (changePasswordModel) => emit(EditProfileSuccess()),
    );
  }

  bool signInValidateAndSave() {
    final form = signInFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  bool signUpValidateAndSave() {
    final form = signUpFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  bool forgotPasswordValidateAndSave() {
    final form = forgotPasswordFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  bool resetPasswordValidateAndSave() {
    final form = resetPasswordFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
  bool changePasswordValidateAndSave() {
    final form = changePasswordFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
  bool editProfileValidateAndSave() {
    final form = editProfileFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
