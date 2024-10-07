abstract class UserBookedAppointmentsStates {}

class UserBookedAppointmentsInitialState extends UserBookedAppointmentsStates {}

class ChangeShowCompletedAppointmentsState
    extends UserBookedAppointmentsStates {
  final bool isCompletedAppointments;

  ChangeShowCompletedAppointmentsState({required this.isCompletedAppointments});
}

class GetUserAppointmentsLoadingState extends UserBookedAppointmentsStates {}

class GetUserAppointmentsSuccessState extends UserBookedAppointmentsStates {}

class GetUserAppointmentsErrorState extends UserBookedAppointmentsStates {
  final String error;

  GetUserAppointmentsErrorState({required this.error});
}

class DeleteAppointmentsLoadingState extends UserBookedAppointmentsStates {}

class DeleteAppointmentsSuccessState extends UserBookedAppointmentsStates {}

class DeleteAppointmentsErrorState extends UserBookedAppointmentsStates {
  final String error;

  DeleteAppointmentsErrorState({required this.error});
}
