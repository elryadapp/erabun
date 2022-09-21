part of 'appointments_cubit.dart';

@immutable
abstract class AppointmentsState {}

class AppointmentsInitial extends AppointmentsState {}
class ChangeCurrentAApointmentIndexState extends AppointmentsState {}
class ChangeCancelationResonState extends AppointmentsState {}
class ChangeIsScanState extends AppointmentsState {}

//======================get all appointment states================
class GetAllAppointmentsLoadingState extends AppointmentsState {}
class GetRefreshAppointmentsLoadingState extends AppointmentsState {}

class GetPaginatedAppointmentsLoadingState extends AppointmentsState {}

class GetAllAppointmentsLoadedState extends AppointmentsState {}
class GetAllAppointmentsErrorState extends AppointmentsState {}


//================cancel examination=====================

class CancelExaminationLoadingState extends AppointmentsState {}
class CancelExaminationLoadedState extends AppointmentsState {}
class CancelExaminationErrorState extends AppointmentsState {}

//================cancel appointment=====================

class CancelAppointmentLoadingState extends AppointmentsState {}
class CancelAppointmentLoadedState extends AppointmentsState {}
class CancelAppointmentErrorState extends AppointmentsState {}


//======================get canceled appointment states================
class GetCanceledAppointmentsLoadingState extends AppointmentsState {}
class GetRefreshCanceledAppointmentsLoadingState extends AppointmentsState {}

class GetPaginatedCanceledAppointmentsLoadingState extends AppointmentsState {}

class GetCanceledAppointmentsLoadedState extends AppointmentsState {}
class GetCanceledAppointmentsErrorState extends AppointmentsState {}
//==============general===================
class ChangeAppointmentIndexState extends AppointmentsState{}
