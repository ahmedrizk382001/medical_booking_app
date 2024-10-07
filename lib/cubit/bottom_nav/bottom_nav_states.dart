abstract class BottomNavStates {}

class BottomNavInitialState extends BottomNavStates {}

class BottomNavChangeIndexState extends BottomNavStates {
  final int currentIndex;

  BottomNavChangeIndexState({required this.currentIndex});
}

// class GetUserDataLoadingState extends BottomNavStates {}

// class GetUserDataSuccessState extends BottomNavStates {
//   final UserModel userModel;

//   GetUserDataSuccessState({required this.userModel});
// }

// class GetUserDataErrorState extends BottomNavStates {
//   final String getUserDataError;

//   GetUserDataErrorState({required this.getUserDataError});
// }

// class GetDoctorsDataLoadingState extends BottomNavStates {}

// class GetDoctorsDataSuccessState extends BottomNavStates {}

// class GetDoctorsDataErrorState extends BottomNavStates {
//   final String getDoctorsDataError;

//   GetDoctorsDataErrorState({required this.getDoctorsDataError});
// }

// class GetFavouritesLoadingState extends BottomNavStates {}

// class GetFavouritesSuccessState extends BottomNavStates {}

// class GetFavouritesErrorState extends BottomNavStates {
//   final String getFavouritesError;

//   GetFavouritesErrorState({required this.getFavouritesError});
// }

class GetAllDataLoadingState extends BottomNavStates {}

class GetAllDataSuccessState extends BottomNavStates {}

class GetAllDataErrorState extends BottomNavStates {
  final String error;

  GetAllDataErrorState({required this.error});
}

class ChangeIsFavouriteLoadingState extends BottomNavStates {}

class ChangeIsFavouriteSuccessState extends BottomNavStates {}

class ChangeIsFavouriteErrorState extends BottomNavStates {
  final String changeIsFavouriteError;

  ChangeIsFavouriteErrorState({required this.changeIsFavouriteError});
}

class ChangeProfileEditabilityState extends BottomNavStates {
  final bool isEditable;

  ChangeProfileEditabilityState({required this.isEditable});
}

class EditUserProfileLoadingState extends BottomNavStates {}

class EditUserProfileSuccessState extends BottomNavStates {}

class EditUserProfileErrorState extends BottomNavStates {
  final String error;

  EditUserProfileErrorState({required this.error});
}

class ImagePickSuccessState extends BottomNavStates {}

class ImagePickErrorState extends BottomNavStates {
  final String error;

  ImagePickErrorState({required this.error});
}

class UploadImageLoadingState extends BottomNavStates {}

class UploadImageSuccessState extends BottomNavStates {}

class UploadImageErrorState extends BottomNavStates {
  final String error;

  UploadImageErrorState({required this.error});
}

class EditImageLoadingState extends BottomNavStates {}

class EditImageSuccessState extends BottomNavStates {}

class EditImageErrorState extends BottomNavStates {
  final String error;

  EditImageErrorState({required this.error});
}

class SearchState extends BottomNavStates {}

class UserLogoutSuccessState extends BottomNavStates {}

class UserLogoutErrorState extends BottomNavStates {
  final String error;

  UserLogoutErrorState({required this.error});
}
