import 'dart:convert';
import 'dart:io';
import 'package:arboon/blocs/profile_cubit/profile_cubit.dart';
import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/core/network/local/cache_helper.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:arboon/core/utils/icon_broken.dart';
import 'package:arboon/data/models/app_components_models/time_table_model.dart';
import 'package:arboon/data/models/app_components_models/content_type.dart';
import 'package:arboon/data/models/remote_data_models/auth_models/cities_model.dart';
import 'package:arboon/data/models/remote_data_models/auth_models/login_model.dart';
import 'package:arboon/data/models/remote_data_models/auth_models/user_model.dart';
import 'package:arboon/data/models/remote_data_models/profile_models/user_data_model.dart';
import 'package:arboon/data/repos/auth_repo/auth_repository.dart';
import 'package:arboon/data/repos/profile_repo/profile_repo.dart';
import 'package:arboon/data/repos/time_table_repo/time_table_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  //===============login data=======================
  final loginFormKey = GlobalKey<FormState>();
  TextEditingController loginPhoneController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  bool isVisibleLogin = true;
  String? loginCountryCode = '+966';

  IconData loginVisibilityIcon = IconBroken.Show;
  void loginChangeVisibility() {
    isVisibleLogin = !isVisibleLogin;
    loginVisibilityIcon = !isVisibleLogin ? IconBroken.Hide : IconBroken.Show;
    emit(LoginVisibilityChangeState());
  }

  Future<void> verifyMobile(context) async {
    emit(VerifyMobileloadingState());
    try {
      var res = await AuthRepository.verifyMobile(query: {
        "2fa": int.parse(codeControllers.map((e) => e.text).toList().join(''))
      });
      if (res['status']) {
        AppUtil.appAlert(context,
            contentType: ContentType.success, msg: res['message']);
        codeControllers = List.generate(4, (index) => TextEditingController());
        Navigator.pushReplacementNamed(context, Routes.layout);

        emit(VerifyMobileloadedState());
      } else {
        AppUtil.appAlert(context,
            contentType: ContentType.failure, msg: res['message']);
        codeControllers = List.generate(4, (index) => TextEditingController());

        emit(VerifyMobileErrorState());
      }
    } catch (error) {
      emit(VerifyMobileErrorState());
    }
  }

  //============resend verfication =================================
  Future<void> resendVerification(context) async {
    emit(ResendVerificationloadingState());
    try {
      var res=await AuthRepository.resendVerification();
      debugPrint(res.toString());
      if(res['status']){
        AppUtil.appAlert(context,contentType: ContentType.success,msg: res['message']);
      emit(ResendVerificationloadedState());

      }
      else{
      emit(ResendVerificationErrorState());

      }
    } catch (error) {
      emit(ResendVerificationErrorState());
    }
  }


//================================login request==================

  Future<void> authLogin(context) async {
    emit(LoginloadingState());
    LoginResponseModel? loginRes;
    try {
      final userDate = UserData()
        ..phone = loginCountryCode! + loginPhoneController.text
        ..password = loginPasswordController.text;
      var res = await AuthRepository.authLogin(query: userDate.toJson());
      loginRes = LoginResponseModel.fromJson(res);
      if (loginRes.status!) {
        await CacheHelper.assignData(key: 'jwt', value: loginRes.data!.token!);
                await CacheHelper.assignData(key: 'user_id', value: loginRes.data!.data!.id.toString());
Constants.userId=loginRes.data!.data!.id.toString();
        Constants.token = loginRes.data!.token!;
        Navigator.pushNamed(context, Routes.layout);
        loginPhoneController = TextEditingController();
        loginPasswordController = TextEditingController();
          ProfileCubit.get(context).changeIsDrawerOpened(true,context);
         await ProfileCubit.get(context).getProfileData(context);
                

        emit(LoginloadedState());
      } else {
        AppUtil.appAlert(context,
            msg: loginRes.message, contentType: ContentType.failure);
        emit(LoginErrorState());
      }
    } catch (error) {
      emit(LoginErrorState());
    }
  }

