part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class ChangeUserStatusState extends ProfileState{}
class ChangeCenterImageState extends ProfileState{}
class ChangeState extends ProfileState{}
class ChangePasswordVisibilityState extends ProfileState{}
class UpdateCenterImageSuccessState extends ProfileState{}
class ChangeIsDrawerOpendState extends ProfileState{}
//===============get profile cities state===============
class GetProfileCitiesloadingState extends ProfileState{}
class GetProfileCitiesLoadedState extends ProfileState{}
class GetProfileCitiesErrorState extends ProfileState{}

//===============time table state=============
class AddToNewAppointmentState extends ProfileState{}
class DeleteFromNewAppointmentState extends ProfileState{}

//===============get profile data=======================
class GetProfileDataloadingState extends ProfileState{}
class GetProfileDataLoadedState extends ProfileState{}
class GetProfileDataErrorState extends ProfileState{}

//===============change profile status data=======================
class ChangeProfileStatusloadingState extends ProfileState{}
class ChangeProfileStatusLoadedState extends ProfileState{}
class ChangeProfileStatusErrorState extends ProfileState{}

//===============get profile reviews data=======================
class GetProfileReviewsloadingState extends ProfileState{}
class GetProfileReviewsLoadedState extends ProfileState{}
class GetProfileReviewsErrorState extends ProfileState{}

//===============change profile info data=======================
class EditProfileInfoloadingState extends ProfileState{}
class EditProfileInfoLoadedState extends ProfileState{}
class EditProfileInfoErrorState  extends ProfileState{}
// =======================logout states======================
class LogoutloadingState  extends ProfileState{}
class LogoutloadedState  extends ProfileState{}
class LogoutErrorState   extends ProfileState{}

//===============update profile time table data=======================
class UpdateProfileTimeTableloadingState extends ProfileState{}
class UpdateProfileTimeTableLoadedState extends ProfileState{}
class UpdateProfileTimeTableErrorState  extends ProfileState{}
//===============get profile time table data=======================
class GetProfileTimeTableloadingState extends ProfileState{}
class GetProfileTimeTableLoadedState extends ProfileState{}
class GetProfileTimeTableErrorState  extends ProfileState{}

//===============get reviews  data=======================
class GetReviewsloadingState extends ProfileState{}
class GetReviewsLoadedState extends ProfileState{}
class GetReviewsErrorState  extends ProfileState{}

//===============get whatapp url data=======================
class GetWhatsAppUrlloadingState extends ProfileState{}
class GetWhatsAppUrlLoadedState extends ProfileState{}
class GetWhatsAppUrlErrorState  extends ProfileState{}

// =======================verfiy mobile states======================
class VerifyMobileloadingState extends ProfileState {}
class VerifyMobileloadedState extends  ProfileState {}
class VerifyMobileErrorState extends   ProfileState {}

// =======================verfiy mobile states======================
class UpdateMobileloadingState extends ProfileState {}
class UpdateMobileloadedState extends  ProfileState {}
class UpdateMobileErrorState extends   ProfileState {}

// =======================verfiy mobile states======================
class DeleteAccountloadingState extends ProfileState {}
class DeleteAccountloadedState extends  ProfileState {}
class DeleteAccountErrorState extends   ProfileState {}


// =======================verfiy mobile states======================
class ShareAppLinkloadingState extends ProfileState {}
class ShareAppLinkloadedState extends  ProfileState {}
class ShareAppLinkErrorState extends   ProfileState {}

//===============check user avalibality ==========================



class CheckUserAvaliabilityErrorState extends    ProfileState {}
