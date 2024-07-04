import '../../models/user_model.dart';

class UserState {}

final class UserInitial extends UserState {}

final class SignInSuccess extends UserState {}



final class SignInLoading extends UserState {}

final class SignInFailure extends UserState {
  final String errMessage;

  SignInFailure({required this.errMessage});
}

final class SignUpSuccess extends UserState {


  SignUpSuccess();
}

final class SignUpLoading extends UserState {}

final class SignUpFailure extends UserState {
  final String errMessage;

  SignUpFailure({required this.errMessage});
}

final class GetUserSuccess extends UserState {
  final UserModel user;

  GetUserSuccess({required this.user});
}

final class GetUserLoading extends UserState {}

final class GetUserFailure extends UserState {
  final String errMessage;

  GetUserFailure({required this.errMessage});
}
final class ForgotPasswordSuccess extends UserState {}


final class ForgotPasswordLoading extends UserState {}

final class ForgotPasswordFailure extends UserState {
  final String errMessage;

  ForgotPasswordFailure({required this.errMessage});
}
final class VerifyCodeSuccess extends UserState {}


final class VerifyCodeLoading extends UserState {}

final class VerifyCodeFailure extends UserState {
  final String errMessage;

  VerifyCodeFailure({required this.errMessage});
}
final class ResetPasswordSuccess extends UserState {}


final class ResetPasswordLoading extends UserState {}

final class ResetPasswordFailure extends UserState {
  final String errMessage;

  ResetPasswordFailure({required this.errMessage});
}
class ChangePasswordLoading extends UserState {}
class ChangePasswordSuccess extends UserState {}
class ChangePasswordFailure extends UserState {
  final String errMessage;
  ChangePasswordFailure({required this.errMessage});
}
class EditProfileLoading extends UserState {}
class EditProfileSuccess extends UserState {}
class EditProfileFailure extends UserState {
  final String errMessage;
  EditProfileFailure({required this.errMessage});
}
