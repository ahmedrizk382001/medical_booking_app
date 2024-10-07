import 'package:clinic_booking_app/cubit/book_appointment/book_appointment_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookAppointmentCubit extends Cubit<BookAppointmentStates> {
  BookAppointmentCubit() : super(BookAppointmentInitialState());

  static BookAppointmentCubit get(BuildContext context) =>
      BlocProvider.of<BookAppointmentCubit>(context);

  emitGetDoctorAppointmentsLoading() =>
      emit(GetDoctorAppointmentsLoadingState());

  emitGetDoctorAppointmentsSuccess() =>
      emit(GetDoctorAppointmentsSuccessState());

  emitGetDoctorAppointmentsError({required String error}) =>
      emit(GetDoctorAppointmentsErrorState(error: error));

  emitChangeCurrentIndex({required int? index}) =>
      emit(ChangeCurrentIndexState(index: index));

  emitChangeBookingVariablesState() => emit(ChangeBookingVariablesState());

  emitBookAppointmentLoading() => emit(BookAppointmentLoadingState());

  emitBookAppointmentSuccess() => emit(BookAppointmentSuccessState());

  emitBookAppointmentError({required String error}) =>
      emit(BookAppointmentErrorState(error: error));

  emitChangeDoctorAppointmentsLoading() =>
      emit(ChangeDoctorAppointmentsLoadingState());

  emitChangeDoctorAppointmentsSuccess() =>
      emit(ChangeDoctorAppointmentsSuccessState());

  emitChangeDoctorAppointmentsError({required String error}) =>
      emit(ChangeDoctorAppointmentsErrorState(error: error));
}
