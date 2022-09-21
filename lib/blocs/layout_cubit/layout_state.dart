part of 'layout_cubit.dart';

@immutable
abstract class LayoutState {}

class LayoutInitial extends LayoutState {}
class ChangePageIndexState extends LayoutState {}
class ChangeCurrentHomeIndexState extends LayoutState {}
class ImageSuccessState extends LayoutState {}
class ChangeScaningState extends LayoutState {}

//=================termes states====================
class GetTermesloadingState extends LayoutState {}
class GetTermesloadedState extends LayoutState {}
class GetTermesErrorState extends LayoutState {}
//=================privacy states=====================
class GetPrivacyloadingState extends  LayoutState {}
class GetPrivacyloadedState extends LayoutState {}
class GetPrivacyErrorState extends LayoutState {}


//==================scan qr code states====================
class ScanQrCodeloadingState extends  LayoutState {}
class ScanQrCodeloadedState extends   LayoutState {}
class ScanQrCodeErrorState extends    LayoutState {}

//==================confirm attendence states====================
class ConfirmAttendenceloadingState extends  LayoutState {}
class ConfirmAttendenceloadedState extends   LayoutState {}
class ConfirmAttendenceErrorState extends    LayoutState {}

//==================upload car body states====================
class UploadCarBodyloadingState extends  LayoutState {}
class UploadCarBodyloadedState extends   LayoutState {}
class UploadCarBodyErrorState extends    LayoutState {}

//===============get profile ==========================

class GetUserDataloadingState extends  LayoutState {}
class GetUserDataloadedState extends   LayoutState {}
class GetUserDataErrorState extends    LayoutState {}

//===============check user avalibality ==========================

class CheckUserAvaliabilityloadingState extends  LayoutState {}
class CheckUserAvaliabilityloadedState extends   LayoutState {}
class CheckUserAvaliabilityErrorState extends    LayoutState {}