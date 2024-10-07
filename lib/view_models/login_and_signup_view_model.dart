import 'package:clinic_booking_app/cubit/login_and_register_cubit/login_and_register_cubit.dart';
import 'package:clinic_booking_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginAndRegisterViewModel {
  final LoginAndRegisterCubit loginAndRegisterCubit;

  LoginAndRegisterViewModel({required this.loginAndRegisterCubit});

  late UserModel userModel;
  late UserCredential userCredential;
  final db = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;

  Future<void> userSignUp({
    required String email,
    required String password,
    required String name,
  }) async {
    loginAndRegisterCubit.emitRegisterLoading();
    try {
      userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userModel = UserModel(
        name: name,
        email: email,
        uid: userCredential.user!.uid,
      );
      loginAndRegisterCubit.emitRegisterSuccess(userModel: userModel);
      await uploadUserData(uid: userCredential.user!.uid, userModel: userModel);
    } on FirebaseAuthException catch (e) {
      loginAndRegisterCubit.emitRegisterError(
          registerError: e.message.toString());
    } catch (e) {
      loginAndRegisterCubit.emitRegisterError(
          registerError: "Error, please try again later");
    }
  }

  Future<void> userSignIn(
      {required String email, required String password}) async {
    loginAndRegisterCubit.emitLoginLoading();
    try {
      userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      loginAndRegisterCubit.emitLoginSuccess();
    } on FirebaseAuthException catch (e) {
      loginAndRegisterCubit.emitLoginError(loginError: e.message.toString());
    } catch (e) {
      loginAndRegisterCubit.emitLoginError(
          loginError: "Error, please try again later");
    }
  }

  Future<void> uploadUserData(
      {required String uid, required UserModel userModel}) async {
    loginAndRegisterCubit.emitUploadUserDataLoading();
    try {
      await db.collection("users").doc(uid).set(userModel.userModelToJson());
      loginAndRegisterCubit.emitUploadUserDataSuccess();
    } catch (e) {
      loginAndRegisterCubit.emitUploadUserDataError(
          uploadUserDataError: e.toString());
    }
  }
}
