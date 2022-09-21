part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class LoginVisibilityChangeState extends AuthState {}
class RegisterChangeIndexState extends AuthState {}
class RegisterVisibilityChangeState extends AuthState {}
class CenterImageSuccessState extends AuthState{}
class ChangeShowedCenterImageState extends AuthState{}
class ChangeState extends AuthState{}

// =======================login states======================
class LoginloadingState extends AuthState {}
class LoginloadedState extends AuthState {}
class LoginErrorState extends AuthState {}
// =======================register states======================
class RegisterloadingState extends AuthState {}
class RegisterloadedState extends AuthState {}
class RegisterErrorState extends AuthState {}


// =======================reset email states======================
class SendResetEmailloadingState extends AuthState {}
class SendResetEmailloadedState extends AuthState {}
class SendResetEmailErrorState extends AuthState {}

// =======================reset password states======================
class ResetPasswordloadingState extends AuthState {}
class ResetPasswordloadedState extends AuthState {}
class ResetPasswordErrorState extends AuthState {}

// =======================verfiy mobile states======================
class VerifyMobileloadingState extends AuthState {}
class VerifyMobileloadedState extends AuthState {}
class VerifyMobileErrorState extends AuthState {}

// ======================= get cities states======================
class GetCitiesloadingState extends AuthState {}
class GetCitiesloadedState extends AuthState {}
class GetCitiesErrorState extends AuthState {}

//==============selected appointment state===========
class AddAppointmentState extends AuthState {}
class DeleteAppointmentState extends AuthState {}


// ======================= insert time table  states======================
class InsertTimeTableloadingState extends AuthState {}
class InsertTimeTableloadedState extends AuthState {}
class InsertTimeTableErrorState extends AuthState {}

// ======================= resend verification  states======================
class ResendVerificationloadingState extends AuthState {}
class ResendVerificationloadedState extends AuthState {}
class ResendVerificationErrorState extends AuthState {}


