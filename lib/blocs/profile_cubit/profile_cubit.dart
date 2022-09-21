import 'dart:convert';
import 'dart:io';
import 'package:arboon/config/routes/earbun_navigator_keys.dart';
import 'package:arboon/core/components/app_button.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/core/components/app_text_form_field.dart';
import 'package:arboon/core/network/local/cache_helper.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/core/utils/icon_broken.dart';
import 'package:arboon/data/models/app_components_models/time_table_model.dart';
import 'package:arboon/data/models/app_components_models/content_type.dart';
import 'package:arboon/data/models/remote_data_models/auth_models/cities_model.dart';
import 'package:arboon/data/models/remote_data_models/profile_models/center_review_model.dart';
import 'package:arboon/data/models/remote_data_models/profile_models/user_data_model.dart';
import 'package:arboon/data/repos/auth_repo/auth_repository.dart';
import 'package:arboon/data/repos/policy_repo/policy_repo.dart';
import 'package:arboon/data/repos/profile_repo/profile_repo.dart';
import 'package:arboon/data/repos/time_table_repo/time_table_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);

//================setting=============================
  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<void> getWhatsAppUrl(context) async {
    emit(GetWhatsAppUrlloadingState());
    try {
      var res = await GeneralRepository.getSettings();
      if (res['status']) {
        await launchInBrowser(Uri.parse(res['data']['data']['whatsapp']));
        emit(GetWhatsAppUrlLoadedState());
      } else {
        AppUtil.appAlert(context,
            contentType: ContentType.failure, msg: res['message']);
        emit(GetWhatsAppUrlErrorState());
      }
    } catch (error) {
      emit(GetWhatsAppUrlErrorState());
    }
  }

//======================phone edit===================
  TextEditingController newPhoneNum = TextEditingController();
  String newPhoneNumCode = '+966';
  List<TextEditingController> codeControllers =
      List.generate(4, (index) => TextEditingController());

  Future<void> updatePhoneNumber(context) async {
    emit(UpdateMobileloadingState());
    try {
      var res = await ProfileRepository.updatePhoneNumber(
          query: {'phone': newPhoneNumCode + newPhoneNum.text});
      if (res['status']) {
        EarbunNavigatorKeys.mainAppNavigatorKey.currentState!
            .pushNamed(Routes.verifyEditedPhone);
        AppUtil.appAlert(context,
            contentType: ContentType.success, msg: res['message']);
        emit(UpdateMobileloadedState());
      } else {
        AppUtil.appAlert(context,
            contentType: ContentType.failure, msg: res['message']);

        emit(UpdateMobileErrorState());
      }
    } catch (error) {
      emit(UpdateMobileErrorState());
    }
  }

//======================verify mobile ===========================

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
        Navigator.pop(context);

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

  //=================get center reviews======================
  CenterReviewsModel? centerReviewsModel;
  List<ReviewerData> reviewsList = [];
  Future<void> getCenterReviews(context) async {
    emit(GetReviewsloadingState());
    try {
      var res = await ProfileRepository.getReviews();
      centerReviewsModel = CenterReviewsModel.fromJson(res);
      if (centerReviewsModel!.status!) {
        reviewsList = centerReviewsModel?.data ?? [];
        emit(GetReviewsLoadedState());
      } else {
        AppUtil.appAlert(context,
            contentType: ContentType.failure, title: '', msg: 'هناك خطا');
        emit(GetReviewsErrorState());
      }
    } catch (error) {
      emit(GetReviewsErrorState());
    }
  }

