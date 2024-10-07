import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  late String doctorName,
      jobTitle,
      workingHours,
      fee,
      doctorImage,
      aboutMe,
      education,
      doctorUID;
  late num reviews, patientNumber, experienceYears, rate;
  late bool isFavourite;

  DoctorModel({
    required this.doctorName,
    required this.isFavourite,
    required this.jobTitle,
    required this.workingHours,
    required this.fee,
    required this.doctorImage,
    required this.reviews,
    required this.patientNumber,
    required this.experienceYears,
    required this.rate,
    required this.aboutMe,
    required this.education,
  });

  DoctorModel.fromJson(DocumentSnapshot<Map<String, dynamic>> doctorModel) {
    doctorName = doctorModel['doctorName'];
    isFavourite = doctorModel['isFavourite'];
    jobTitle = doctorModel['jobTitle'];
    fee = doctorModel['fee'];
    workingHours = doctorModel['workingHours'];
    doctorImage = doctorModel['doctorImage'];
    reviews = doctorModel['reviews'];
    patientNumber = doctorModel['patientNumber'];
    experienceYears = doctorModel['experienceYears'];
    rate = doctorModel['rate'];
    aboutMe = doctorModel['aboutMe'];
    education = doctorModel['education'];
    doctorUID = doctorModel['doctorUID'];
  }
}
