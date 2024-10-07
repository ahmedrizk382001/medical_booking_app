import 'package:clinic_booking_app/cubit/login_and_register_cubit/login_and_register_cubit.dart';
import 'package:clinic_booking_app/cubit/login_and_register_cubit/login_and_register_states.dart';
import 'package:clinic_booking_app/shared/common_widgets.dart';
import 'package:clinic_booking_app/shared/navigation.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:clinic_booking_app/view_models/login_and_signup_view_model.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:clinic_booking_app/views/login_and_signup/widgets/animated_login.dart';
import 'package:clinic_booking_app/views/login_and_signup/widgets/animated_login_Text.dart';
import 'package:clinic_booking_app/views/login_and_signup/widgets/animated_signup.dart';
import 'package:clinic_booking_app/views/login_and_signup/widgets/animated_signup_text.dart';
import 'package:clinic_booking_app/views/login_and_signup/widgets/social_media_buttons.dart';
import 'package:clinic_booking_app/views/login_and_signup/widgets/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

late LoginAndRegisterViewModel loginAndSignupViewModel;

class LoginAndRegisterView extends StatefulWidget {
  const LoginAndRegisterView({super.key, required this.isSignUp});

  final bool isSignUp;

  @override
  State<LoginAndRegisterView> createState() => _LoginAndRegisterViewState();
}

class _LoginAndRegisterViewState extends State<LoginAndRegisterView> {
  bool isShowSignUp = false;
  bool _initialized = false;

  late TextEditingController registerNameController,
      registerEmailController,
      registerPasswordController;

  late TextEditingController loginEmailController, loginPasswordController;

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controllersInit();
    super.initState();
  }

  @override
  void dispose() {
    _controllersDispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    var cubit = LoginAndRegisterCubit.get(context);
    loginAndSignupViewModel =
        LoginAndRegisterViewModel(loginAndRegisterCubit: cubit);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    isSignUpUsed();

    return BlocConsumer<LoginAndRegisterCubit, LoginAndRegisterStates>(
      listener: (context, state) {
        _registerStateListening(state, context);
        if (state is LoginErrorState) {
          showCustomSnackBar(context, message: state.loginError);
        } else if (state is LoginSuccessState) {
          pushRemoveUntil(context, const BottomNavView(), duration: 500);
          showCustomSnackBar(context, message: "Login success, Welcome...");
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            //login
            Form(
              key: _loginFormKey,
              child: AnimatedLoginInputs(
                size: size,
                onTap: () {
                  if (isShowSignUp) {
                    isShowSignUp = false;

                    setState(() {});
                  }
                },
                isShowSignUp: isShowSignUp,
                emailController: loginEmailController,
                passwordController: loginPasswordController,
              ),
            ),

            //sign up
            Form(
              key: _registerFormKey,
              child: AnimatedSignUp(
                size: size,
                isShowSignUp: isShowSignUp,
                onTap: () {
                  if (!isShowSignUp) {
                    isShowSignUp = true;
                    setState(() {});
                  }
                },
                nameController: registerNameController,
                emailController: registerEmailController,
                passwordController: registerPasswordController,
              ),
            ),

            //Header
            AnimatedPositioned(
              duration: Duration(milliseconds: shortAnimationDuration),
              curve: Curves.easeIn,
              width: size.width,
              top: size.height * 0.1,
              right: isShowSignUp ? -size.width * 0.06 : size.width * 0.06,
              child: const HeaderText(),
            ),

            //LoginTextAnimation
            Builder(
              builder: (context) {
                if (state is LoginLoadingState) {
                  return _circleProgressIndicator(size);
                } else {
                  return LoginTextAnimation(
                    size: size,
                    isShowSignUp: isShowSignUp,
                    onTap: _loginTextAnimationOnTap,
                  );
                }
              },
            ),

            //signupTextAnimation
            Builder(
              builder: (context) {
                if (state is RegisterLoadingState) {
                  return _circleProgressIndicator(size);
                } else {
                  return SignUpTextAnimation(
                    size: size,
                    isShowSignUp: isShowSignUp,
                    onTap: _signUpTextAnimationOnTap,
                  );
                }
              },
            ),

            //Social Media Buttons
            AnimatedPositioned(
                duration: Duration(milliseconds: shortAnimationDuration),
                curve: Curves.easeIn,
                width: size.width,
                bottom: size.height * 0.1,
                right: isShowSignUp ? -size.width * 0.06 : size.width * 0.06,
                child: const SocialMediaButtons()),
          ],
        );
      },
    );
  }

  void _registerStateListening(
      LoginAndRegisterStates state, BuildContext context) {
    if (state is RegisterSuccessState) {
      registerEmailController.text =
          registerPasswordController.text = registerNameController.text = '';
      isShowSignUp = false;
      showCustomSnackBar(context,
          message: "Account created successfully, Now you can login");
    } else if (state is RegisterErrorState) {
      showCustomSnackBar(context, message: state.registerError);
    }
  }

  void _loginTextAnimationOnTap() {
    if (isShowSignUp) {
      isShowSignUp = false;
      setState(() {});
    } else if (_loginFormKey.currentState!.validate()) {
      loginAndSignupViewModel.userSignIn(
          email: loginEmailController.text,
          password: loginPasswordController.text);
    }
  }

  Positioned _circleProgressIndicator(Size size) {
    return Positioned(
      bottom: size.height * 0.3,
      right: isShowSignUp ? size.width * 0.40 : size.width * 0.52,
      child: const CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }

  void _signUpTextAnimationOnTap() {
    if (!isShowSignUp) {
      isShowSignUp = true;
      setState(() {});
    } else if (_registerFormKey.currentState!.validate()) {
      loginAndSignupViewModel.userSignUp(
          email: registerEmailController.text,
          password: registerPasswordController.text,
          name: registerNameController.text);
    }
  }

  void isSignUpUsed() {
    if (widget.isSignUp && !_initialized) {
      isShowSignUp = true;
      _initialized = true;
      setState(() {});
    }
  }

  void _controllersInit() {
    registerNameController = TextEditingController();
    registerEmailController = TextEditingController();
    registerPasswordController = TextEditingController();
    loginEmailController = TextEditingController();
    loginPasswordController = TextEditingController();
  }

  void _controllersDispose() {
    registerNameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
  }
}
