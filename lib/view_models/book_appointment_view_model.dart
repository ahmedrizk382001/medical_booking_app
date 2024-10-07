import 'package:clinic_booking_app/cubit/book_appointment/book_appointment_cubit.dart';
import 'package:clinic_booking_app/models/booked_appointment_model.dart';
import 'package:clinic_booking_app/models/doctor_model.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class BookAppointmentViewModel {
  final BookAppointmentCubit bookAppointmentCubit;

  BookAppointmentViewModel({required this.bookAppointmentCubit});

  final db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  Map<String, dynamic> doctorFetchedAppointments = {};

  Future<void> getDoctorAppointments(
      {required String doctorUID, required String day}) async {
    bookAppointmentCubit.emitGetDoctorAppointmentsLoading();
    doctorFetchedAppointments.clear();
    try {
      var result = await db
          .collection("doctors")
          .doc(doctorUID)
          .collection("appointments")
          .doc(day)
          .get();
      if (result.data() != null) {
        doctorFetchedAppointments.addAll(result.data()!);
      }
      print(doctorFetchedAppointments);
      bookAppointmentCubit.emitGetDoctorAppointmentsSuccess();
    } catch (e) {
      bookAppointmentCubit.emitGetDoctorAppointmentsError(error: e.toString());
    }
  }

  int? currentIndex;
  void changeCurrentIndex({required int? index}) {
    currentIndex = index;
    bookAppointmentCubit.emitChangeCurrentIndex(index: index);
  }

  bool isWeekend = false;
  bool isTimeSelected = false;
  bool isDateSelected = false;
  DateTime foucsDay = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
  DateTime currentDay = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);

  void initialDateCheck() {
    // Corrected variable name from 'foucusDay' to 'focusDay'
    // Using 'weekday' instead of 'day' to get the day of the week
    if (foucsDay.weekday == DateTime.friday ||
        currentDay.weekday == DateTime.friday) {
      changeBookingVariables(isWeekend: true);
    }
  }

  int? selectedTimeIndex;
  void changeBookingVariables({
    bool? isWeekend,
    bool? isTimeSelected,
    bool? isDateSelected,
    DateTime? foucusDay,
    DateTime? currentDay,
    int? selectedTimeIndex,
  }) {
    this.isWeekend = isWeekend ?? this.isWeekend;
    this.isTimeSelected = isTimeSelected ?? this.isTimeSelected;
    this.isDateSelected = isDateSelected ?? this.isDateSelected;
    foucsDay = foucusDay ?? foucsDay;
    this.currentDay = currentDay ?? this.currentDay;
    this.selectedTimeIndex = selectedTimeIndex ?? this.selectedTimeIndex;

    bookAppointmentCubit.emitChangeBookingVariablesState();
  }

  late BookedAppointmentModel bookedAppointmentModel;

  Future<void> bookAppointment({required DoctorModel doctorModel}) async {
    bookAppointmentCubit.emitBookAppointmentLoading();

    try {
      // Create a new document reference
      DocumentReference appointmentRef = db
          .collection("users")
          .doc(uid)
          .collection("appointments")
          .doc(); // Generates a unique document ID

      // Create the booked appointment model with the generated appointmentUID
      bookedAppointmentModel = BookedAppointmentModel(
        doctorName: doctorModel.doctorName,
        doctorImage: doctorModel.doctorImage,
        jobTitle: doctorModel.jobTitle,
        doctorUID: doctorModel.doctorUID,
        appointmentDate: formatDate(foucsDay),
        appointmentTime:
            convertTimeTo24HourFormat(appointmentsTime[selectedTimeIndex!]),
        appointmentUID: appointmentRef.id, // Set the document ID here
      );

      // Set the data to Firestore
      await appointmentRef.set(bookedAppointmentModel.toJson());

      // Change the doctor's appointments
      await changeDoctorAppointments(
        date: bookedAppointmentModel.appointmentDate,
        doctorUID: bookedAppointmentModel.doctorUID,
        index: selectedTimeIndex!,
      );

      bookAppointmentCubit.emitBookAppointmentSuccess();
    } catch (e) {
      bookAppointmentCubit.emitBookAppointmentError(error: e.toString());
    }
  }

  Future<void> changeDoctorAppointments({
    required String doctorUID,
    required int index,
    required String date,
    String? state = "reserved",
  }) async {
    bookAppointmentCubit.emitChangeDoctorAppointmentsLoading();
    try {
      await db
          .collection("doctors")
          .doc(doctorUID)
          .collection("appointments")
          .doc(date)
          .set(
        {"$index": "reserved"},
        SetOptions(
          merge: true,
        ),
      );
      bookAppointmentCubit.emitChangeDoctorAppointmentsSuccess();
    } catch (e) {
      bookAppointmentCubit.emitChangeDoctorAppointmentsError(
          error: e.toString());
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  String convertTimeTo24HourFormat(String time) {
    // Define a DateFormat for parsing the 12-hour format time
    DateFormat inputFormat = DateFormat('hh:mm a');

    // Parse the input time string into a DateTime object
    DateTime parsedTime = inputFormat.parse(time.trim());

    // Define a DateFormat for outputting the time in 24-hour format
    DateFormat outputFormat = DateFormat('HH:mm');

    // Format the parsed DateTime object to 24-hour format
    String formattedTime = outputFormat.format(parsedTime);

    return formattedTime;
  }
}
