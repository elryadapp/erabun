import 'dart:io';

import 'package:arboon/blocs/appointments_cubit/appointments_cubit.dart';
import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/config/routes/earbun_navigator_keys.dart';
import 'package:arboon/core/network/local/cache_helper.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:arboon/core/utils/icon_broken.dart';
import 'package:arboon/data/models/app_components_models/content_type.dart';
import 'package:arboon/data/models/remote_data_models/appointment_models/all_appointment_model.dart';
import 'package:arboon/data/models/remote_data_models/auth_models/termes_and_conditions_model.dart';
import 'package:arboon/data/models/remote_data_models/profile_models/user_data_model.dart';
import 'package:arboon/data/repos/auth_repo/auth_repository.dart';
import 'package:arboon/data/repos/examination_report_repo/examination_report_repo.dart';
import 'package:arboon/data/repos/policy_repo/policy_repo.dart';
import 'package:arboon/data/repos/profile_repo/profile_repo.dart';
import 'package:arboon/modules/layout_screens/appointments_screens/nested_appointments_screen.dart';
import 'package:arboon/modules/layout_screens/home_screens/nested_home_screen.dart';
import 'package:arboon/modules/layout_screens/reports_screens/nested_reports_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan/scan.dart';

part 'layout_state.dart';

enum ScanType { examinationAppointmentScan, buyerScan }

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
  
  static LayoutCubit get(context) => BlocProvider.of(context);
  List<IconData> pagesIcon = [IconBroken.Calendar, IconBroken.Document];
  List<String> pageTitles = [
    'المواعيد',
    'التقارير',
  ];
  List<Widget> pages = [
    const NestedAppointmentScreen(),
    const NestedReportsScreen(),
    const NestedHomeScreen()
  ];

  AppointmentDataModel? showedAppointment;
  

  //============app navigator======================
  int currentPageIndex = 2;
  final carNumberController = TextEditingController();
  void changeCurrentPageIndex(
    newIndex,
  ) {
    currentPageIndex = newIndex;

    emit(ChangePageIndexState());
  }

  //=====================home screen============================

  File? carImage;
  ImagePicker picker = ImagePicker();
  Future<void> chooseImage(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      carImage = File(pickedFile.path);
      emit(ImageSuccessState());
    }
  }

  //==================get termes==============================
  TermesAndConditionModel? termesAndConditionModel;
  Future<void> getTermesAndConditions() async {
    emit(GetTermesloadingState());
    try {
      var res = await GeneralRepository.getTermes();
      termesAndConditionModel = TermesAndConditionModel.fromJson(res);
      if (termesAndConditionModel!.status!) {
        emit(GetTermesloadedState());
      }
      emit(GetTermesErrorState());
    } catch (error) {
      emit(GetTermesErrorState());
    }
  }

  //==================get conditions========================
  TermesAndConditionModel? policyModel;
  Future<void> getPrivacyPolicy() async {
    emit(GetPrivacyloadingState());
    try {
      var res = await GeneralRepository.getPolicies();
      policyModel = TermesAndConditionModel.fromJson(res, isPolicy: true);
      if (policyModel!.status!) {
        emit(GetPrivacyloadedState());
      } else {
        emit(GetPrivacyErrorState());
      }
    } catch (error) {
      emit(GetPrivacyErrorState());
    }
  }

  //======================qr scanner===================

  ScanType? currentScanType;

  void changeScaningState({ScanType? scanType}) {
    if (scanType != null) {
      currentScanType = scanType;
    } else {
      currentScanType = null;
    }
    emit(ChangeScaningState());
  }

  String? scanningResult;

