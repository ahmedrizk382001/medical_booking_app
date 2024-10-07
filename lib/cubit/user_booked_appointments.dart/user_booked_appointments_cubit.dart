import 'package:clinic_booking_app/cubit/user_booked_appointments.dart/user_booked_appointments_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBookedAppointmentsCubit extends Cubit<UserBookedAppointmentsStates> {
  UserBookedAppointmentsCubit() : super(UserBookedAppointmentsInitialState());

  static UserBookedAppointmentsCubit get(BuildContext context) =>
      BlocProvider.of<UserBookedAppointmentsCubit>(context);

  emitChangeShowCompletedAppointments(
          {required bool isCompletedAppointments}) =>
      emit(ChangeShowCompletedAppointmentsState(
          isCompletedAppointments: isCompletedAppointments));

  emitGetUserBookedAppointmentsLoading() =>
      emit(GetUserAppointmentsLoadingState());

  emitGetUserBookedAppointmentsSuccess() =>
      emit(GetUserAppointmentsSuccessState());

  emitGetUserBookedAppointmentsError({required String error}) =>
      emit(GetUserAppointmentsErrorState(error: error));

  emitDeleteAppointmentsLoading() => emit(DeleteAppointmentsLoadingState());

  emitDeleteAppointmentsSuccess() => emit(DeleteAppointmentsSuccessState());

  emitDeleteAppointmentsError({required String error}) =>
      emit(DeleteAppointmentsErrorState(error: error));
}