//================update table data=================================
  void changeState(id, {from, to}) {
    if (from != null) {
      selectedAppointmentTimeList
          .firstWhere((element) => element.dayId == id)
          .from = from;
    } else {
      selectedAppointmentTimeList
          .firstWhere((element) => element.dayId == id)
          .to = to;
    }
    emit(ChangeState());
  }

  Future<void> updateTimeTable(context) async {
    emit(UpdateProfileTimeTableloadingState());
    try {
      TimeTableModel timeTableModel = TimeTableModel()
        ..data = selectedAppointmentTimeList;
      var res = await TimeTableRepository.updateOrInsertTimeTable(
          query: {"time_table": jsonEncode(timeTableModel)});
      if (res['status']) {
        Navigator.pop(context);
        emit(UpdateProfileTimeTableLoadedState());
      } else {
        AppUtil.appAlert(context,
            contentType: ContentType.failure,
            msg: res['message']);
        emit(UpdateProfileTimeTableErrorState());
      }
    } catch (error) {
      emit(UpdateProfileTimeTableErrorState());
    }
  }

//==============get time table data====================
  List<TimeDataModel> selectedAppointmentTimeList = [];
  TimeTableModel? timeTableModel;
  Future<void> getTimeTableData() async {
    selectedAppointmentTimeList = [];
    emit(GetProfileTimeTableloadingState());
    try {
      var res = await TimeTableRepository.getTimeTable();
      timeTableModel = TimeTableModel.fromJson(res);
      if (timeTableModel!.status!) {
        for (var item in timeTableModel?.data ?? []) {
          selectedAppointmentTimeList.add(TimeDataModel(
              day: item.day,
              dayId: item.dayId,
              from: item.from!.split(':')[0] + ':' + item.from!.split(':')[1],
              to: item.to!.split(':')[0] + ':' + item.to!.split(':')[1]));
          var index = oldAppointmentTimeList
              .indexWhere((element) => element.dayId == item.dayId);
          oldAppointmentTimeList[index].from =
              item.from!.split(':')[0] + ':' + item.from!.split(':')[1];
          oldAppointmentTimeList[index].to =
              item.to!.split(':')[0] + ':' + item.to!.split(':')[1];
        }

        emit(GetProfileTimeTableLoadedState());
      } else {
        emit(GetProfileTimeTableErrorState());
      }
    } catch (error) {
      emit(GetProfileTimeTableErrorState());
    }
  }

  List<TimeDataModel> oldAppointmentTimeList = [
    TimeDataModel(day: 'السبت', to: '', from: '', dayId: 1),
    TimeDataModel(day: 'الاحد', to: '', from: '', dayId: 2),
    TimeDataModel(day: 'الاتنين', to: '', from: '', dayId: 3),
    TimeDataModel(day: 'الثلاثاء', to: '', from: '', dayId: 4),
    TimeDataModel(day: 'الاربعاء', to: '', from: '', dayId: 5),
    TimeDataModel(day: 'الخميس', to: '', from: '', dayId: 6),
    TimeDataModel(day: 'الجمعة', to: '', from: '', dayId: 7)
  ];

  //======================profile requests===========================
  UserDataModel? userDataModel;
  ProfileDataModel? profileDataModel;
  Future<void> getProfileData(context) async {
    emit(GetProfileDataloadingState());
    try {
      await getCities(context);
      var res = await ProfileRepository.getUserData();
      userDataModel = UserDataModel.fromJson(res);

      if (userDataModel!.status!) {
        profileDataModel = userDataModel!.data!.data;
        emailController.text = profileDataModel?.email ?? '';
        centerImageController.text =
            profileDataModel!.image?.split('/').last ?? '';
       
        phoneController.text = profileDataModel?.phone ?? '';
        centerNameController.text = profileDataModel?.name ?? '';
        centerOwnerNameController.text =
            profileDataModel?.examinationCenterOwnerName ?? '';
        comercialReportController.text =
            profileDataModel!.commercialRegisterNumber ?? '';
        stateController.text = profileDataModel!.neighborhood ?? '';
        streetController.text = profileDataModel!.street ?? '';
        status = profileDataModel!.examinationCenterActive ?? 0;
        latLng = LatLng(
          double.parse(profileDataModel!.latitude!),
          double.parse(profileDataModel!.longitude!),
        );
         cityController.text = cities.firstWhere((element) => element.id == profileDataModel!.cityId!)
                .name ??
            '';
        AppUtil.getAddressFromLatLong(latLng!, context)
            .then((value) => locationController.text = value);
        emit(GetProfileDataLoadedState());
      } else {
        emit(GetProfileDataErrorState());
      }
    } catch (error) {
      emit(GetProfileDataErrorState());
    }
  }

  int? status = 1;
  void changeUserStatus(value) {
    status = value;
    emit(ChangeUserStatusState());
  }

  bool isPasswordVisible = true;
  IconData visibilityIcon = IconBroken.Show;
  void changeVisibility() {
    isPasswordVisible = !isPasswordVisible;
    visibilityIcon = !isPasswordVisible ? IconBroken.Hide : IconBroken.Show;
    emit(ChangePasswordVisibilityState());
  }

  bool isPasswordConfirmationVisible = true;
  IconData visibilityConfirmationIcon = IconBroken.Show;
  void changeConfirmationVisibility() {
    isPasswordConfirmationVisible = !isPasswordConfirmationVisible;
    visibilityConfirmationIcon =
        !isPasswordConfirmationVisible ? IconBroken.Hide : IconBroken.Show;
    emit(ChangePasswordVisibilityState());
  }

  String? countryCode = '+966';
  File? centerImage;
  ImagePicker picker = ImagePicker();
  LatLng? latLng;

  Future<void> updateCenterImage(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      centerImage = File(pickedFile.path);
      emit(UpdateCenterImageSuccessState());
    }
  }

  GlobalKey editInfoFormKey = GlobalKey<FormState>();

  final centerImageController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final centerNameController = TextEditingController();
  final centerOwnerNameController = TextEditingController();
  final cityController = TextEditingController();
  final locationController = TextEditingController();
  List<CityModel> cities = [];

  final stateController = TextEditingController();
  final streetController = TextEditingController();
  final comercialReportController = TextEditingController();

  //===============get profile cities======================
  CitiesModel? citiesModel;

  Future<void> getCities(context) async {
    cities = [];
    emit(GetProfileCitiesloadingState());
    try {
      var res = await AuthRepository.getCities();
      citiesModel = CitiesModel.fromJson(res);
      if (citiesModel!.status!) {
        cities = citiesModel?.data ?? [];
        emit(GetProfileCitiesLoadedState());
      } else {
        AppUtil.appAlert(context,
            contentType: ContentType.failure,
            msg: 'حدث خطا برجاء المحاولة لاحقا');
        emit(GetProfileCitiesErrorState());
      }
    } catch (error) {
      emit(GetProfileCitiesErrorState());
    }
  }