//=====================register request=========================

  Future<void> authRegister(context) async {
    emit(RegisterloadingState());
    try {
      final userDate = UserData()
        ..phone = registerCountryCode! + registerPhoneController.text
        ..password = registerPasswordController.text
        ..passwordConfirmation = registerConfirmPasswordController.text
        ..name = registerCenterNameController.text
        ..examinationCenterOwnerName = registerCenterOwnerNameController.text
        ..cityId = cities
            .firstWhere(
                (element) => element.name == registerCityController.text)
            .id
        ..commercialRegisterNumber = registerComercialReportController.text
        ..email = registerEmailController.text
        ..latitude = latLng?.latitude ?? 0
        ..longitude = latLng?.longitude ?? 0
        ..neighborhood = registerStateController.text
        ..street = registerStreetController.text;

      var res = await AuthRepository.authRegister(
          query: userDate.toJson(), centerImage: centerImage);
      if (res['status']) {
        AppUtil.appAlert(context,
            msg: res['message'], title: '', contentType: ContentType.success);
        await CacheHelper.assignData(key: 'jwt', value: res['data']['token']);
        await CacheHelper.assignData(key: 'user_id', value: res['data']['data']['id'].toString());
         Constants.userId= res['data']['data']['id'].toString();
        Constants.token = res['data']['token'];
        changeRegisterIndex(1);
        registerCountryCode = '';
        registerPhoneController.text = '';
        registerPasswordController.text = '';
        registerConfirmPasswordController.text = '';
        registerCenterNameController.text = '';
        registerCenterOwnerNameController.text = '';
        registerComercialReportController.text = '';
        registerEmailController.text = '';
        registerStateController.text = '';
        registerStreetController.text = '';
                 ProfileCubit.get(context).changeIsDrawerOpened(true,context);
         await ProfileCubit.get(context).getProfileData(context);
        emit(RegisterloadedState());
      } else {
       AppUtil.appAlert(context,
            msg: res['message'], contentType: ContentType.failure);
        emit(RegisterErrorState());
      }
    } catch (error) {
      emit(RegisterErrorState());
    }
  }

//==================show image======================
  bool? isShowed = false;
  void changeIsShowed(value) {
    isShowed = value;
    emit(ChangeShowedCenterImageState());
  }
  //====================register data==============================

  int currentRegisterIndex = 0;
  void changeRegisterIndex(index) {
    currentRegisterIndex = index;
    emit(RegisterChangeIndexState());
  }

  bool isVisibleRegister = true;

  IconData registerVisibilityIcon = IconBroken.Show;
  void registerChangeVisibility() {
    isVisibleRegister = !isVisibleRegister;
    registerVisibilityIcon =
        !isVisibleRegister ? IconBroken.Hide : IconBroken.Show;
    emit(LoginVisibilityChangeState());
  }

  bool isVisibleConfirmRegister = true;

  IconData registerVisibilityConfirmIcon = IconBroken.Show;
  void registerChangeConfirmVisibility() {
    isVisibleConfirmRegister = !isVisibleConfirmRegister;
    registerVisibilityConfirmIcon =
        !isVisibleConfirmRegister ? IconBroken.Hide : IconBroken.Show;
    emit(LoginVisibilityChangeState());
  }

  String? registerCountryCode = '+966';
  File? centerImage;
  ImagePicker picker = ImagePicker();

  Future<void> chooseCenterImage(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      centerImage = File(pickedFile.path);
      emit(CenterImageSuccessState());
    }
  }

  final registerCenterImageController = TextEditingController();
  LatLng? latLng;
  final registerFormKey = GlobalKey<FormState>();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();
  final registerPhoneController = TextEditingController();
  final registerCenterNameController = TextEditingController();
  final registerCenterOwnerNameController = TextEditingController();
  final registerCityController = TextEditingController();
  final registerLocationController = TextEditingController();

  final registerStateController = TextEditingController();
  final registerStreetController = TextEditingController();
  final registerComercialReportController = TextEditingController();
  List<TextEditingController> codeControllers =
      List.generate(4, (index) => TextEditingController());

