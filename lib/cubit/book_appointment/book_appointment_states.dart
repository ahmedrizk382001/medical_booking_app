abstract class BookAppointmentStates {}

class BookAppointmentInitialState extends BookAppointmentStates {}

class GetDoctorAppointmentsLoadingState extends BookAppointmentStates {}

class GetDoctorAppointmentsSuccessState extends BookAppointmentStates {}

class GetDoctorAppointmentsErrorState extends BookAppointmentStates {
  final String error;

  GetDoctorAppointmentsErrorState({required this.error});
}

class ChangeCurrentIndexState extends BookAppointmentStates {
  final int? index;

  ChangeCurrentIndexState({required this.index});
}

class ChangeBookingVariablesState extends BookAppointmentStates {}

class BookAppointmentLoadingState extends BookAppointmentStates {}

class BookAppointmentSuccessState extends BookAppointmentStates {}

class BookAppointmentErrorState extends BookAppointmentStates {
  final String error;

  BookAppointmentErrorState({required this.error});
}

class ChangeDoctorAppointmentsLoadingState extends BookAppointmentStates {}

class ChangeDoctorAppointmentsSuccessState extends BookAppointmentStates {}

class ChangeDoctorAppointmentsErrorState extends BookAppointmentStates {
  final String error;

  ChangeDoctorAppointmentsErrorState({required this.error});
}
