import 'dart:io';

import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_cubit.dart';
import 'package:clinic_booking_app/models/doctor_model.dart';
import 'package:clinic_booking_app/models/user_model.dart';
import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/views/favourites/favourites_view.dart';
import 'package:clinic_booking_app/views/home/home_view.dart';
import 'package:clinic_booking_app/views/user_booked_appointments/user_booked_appointments_view.dart';
import 'package:clinic_booking_app/views/user_profile/user_profile_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum GetOnly {
  userData,
  doctorsData,
  userFavourties,
}

class BottomNavViewModel {
  final BottomNavCubit bottomNavCubit;

  BottomNavViewModel({required this.bottomNavCubit});

  int selectedIndex = 0;

  List<Widget> screens = [
    const HomeView(),
    const UserBookedAppointmentsView(),
    const FavouritesView(),
    const UserProfileView(),
  ];

  List<BottomNavigationBarItem> getBottomNavItems() {
    return [
      BottomNavigationBarItem(
        label: "Home",
        icon: selectedIndex == 0
            ? const Icon(
                EvaIcons.home, // Filled when selected
                color: AppColors.mainColor,
              )
            : const Icon(
                EvaIcons.homeOutline,
                color: AppColors.secondaryColor,
              ),
      ),
      BottomNavigationBarItem(
        label: "Bookings",
        icon: selectedIndex == 1
            ? const Icon(
                EvaIcons.calendar, // Filled when selected
                color: AppColors.mainColor,
              )
            : const Icon(
                EvaIcons.calendarOutline,
                color: AppColors.secondaryColor,
              ),
      ),
      BottomNavigationBarItem(
        label: "Favourites",
        icon: selectedIndex == 2
            ? const Icon(
                EvaIcons.heart, // Filled when selected
                color: AppColors.mainColor,
              )
            : const Icon(
                EvaIcons.heartOutline,
                color: AppColors.secondaryColor,
              ),
      ),
      BottomNavigationBarItem(
        label: "Profile",
        icon: selectedIndex == 3
            ? const Icon(
                EvaIcons.person, // Filled when selected
                color: AppColors.mainColor,
              )
            : const Icon(
                EvaIcons.personOutline,
                color: AppColors.secondaryColor,
              ),
      ),
    ];
  }

  void changeBottomNavIndex({
    required int index,
    required BottomNavCubit bottomNavCubit,
  }) {
    selectedIndex = index;
    bottomNavCubit.changeBottomNavTab(currentIndex: index);
  }

  late UserModel userModel;
  final db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> getAllData({GetOnly? getOnly}) async {
    bottomNavCubit.emitGetAllDataLoading();
    try {
      if (getOnly == GetOnly.userData) {
        await getUserData();
      } else if (getOnly == GetOnly.doctorsData) {
        await getDoctorsData();
      } else if (getOnly == GetOnly.userFavourties) {
        await getUserFavourites();
      } else {
        await getUserData();
        await getDoctorsData();
        await getUserFavourites();
      }

      bottomNavCubit.emitGetAllDataSuccess();
    } catch (e) {
      bottomNavCubit.emitGetAllDataError(error: e.toString());
      print("get all data: ${e.toString()}");
    }
  }

  Future<void> getUserData() async {
    //bottomNavCubit.emitGetUserDataLoading();
    try {
      var userData = await db.collection("users").doc(uid).get();
      userModel = UserModel.fromJson(userData);
      //bottomNavCubit.emitGetUserDataSuccess(userModel: userModel);
    } catch (e) {
      //bottomNavCubit.emitGetUserDataError(getUserDataError: e.toString());
      print("get user data: ${e.toString()}");
    }
  }

  List<DoctorModel> doctorsList = [];

  Future<void> getDoctorsData() async {
    //bottomNavCubit.emitGetDoctorsDataLoading();
    doctorsList.clear();
    try {
      var doctorsData = await db.collection("doctors").get();
      for (var element in doctorsData.docs) {
        doctorsList.add(DoctorModel.fromJson(element));
      }
      //bottomNavCubit.emitGetDoctorsDataSuccess();
    } catch (e) {
      //bottomNavCubit.emitGetDoctorsDataError(getDoctorsDataError: e.toString());
      print("get doctor data: ${e.toString()}");
    }
  }

  List<Map<String, bool>> favouriteDoctorsList = [];

  Future<void> getUserFavourites() async {
    //bottomNavCubit.emitGetFavouritesLoading();
    favouriteDoctorsList.clear();
    try {
      var favouriteDoctors =
          await db.collection("users").doc(uid).collection("favourites").get();
      for (var element in favouriteDoctors.docs) {
        favouriteDoctorsList.add(
          {
            element.id: element['isFavourite'],
          },
        );
      }
      //bottomNavCubit.emitGetFavouritesSuccess();
    } catch (e) {
      //bottomNavCubit.emitGetFavouritesError(getFavouritesError: e.toString());
      print("get favourites data: ${e.toString()}");
    }
  }