//======================change status==========================

  Future<void> changeCenterStatus(status, context) async {
    emit(ChangeProfileStatusloadingState());
    try {
      var res = await ProfileRepository.changeUserStatus(
          query: {'status': status.toString()});
      if (res['status']) {
        AppUtil.appAlert(context,
            contentType: ContentType.success, msg: res['message']);
        emit(ChangeProfileStatusLoadedState());
      } else {
        AppUtil.appAlert(context,
            contentType: ContentType.failure, msg: res['message']);
        emit(ChangeProfileStatusErrorState());
      }
    } catch (error) {
      emit(ChangeProfileStatusErrorState());
    }
  }

  //=============time table data===============================

  void addToSelectedAppointmentList(TimeDataModel appointment) {
    selectedAppointmentTimeList.add(appointment);
     appointmentIds.add(appointment.dayId!);
    changeState(appointment.dayId,from: appointment.from,to:appointment.to);
    emit(AddToNewAppointmentState());
  }

  void change(){
    emit(AddToNewAppointmentState());
  }
 List<int> appointmentIds=[];
           
  void deletFromSelectedAppointmentList(TimeDataModel appointment) {
    selectedAppointmentTimeList.remove(appointment);
    appointmentIds.removeWhere((e)=>e==appointment.dayId);
    emit(DeleteFromNewAppointmentState());
  }

  //============================edit user info===================

  Future<void> editCenterInfo(context) async {
    emit(EditProfileInfoloadingState());
    try {
      ProfileDataModel newCenterInfo = ProfileDataModel()
        ..name =
            centerNameController.text.isEmpty ? '' : centerNameController.text
        ..examinationCenterOwnerName = centerOwnerNameController.text.isEmpty
            ? ''
            : centerOwnerNameController.text
        ..email = emailController.text.isEmpty ? '' : emailController.text
        ..latitude = latLng!.latitude.toString()
        ..longitude = latLng!.longitude.toString()
        ..cityId = cities
            .firstWhere((element) => element.name == cityController.text)
            .id
        ..neighborhood =
            stateController.text.isEmpty ? '' : stateController.text
        ..street = streetController.text.isEmpty ? '' : streetController.text
        ..commercialRegisterNumber = comercialReportController.text.isEmpty
            ? ''
            : comercialReportController.text
        ..password = passwordController.text
        ..passwordConfirmation = confirmPasswordController.text;

      var res = await ProfileRepository.updateUserInfo(
          query: newCenterInfo.toJson(), centerImage: centerImage);
      if (res['status']) {
        AppUtil.appAlert(context,
            contentType: ContentType.success, msg: res['message'], title: '');
        emit(EditProfileInfoLoadedState());
      } else {
        AppUtil.appAlert(context,
            contentType: ContentType.failure, msg: res['message'], title: '');
        emit(EditProfileInfoErrorState());
      }
    } catch (error) {
      emit(EditProfileInfoErrorState());
    }
  }

  //==================show image======================
  bool? isShowed = false;
  void changeIsShowed(value) {
    isShowed = value;
    emit(ChangeCenterImageState());
  }

  //============================logout===================================
  Future<void> logout(context) async {
    emit(LogoutloadingState());
    try {
      await checkUserAvalibality();
      if(isUserAvalibal!){
        var res = await ProfileRepository.logout();
      if (res['status']) {
        centerImage = null;
        profileDataModel = null;
        countryCode = '+966';
        await CacheHelper.clearCache(key: 'jwt');
        await CacheHelper.clearCache(key: 'user_id');
        Constants.token='';
        Constants.userId='';
        Navigator.pushReplacementNamed(
          context,
          Routes.login,
        );
        emit(LogoutloadedState());
      } else {
        emit(LogoutErrorState());
      }

      }
      else{ Navigator.pushReplacementNamed(
          context,
          Routes.login,
        );}
      
    } catch (error) {
      emit(LogoutErrorState());
    }
  }

    bool? isUserAvalibal;
  Future <void>checkUserAvalibality()async{
    try{
     await CacheHelper.getData(key: 'user_id');
      var res=await AuthRepository.checkUserAvaliabality(userId: Constants.userId);
      isUserAvalibal=res["data"]==1;
    }
    catch(error){
     emit(CheckUserAvaliabilityErrorState());
    }
  }

  //================drawer service========================================
  bool? isDrawerOpened = true;
  void changeIsDrawerOpened(val, context) {
    isDrawerOpened = val;

    ZoomDrawer.of(context)!.toggle();

    emit(ChangeIsDrawerOpendState());
  }

  //===================delete account==================
  Future<void> deleteAccount(context) async {
    emit(DeleteAccountloadingState());
    try {
      var res = await ProfileRepository.deleteAccount();
      if (res['status']) {
        print(res);
        Navigator.pushReplacementNamed(context, Routes.login);
        emit(DeleteAccountloadedState());
      } else {
        emit(DeleteAccountErrorState());
      }
    } catch (error) {
      emit(DeleteAccountErrorState());
    }
  }

  //================share app=======================
  Future<void> shareApp(context) async {
    emit(ShareAppLinkloadingState());
    try {
      var res = await ProfileRepository.getAppLink(query: {
        'platform': Platform.isAndroid
            ? 'android'
            : Platform.isIOS
                ? 'ios'
                : ""
      });

      if (res['status']) {
        await Share.share(res['data']['data']['link']);
        emit(ShareAppLinkloadedState());
      } else {
        emit(ShareAppLinkErrorState());
      }
    } catch (error) {
      emit(ShareAppLinkErrorState());
    }
  }
}