ScanController qrViewController=ScanController();
void onQRViewCreated() {
   EarbunNavigatorKeys.homeNavigatorKey.currentState!
       .pushNamed(Routes.showAppointment);
 }



  //===============scan qr code=======================
  AppointmentDataModel? scanQrCodeModel;
  String? scanErrorMsg;
  Future<void> scanQrCode(String? appointmentId, context) async {
    emit(ScanQrCodeloadingState());
    try {
      scanErrorMsg = null;
      var res = await ExaminationReportRepository.scanQrCode(
          appointmentId: appointmentId);

      if (res['status']) {
        scanQrCodeModel = AppointmentDataModel.fromJson(res['data']['data']);
        showedAppointment = scanQrCodeModel;
        emit(ScanQrCodeloadedState());
      } else {
        scanErrorMsg = res['message'];
        AppUtil.appAlert(context,
            contentType: ContentType.failure, msg: scanErrorMsg);

        emit(ScanQrCodeErrorState());
      }
      changeScaningState();
    } catch (error) {
      emit(ScanQrCodeErrorState());
    }
  }

  //===============confirm attendence=======================
  Future<void> confirmAttendence( appointmentId, context) async {
    emit(ConfirmAttendenceloadingState());
    try {
      var res = await ExaminationReportRepository.confirmAttendance(
          appointmentId: appointmentId,
          query: {'user_id': scanningResult!});

      if (res['status']) {
        scanQrCodeModel = AppointmentDataModel.fromJson(res['data']['data']);
     showedAppointment = AppointmentDataModel.fromJson(res['data']['data']);
      if(currentPageIndex==0){
        AppointmentsCubit.get(context).getAllAppointments(context);
      }
        emit(ConfirmAttendenceloadedState());
      } else {
        AppUtil.appAlert(context,
            contentType: ContentType.failure, msg: res['message']);

        emit(ConfirmAttendenceErrorState());
      }
      changeScaningState();
    } catch (error) {
      emit(ConfirmAttendenceErrorState());
    }
  }

  //===============upload car body=======================
  Future<void> uploadCarBody(String? appointmentId, context) async {
    emit(UploadCarBodyloadingState());
    try {
      var res = await ExaminationReportRepository.uploadCarBody(
          query: {'car_body_number': carNumberController.text},
          carImage: carImage,
          appointmentId: appointmentId);
      if (res['status']) {
        if (currentPageIndex == 0) {
          EarbunNavigatorKeys.appointmentsNavigatorKey.currentState!
              .pushNamed(Routes.examinationScreen);
        } else if (currentPageIndex == 1) {
          EarbunNavigatorKeys.rebortsNavigatorKey.currentState!
              .pushNamed(Routes.examinationScreen);
        } else {
          EarbunNavigatorKeys.homeNavigatorKey.currentState!
              .pushNamed(Routes.examinationScreen);
        }
        carNumberController.text='';
        carImage=null;

        emit(UploadCarBodyloadedState());
      } else {
        AppUtil.appAlert(context,
            msg: res['message'], contentType: ContentType.failure);
        emit(UploadCarBodyErrorState());
      }
    } catch (error) {
      emit(UploadCarBodyErrorState());
    }
  }

  UserDataModel? userDataModel;
  ProfileDataModel? profileDataModel;
  Future<void> getUserData(context) async {
    emit(GetUserDataloadingState());
    try {
      var res = await ProfileRepository.getUserData();
      userDataModel = UserDataModel.fromJson(res);

      if (userDataModel!.status!) {
        profileDataModel = userDataModel!.data!.data;
        emit(GetUserDataloadedState());
      } else {
        emit(GetUserDataErrorState());
      }
    } catch (error) {
      emit(GetUserDataErrorState());
    }
  }

  //===================check user Avalibality===================
  bool? isUserAvalibal;
  Future <void>checkUserAvalibality()async{
    emit(CheckUserAvaliabilityloadingState());
    try{
     await CacheHelper.getData(key: 'user_id');
      var res=await AuthRepository.checkUserAvaliabality(userId: Constants.userId);
      isUserAvalibal=res["data"]==1;
      emit(CheckUserAvaliabilityloadedState());
    }
    catch(error){
     emit(CheckUserAvaliabilityErrorState());
    }
  }
}
