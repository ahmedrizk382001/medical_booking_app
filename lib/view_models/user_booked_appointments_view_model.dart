import 'package:clinic_booking_app/cubit/user_booked_appointments.dart/user_booked_appointments_cubit.dart';
import 'package:clinic_booking_app/models/booked_appointment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class UserBookedAppointmentsViewModel {
  final UserBookedAppointmentsCubit userBookedAppointmentsCubit;

  UserBookedAppointmentsViewModel({required this.userBookedAppointmentsCubit});

  bool isCompletedAppointments = false;
  void changeIsCompletedAppointments({required bool isCompletedAppointments}) {
    this.isCompletedAppointments = isCompletedAppointments;
    userBookedAppointmentsCubit.emitChangeShowCompletedAppointments(
        isCompletedAppointments: isCompletedAppointments);
  }

  final db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  List<BookedAppointmentModel> appointmentsList = [];
  List<BookedAppointmentModel> completedAppointmentsList = [];
  List<BookedAppointmentModel> todayAppointments = [];

  Future<void> getBookedAppointments() async {
    userBookedAppointmentsCubit.emitGetUserBookedAppointmentsLoading();

    // Clear all lists before fetching new data
    appointmentsList.clear();
    completedAppointmentsList.clear();
    todayAppointments.clear();

    try {
      // Fetch appointments ordered by date and time
      var results = await db
          .collection("users")
          .doc(uid)
          .collection("appointments")
          .orderBy("appointmentDate", descending: false)
          .orderBy("appointmentTime", descending: false)
          .get();

      DateTime now = DateTime.now();

      for (var element in results.docs) {
        var data = BookedAppointmentModel.fromJson(element);

        // Parse the appointmentDate string into a DateTime object
        DateTime appointmentDate = DateTime.parse(data.appointmentDate);

        // Split appointmentTime string into hours and minutes
        List<String> timeParts = data.appointmentTime.split(':');
        int hour = int.parse(timeParts[0]);
        int minute = int.parse(timeParts[1]);

        // Create a DateTime object for the appointment combining date and time
        DateTime appointmentDateTime = DateTime(
          appointmentDate.year,
          appointmentDate.month,
          appointmentDate.day,
          hour,
          minute,
        );

        // **Filter Logic:**

        // 1. **Completed Appointments:**
        // If the appointmentDateTime is before now, add to completedAppointmentsList
        if (appointmentDateTime.isBefore(now)) {
          completedAppointmentsList.add(data);
          continue; // Skip adding to other lists
        }

        // 2. **Today's Appointments:**
        // Check if the appointment is today
        bool isToday = appointmentDate.year == now.year &&
            appointmentDate.month == now.month &&
            appointmentDate.day == now.day;

        if (isToday) {
          todayAppointments.add(data);
        }

        // 3. **Upcoming Appointments:**
        // Add to appointmentsList if it's in the future (already ensured by isBefore check)
        appointmentsList.add(data);
      }

      userBookedAppointmentsCubit.emitGetUserBookedAppointmentsSuccess();
    } catch (e) {
      print(e.toString());
      userBookedAppointmentsCubit.emitGetUserBookedAppointmentsError(
          error: e.toString());
    }
  }

  String formatDate(String date) {
    // Parse the input string into a DateTime object
    DateTime parsedDate = DateTime.parse(date);

    // Format the date to "d MMM" format (e.g., "2 Aug")
    String formattedDate = DateFormat('d MMM').format(parsedDate);

    return formattedDate;
  }

  String convertTimeTo12HourFormat(String time) {
    // Define a DateFormat for parsing the 24-hour format time
    DateFormat inputFormat = DateFormat('HH:mm');

    // Parse the input time string into a DateTime object
    DateTime parsedTime = inputFormat.parse(time.trim());

    // Define a DateFormat for outputting the time in 12-hour format with AM/PM
    DateFormat outputFormat = DateFormat('hh:mm a');

    // Format the parsed DateTime object to 12-hour format
    String formattedTime = outputFormat.format(parsedTime);

    return formattedTime;
  }

  Future<void> deleteAppointment(
      {required int index,
      required BookedAppointmentModel bookedAppointmentModel}) async {
    userBookedAppointmentsCubit.emitDeleteAppointmentsLoading();
    try {
      await db
          .collection("doctors")
          .doc(bookedAppointmentModel.doctorUID)
          .collection("appointments")
          .doc(bookedAppointmentModel.appointmentDate)
          .set(
        {"$index": "free"},
        SetOptions(
          merge: true,
        ),
      );
      await db
          .collection("users")
          .doc(uid)
          .collection("appointments")
          .doc(bookedAppointmentModel.appointmentUID)
          .delete();

      userBookedAppointmentsCubit.emitDeleteAppointmentsSuccess();

      await getBookedAppointments();
    } catch (e) {
      print(e.toString());
      userBookedAppointmentsCubit.emitDeleteAppointmentsError(
          error: e.toString());
    }
  }
}
