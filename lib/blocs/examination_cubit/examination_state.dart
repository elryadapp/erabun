part of 'examination_cubit.dart';

@immutable
abstract class ExaminationState {}

class ExaminationInitial extends ExaminationState {}
class ChangeIsExaminationShowedState extends ExaminationState {}
class ChangeState extends ExaminationState {}
class ChangeExaminationTypeState extends ExaminationState {}

class AddToInternalListState extends ExaminationState{}
class MultipleImagePickerState extends ExaminationState{}
//==================get inside report states====================
class GetInsideReportloadingState extends  ExaminationState {}
class GetInsideReportloadedState extends   ExaminationState {}
class GetInsideReportErrorState extends    ExaminationState {}

//==================get outside report states====================
class GetOutsideReportloadingState extends  ExaminationState {}
class GetOutsideReportloadedState extends   ExaminationState {}
class GetOutsideReportErrorState extends    ExaminationState {}

//==================get inside report states====================
class GetMechanicalReportloadingState extends  ExaminationState {}
class GetMechanicalReportloadedState extends   ExaminationState {}
class GetMechanicalReportErrorState extends    ExaminationState {}



//==================store inside report states====================
class StoreInsideReportloadingState extends  ExaminationState {}
class StoreInsideReportloadedState extends   ExaminationState {}
class StoreInsideReportErrorState extends    ExaminationState {}

//==================store outside report states====================
class StoreOutsideReportloadingState extends  ExaminationState {}
class StoreOutsideReportloadedState extends   ExaminationState {}
class StoreOutsideReportErrorState extends    ExaminationState {}

//==================store inside report states====================
class StoreMechanicalReportloadingState extends  ExaminationState {}
class StoreMechanicalReportloadedState extends   ExaminationState {}
class StoreMechanicalReportErrorState extends    ExaminationState {}

//==================finish examination report states====================
class FinishExaminationReportloadingState extends  ExaminationState {}
class FinishExaminationReportloadedState extends   ExaminationState {}
class FinishExaminationReportErrorState extends    ExaminationState {}

class ImageSuccessState extends    ExaminationState {}


//==================get examination data states====================
class GetExaminationDataloadingState extends  ExaminationState {}
class GetExaminationDataloadedState extends   ExaminationState {}
class GetExaminationDataErrorState extends    ExaminationState {}



//=================upload pdf report states====================
class UploadPdfReportloadingState extends  ExaminationState {}
class UploadPdfReportloadedState extends   ExaminationState {}
class UploadPdfReportErrorState extends    ExaminationState {}


//===============pdf document loading===============
class ViewPdfReportloadingState extends  ExaminationState {}
class ViewPdfReportloadedState extends   ExaminationState {}