import 'package:clinic_booking_app/models/user_model.dart';

abstract class LoginAndRegisterStates {}

class LoginAndRegisterInitialState extends LoginAndRegisterStates {}

class RegisterLoadingState extends LoginAndRegisterStates {}

class RegisterSuccessState extends LoginAndRegisterStates {
  final UserModel userModel;

  RegisterSuccessState({required this.userModel});
}

class RegisterErrorState extends LoginAndRegisterStates {
  final String registerError;

  RegisterErrorState({required this.registerError});
}

class LoginLoadingState extends LoginAndRegisterStates {}

class LoginSuccessState extends LoginAndRegisterStates {}

class LoginErrorState extends LoginAndRegisterStates {
  final String loginError;

  LoginErrorState({required this.loginError});
}

class UploadUserDataLoadingState extends LoginAndRegisterStates {}

class UploadUserDataSuccessState extends LoginAndRegisterStates {}

class UploadUserDataErrorState extends LoginAndRegisterStates {
  final String uploadUserDataError;

  UploadUserDataErrorState({required this.uploadUserDataError});
}
