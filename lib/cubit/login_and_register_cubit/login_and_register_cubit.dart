import 'package:clinic_booking_app/cubit/login_and_register_cubit/login_and_register_states.dart';
import 'package:clinic_booking_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginAndRegisterCubit extends Cubit<LoginAndRegisterStates> {
  LoginAndRegisterCubit() : super(LoginAndRegisterInitialState());

  static LoginAndRegisterCubit get(BuildContext context) =>
      BlocProvider.of<LoginAndRegisterCubit>(context);

  void emitRegisterLoading() => emit(RegisterLoadingState());

  void emitRegisterSuccess({required UserModel userModel}) =>
      emit(RegisterSuccessState(userModel: userModel));

  void emitRegisterError({required String registerError}) =>
      emit(RegisterErrorState(registerError: registerError));

  void emitLoginLoading() => emit(LoginLoadingState());

  void emitLoginSuccess() => emit(LoginSuccessState());

  void emitLoginError({required String loginError}) =>
      emit(LoginErrorState(loginError: loginError));

  void emitUploadUserDataLoading() => emit(UploadUserDataLoadingState());

  void emitUploadUserDataSuccess() => emit(UploadUserDataSuccessState());

  void emitUploadUserDataError({required String uploadUserDataError}) =>
      emit(UploadUserDataErrorState(uploadUserDataError: uploadUserDataError));
}
