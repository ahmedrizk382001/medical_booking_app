import 'package:cloud_firestore/cloud_firestore.dart';

class BookedAppointmentModel {
  late String doctorName,
      jobTitle,
      appointmentDate,
      appointmentTime,
      doctorImage,
      doctorUID,
      appointmentUID;

  BookedAppointmentModel({
    required this.doctorName,
    required this.doctorImage,
    required this.jobTitle,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.doctorUID,
    required this.appointmentUID,
  });

  BookedAppointmentModel.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> model) {
    doctorName = model["doctorName"];
    doctorImage = model["doctorImage"];
    jobTitle = model["jobTitle"];
    appointmentDate = model["appointmentDate"];
    appointmentTime = model["appointmentTime"];
    doctorUID = model["doctorUID"];
    appointmentUID = model["appointmentUID"];
  }

  Map<String, dynamic> toJson() {
    return {
      "doctorName": doctorName,
      "doctorImage": doctorImage,
      "jobTitle": jobTitle,
      "appointmentDate": appointmentDate,
      "appointmentTime": appointmentTime,
      "doctorUID": doctorUID,
      "appointmentUID": appointmentUID,
    };
  }
}
