import 'package:clinic_booking_app/cubit/BlocObserver/bloc_observer.dart';
import 'package:clinic_booking_app/cubit/book_appointment/book_appointment_cubit.dart';
import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_cubit.dart';
import 'package:clinic_booking_app/cubit/login_and_register_cubit/login_and_register_cubit.dart';
import 'package:clinic_booking_app/cubit/user_booked_appointments.dart/user_booked_appointments_cubit.dart';
import 'package:clinic_booking_app/firebase_options.dart';
import 'package:clinic_booking_app/views/splash_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          isLoggedIn = false;
        });
        print('User is currently signed out!');
      } else {
        setState(() {
          isLoggedIn = true;
        });

        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavCubit(),
        ),
        BlocProvider(
          create: (context) => LoginAndRegisterCubit(),
        ),
        BlocProvider(
          create: (context) => BookAppointmentCubit(),
        ),
        BlocProvider(
          create: (context) => UserBookedAppointmentsCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashView(isLoggedIn: isLoggedIn),
      ),
    );
  }
}