  bool isDoctorFavourite({required String doctorUID}) {
    for (var doctor in favouriteDoctorsList) {
      if (doctor.containsKey(doctorUID)) {
        return doctor[doctorUID]!;
      }
    }
    return false;
  }

  void changeIsFavourite(
      {required String doctorUID, required bool isFavourite}) async {
    bottomNavCubit.emitChangeIsFavouriteLoading();
    try {
      await db
          .collection("users")
          .doc(uid)
          .collection("favourites")
          .doc(doctorUID)
          .set({"isFavourite": isFavourite});
      bottomNavCubit.emitChangeIsFavouriteSuccess();
      await getAllData(getOnly: GetOnly.userFavourties);
    } catch (e) {
      bottomNavCubit.emitChangeIsFavouriteError(
          changeIsFavouriteError: e.toString());
    }
  }

  bool isEditable = false;
  void changeProfileData({required bool isEditable}) {
    this.isEditable = isEditable;
    bottomNavCubit.emitChangeProfileEditability(isEditable: isEditable);
  }

  Future<void> editUserProfileDate({
    required String name,
    required String phone,
    required String email,
  }) async {
    bottomNavCubit.emitEditUserProfileLoading();
    try {
      await db.collection("users").doc(uid).update({
        "name": name,
        "email": email,
        "phone": phone,
      });
      bottomNavCubit.emitEditUserProfileSuccess();
      await getAllData(getOnly: GetOnly.userData);
    } catch (e) {
      bottomNavCubit.emitEditUserProfileError(error: e.toString());
    }
  }

  var firebaseStorage = FirebaseStorage.instance;

  File? getImage;
  ImagePicker picker = ImagePicker();

  void getImageFromMobile() async {
    try {
      final value = await picker.pickImage(source: ImageSource.gallery);

      if (value != null) {
        getImage = File(value.path);
        bottomNavCubit.emitImagePickSuccess();
        await uploadImagetoStorage();
      } else {
        print("No image selected");
        bottomNavCubit.emitImagePickError(error: "No image selected");
      }
    } catch (error) {
      bottomNavCubit.emitImagePickError(error: error.toString());
    }
  }

  Future<void> uploadImagetoStorage() async {
    bottomNavCubit.emitUploadImageLoading();

    try {
      var result = await firebaseStorage
          .ref()
          .child("users/$uid/${Uri.file(getImage!.path).pathSegments.last}")
          .putFile(getImage!);

      // Get the download URL directly with await
      var downloadUrl = await result.ref.getDownloadURL();

      bottomNavCubit.emitUploadImageSuccess();

      // update user image
      await updateUserImage(image: downloadUrl);
    } catch (error) {
      print(error.toString());
      bottomNavCubit.emitUploadImageError(error: error.toString());
    }
  }

  Future<void> updateUserImage({required String image}) async {
    bottomNavCubit.emitEditImageLoading();
    try {
      await db.collection("users").doc(uid).update({"image": image});
      bottomNavCubit.emitEditImageSuccess();
      await getAllData(getOnly: GetOnly.userData);
    } catch (e) {
      bottomNavCubit.emitEditImageError(error: e.toString());
    }
  }

  List<DoctorModel> filteredDoctors = [];

  void searchDoctorsByName(String searchString) {
    // Convert the search string to lowercase to perform case-insensitive search
    if (searchString != "") {
      String lowerCaseSearch = searchString.toLowerCase();

      // Filter the list based on the search string
      filteredDoctors = doctorsList.where((doctor) {
        return doctor.doctorName.toLowerCase().contains(lowerCaseSearch);
      }).toList();
    } else {
      filteredDoctors.clear();
    }

    bottomNavCubit.emitSearch();
  }

  final firebaseAuth = FirebaseAuth.instance;

  void logout() {
    firebaseAuth.signOut().then(
      (value) {
        bottomNavCubit.emitUserLogoutSuccess();
      },
    ).catchError((error) {
      bottomNavCubit.emitUserLogoutError(error: error.toString());
    });
  }

  int findCorrespondingIndex<T, DoctorModel>(
      List<T> firstList,
      List<DoctorModel> secondList,
      int selectedIndex,
      bool Function(T, DoctorModel) matchCriteria) {
    if (selectedIndex < 0 || selectedIndex >= firstList.length) {
      // Return -1 if selectedIndex is out of bounds
      return -1;
    }

    // Get the selected item from the first list
    T selectedItem = firstList[selectedIndex];

    // Find the index in the second list that matches the criteria
    return secondList.indexWhere((item) => matchCriteria(selectedItem, item));
  }
}
