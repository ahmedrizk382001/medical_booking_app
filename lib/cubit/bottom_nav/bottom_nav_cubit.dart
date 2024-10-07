import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_states.dart';

class BottomNavCubit extends Cubit<BottomNavStates> {
  BottomNavCubit() : super(BottomNavInitialState());

  static BottomNavCubit get(BuildContext context) =>
      BlocProvider.of<BottomNavCubit>(context);

  void changeBottomNavTab({required int currentIndex}) {
    emit(BottomNavChangeIndexState(currentIndex: currentIndex));
  }

  // void emitGetUserDataLoading() => emit(GetUserDataLoadingState());

  // void emitGetUserDataSuccess({required UserModel userModel}) =>
  //     emit(GetUserDataSuccessState(userModel: userModel));

  // void emitGetUserDataError({required String getUserDataError}) =>
  //     emit(GetUserDataErrorState(getUserDataError: getUserDataError));

  // void emitGetDoctorsDataLoading() => emit(GetDoctorsDataLoadingState());

  // void emitGetDoctorsDataSuccess() => emit(GetDoctorsDataSuccessState());

  // void emitGetDoctorsDataError({required String getDoctorsDataError}) =>
  //     emit(GetDoctorsDataErrorState(getDoctorsDataError: getDoctorsDataError));

  // void emitGetFavouritesLoading() => emit(GetFavouritesLoadingState());

  // void emitGetFavouritesSuccess() => emit(GetFavouritesSuccessState());

  // void emitGetFavouritesError({required String getFavouritesError}) =>
  //     emit(GetFavouritesErrorState(getFavouritesError: getFavouritesError));

  void emitGetAllDataLoading() => emit(GetAllDataLoadingState());

  void emitGetAllDataSuccess() => emit(GetAllDataSuccessState());

  void emitGetAllDataError({required String error}) =>
      emit(GetAllDataErrorState(error: error));

  void emitChangeIsFavouriteLoading() => emit(ChangeIsFavouriteLoadingState());

  void emitChangeIsFavouriteSuccess() => emit(ChangeIsFavouriteSuccessState());

  void emitChangeIsFavouriteError({required String changeIsFavouriteError}) =>
      emit(ChangeIsFavouriteErrorState(
          changeIsFavouriteError: changeIsFavouriteError));

  void emitChangeProfileEditability({required bool isEditable}) =>
      emit(ChangeProfileEditabilityState(isEditable: isEditable));

  void emitEditUserProfileLoading() => emit(EditUserProfileLoadingState());

  void emitEditUserProfileSuccess() => emit(EditUserProfileSuccessState());

  void emitEditUserProfileError({required String error}) =>
      emit(EditUserProfileErrorState(error: error));

  void emitImagePickSuccess() => emit(ImagePickSuccessState());

  void emitImagePickError({required String error}) =>
      emit(ImagePickErrorState(error: error));

  void emitUploadImageLoading() => emit(UploadImageLoadingState());

  void emitUploadImageSuccess() => emit(UploadImageSuccessState());

  void emitUploadImageError({required String error}) =>
      emit(UploadImageErrorState(error: error));

  void emitEditImageLoading() => emit(EditImageLoadingState());

  void emitEditImageSuccess() => emit(EditImageSuccessState());

  void emitEditImageError({required String error}) =>
      emit(EditImageErrorState(error: error));

  void emitSearch() => emit(SearchState());

  void emitUserLogoutSuccess() => emit(UserLogoutSuccessState());

  void emitUserLogoutError({required String error}) =>
      emit(UserLogoutErrorState(error: error));
}