//======================send reset passward email=======================
  final resetPasswordPhone = TextEditingController();
  String? resetPasswordPhoneCode = '+966';
  Future<void> sendResetPasswordPhone(context) async {
    emit(SendResetEmailloadingState());
    try {
      var res = await AuthRepository.sendResetPhone(
          query: {'phone': resetPasswordPhoneCode! + resetPasswordPhone.text});
      if (res['status']) {
        Navigator.pop(context);
        AppUtil.appAlert(context,
            contentType: ContentType.success, msg: res['message']);
        resetPasswordPhone.text = '';
        emit(SendResetEmailloadedState());
      } else {
        AppUtil.appAlert(context,
            contentType: ContentType.failure, msg: res['message']);

        emit(SendResetEmailErrorState());
      }
    } catch (error) {
      emit(SendResetEmailErrorState());
    }
  }

//======================change password===========================
  // final password = TextEditingController();
  // final passwordConfirmation = TextEditingController();

  // Future<void> resetPassword(context) async {
  //   emit(ResetPasswordloadingState());
  //   try {
  //     var res = await AuthRepository.changePassword(query: {
  //       'phone': resetPasswordPhoneCode! + resetPasswordPhone.text,
  //       "password": password.text,
  //       "password_confirmation": passwordConfirmation.text
  //     });
  //     if (res['status']) {
  //       Navigator.pushNamed(context, Routes.layout);
  //       emit(ResetPasswordloadedState());
  //     } else {
  //       AppUtil.appAlert(context,
  //           contentType: ContentType.failure, msg: res['message']);
  //       emit(ResetPasswordErrorState());
  //     }
  //   } catch (error) {
  //     emit(ResetPasswordErrorState());
  //   }
  // }

//===================get cities=========================
  CitiesModel? citiesModel;
  List<CityModel> cities = [];

  Future<void> getCities(context) async {
    emit(GetCitiesloadingState());
    try {
      var res = await AuthRepository.getCities();
      citiesModel = CitiesModel.fromJson(res);
      if (citiesModel!.status!) {
        cities = citiesModel?.data ?? [];
        emit(GetCitiesloadedState());
      } else {
        AppUtil.appAlert(context,
            contentType: ContentType.failure,
            msg: 'حدث خطا برجاء المحاولة لاحقا');
        emit(GetCitiesErrorState());
      }
    } catch (error) {
      emit(GetCitiesErrorState());
    }
  }

  //============================timers=======================
  List<TimeDataModel> appointmentTimeList = [
    TimeDataModel(day: 'السبت', to: '', from: '', dayId: 1),
    TimeDataModel(day: 'الاحد', to: '', from: '', dayId: 2),
    TimeDataModel(day: 'الاتنين', to: '', from: '', dayId: 3),
    TimeDataModel(day: 'الثلاثاء', to: '', from: '', dayId: 4),
    TimeDataModel(day: 'الاربعاء', to: '', from: '', dayId: 5),
    TimeDataModel(day: 'الخميس', to: '', from: '', dayId: 6),
    TimeDataModel(day: 'الجمعة', to: '', from: '', dayId: 7)
  ];
  List<TimeDataModel> selectedAppointmentTimeList = [];
  void addToSelectedAppointmentList(TimeDataModel appointment) {
    selectedAppointmentTimeList.add(appointment);
    emit(AddAppointmentState());
  }

  void deletFromSelectedAppointmentList(TimeDataModel appointment) {
    selectedAppointmentTimeList.remove(appointment);
    emit(DeleteAppointmentState());
  }

  //===============time table insert=========================
  void changeState() {
    emit(ChangeState());
  }

  Future<void> timeTableInsert(context) async {
    emit(InsertTimeTableloadingState());
    try {
      TimeTableModel timeTableModel = TimeTableModel()
        ..data = selectedAppointmentTimeList;
      var res = await TimeTableRepository.updateOrInsertTimeTable(
          query: {"time_table": jsonEncode(timeTableModel)});
      if (res['status']) {
        Navigator.pushNamed(context, Routes.verification);

        emit(InsertTimeTableloadedState());
      } else {
        AppUtil.appAlert(context,
            contentType: ContentType.failure, msg: res['message']);

        emit(InsertTimeTableErrorState());
      }
    } catch (error) {
      emit(InsertTimeTableErrorState());
    }
  }
}
