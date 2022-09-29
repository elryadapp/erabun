import 'dart:io';

import 'package:arboon/blocs/appointments_cubit/appointments_cubit.dart';
import 'package:arboon/blocs/layout_cubit/layout_cubit.dart';
import 'package:arboon/blocs/reports_cubit/reports_cubit.dart';
import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/config/routes/earbun_navigator_keys.dart';
import 'package:arboon/core/network/local/cache_helper.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/data/models/app_components_models/content_type.dart';
import 'package:arboon/data/models/app_components_models/examination_steps_model.dart';
import 'package:arboon/data/models/remote_data_models/examination_report_models/inside_car_examination_model.dart';
import 'package:arboon/data/models/remote_data_models/examination_report_models/mechanical_car_report_model.dart';
import 'package:arboon/data/models/remote_data_models/examination_report_models/outside_car_examination_model.dart';
import 'package:arboon/data/models/remote_data_models/reports_model/get_report_model.dart';
import 'package:arboon/data/repos/examination_report_repo/examination_report_repo.dart';
import 'package:arboon/data/repos/reports_repo/reports_repositories.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
part 'examination_state.dart';

class ExaminationCubit extends Cubit<ExaminationState> {
  ExaminationCubit() : super(ExaminationInitial());
  static ExaminationCubit get(context) => BlocProvider.of(context);
  void changeState() {
    emit(ChangeState());
  }

  int currentIndex = 0;
  void changeExaminationType(examinationTypeIndex) {
    currentIndex = examinationTypeIndex;
    emit(ChangeExaminationTypeState());
  }

  List<ExaminationStepModel> examinationData = [
    ExaminationStepModel(
      route: Routes.internalExamination,
      title: 'التقرير',
      img: AppUi.assets.internal,
      onTap: () {
        EarbunNavigatorKeys.mainAppNavigatorKey.currentState!
            .pushNamed(Routes.internalExamination);
      },
    ),
    ExaminationStepModel(
      title: "خارج السيارة",
      img: AppUi.assets.external,
      route: Routes.externalExamination,
      onTap: () {
        EarbunNavigatorKeys.mainAppNavigatorKey.currentState!
            .pushNamed(Routes.externalExamination);
      },
    ),
    ExaminationStepModel(
      title: "ميكانيكا الكهرباء",
      route: Routes.elctricExamination,
      img: AppUi.assets.electirc,
      onTap: () {
        EarbunNavigatorKeys.mainAppNavigatorKey.currentState!
            .pushNamed(Routes.elctricExamination);
      },
    )
  ];

  List<String> internalExaminationList = [
    'المقاعد/المراتب',
    'الديكورات',
    'الوسائد الهوائية',
    'الفرشات الارضية',
    'المسجل/الشاشة',
    'التكييف',
    'النوافذ',
    'اخرى'
  ];

  List<String> mechanicalExaminationList = [
    'المحرك/الميكانيكا',
    'ناقل الحركة/القير',
    'الفرامل/الاذرعة/المساعدات',
    'نظام تبريد المحرك',
    'تسريب السوائل/الزيوت',
    'نظام المكيف',
    'الكهرباء/البطارية/فحص نظم الكمبيوتر',
    'اخرى'
  ];
  void addToInternalExaminationList(title) {
    internalExaminationList.add(title);

    emit(AddToInternalListState());
  }

  List<String> externalExaminationList = [
    'البدى/الهيكل الخارجى',
    'الانوار',
    'المساحات',
    'الخدوش',
    'الاطارات/الجنوط',
    'اخرى'
  ];
  void addToExternalExaminationList(title) {
    externalExaminationList.add(title);

    emit(AddToInternalListState());
  }

//=======================multiple image picker===================
  List examinationStatus = List.generate(3, (index) => 'false');

  ImagePicker picker = ImagePicker();
  List<List<XFile>> insideReportImageList = List.generate(8, (index) => []);

  Future<void> chooseInsideReportImages(index) async {
    final pickedFile = await picker.pickMultiImage();
    if (pickedFile != null) {
      insideReportImageList[index] = pickedFile;

      emit(MultipleImagePickerState());
    }
  }

  List<TextEditingController> insideReportConrollers =
      List.generate(8, (index) => TextEditingController());
//=======================external report===================
  List<List<XFile>> outsideReportImageList = List.generate(6, (index) => []);

  Future<void> chooseOutsideReportImages(index) async {
    final pickedFile = await picker.pickMultiImage();
    if (pickedFile != null) {
      outsideReportImageList[index] = pickedFile;

      emit(MultipleImagePickerState());
    }
  }

  List<TextEditingController> outsideReportConrollers =
      List.generate(6, (index) => TextEditingController());

  //=======================mechanical report===================
  List<List<XFile>> mechanicalReportImageList = List.generate(8, (index) => []);

  Future<void> chooseMechanicalReportImages(index) async {
    final pickedFile = await picker.pickMultiImage();
    if (pickedFile != null) {
      mechanicalReportImageList[index] = pickedFile;

      emit(MultipleImagePickerState());
    }
  }

  List<TextEditingController> mechanicalReportConrollers =
      List.generate(8, (index) => TextEditingController());

//===============get Inside Report=======================
  InsideCarReport? insideCarReport;
  final List<List<dynamic>> restoredInsideReportImageList =
      List.generate(8, (index) => []);
  Future<void> getInsideReport(context, {int? appointmentId}) async {
    emit(GetInsideReportloadingState());
    try {
      var res =
          await ExaminationReportRepository.getInsideReport(appointmentId);
      insideCarReport = InsideCarReport.fromJson(res);

      if (insideCarReport!.status!) {
        insideReportConrollers[0].text =
            insideCarReport!.data!.data!.seats ?? '';
        insideReportConrollers[1].text =
            insideCarReport!.data!.data!.decore ?? '';
        insideReportConrollers[2].text =
            insideCarReport!.data!.data!.airbags ?? '';
        insideReportConrollers[3].text =
            insideCarReport!.data!.data!.floorMattresses ?? '';
        insideReportConrollers[4].text =
            insideCarReport!.data!.data!.screen ?? '';
        insideReportConrollers[5].text =
            insideCarReport!.data!.data!.airConditioner ?? '';
        insideReportConrollers[6].text =
            insideCarReport!.data!.data!.windows ?? '';
        insideReportConrollers[7].text =
            insideCarReport!.data!.data!.note ?? '';

        restoredInsideReportImageList[0] =
            insideCarReport!.data!.data!.seatsImage ?? [];
        restoredInsideReportImageList[1] =
            insideCarReport!.data!.data!.decoreImage ?? [];
        restoredInsideReportImageList[2] =
            insideCarReport!.data!.data!.airbagsImage ?? [];
        restoredInsideReportImageList[3] =
            insideCarReport!.data!.data!.floorMattressesImage ?? [];
        restoredInsideReportImageList[4] =
            insideCarReport!.data!.data!.screenImage ?? [];
        restoredInsideReportImageList[5] =
            insideCarReport!.data!.data!.airConditionerImage ?? [];
        restoredInsideReportImageList[6] =
            insideCarReport!.data!.data!.windowsImage ?? [];
        restoredInsideReportImageList[7] =
            insideCarReport!.data!.data!.noteImage ?? [];
        emit(GetInsideReportloadedState());
      } else {
        AppUtil.appAlert(context,
            contentType: ContentType.failure, msg: res['message']);
        emit(GetInsideReportErrorState());
      }
    } catch (error) {
      emit(GetInsideReportErrorState());
    }
  }

//===============get outside Report=======================
  OutsideCarReport? outsideCarReport;
  final List<List<dynamic>> restoredOutsideReportImageList =
      List.generate(6, (index) => []);
  Future<void> getOutsideReport(context, int? appointmentId) async {
    emit(GetOutsideReportloadingState());
    try {
      var res =
          await ExaminationReportRepository.getOutsideReport(appointmentId);
      outsideCarReport = OutsideCarReport.fromJson(res);
      if (outsideCarReport!.status!) {
        outsideReportConrollers[0].text =
            outsideCarReport!.data!.data!.body ?? '';
        outsideReportConrollers[1].text =
            outsideCarReport!.data!.data!.lights ?? '';
        outsideReportConrollers[2].text =
            outsideCarReport!.data!.data!.carWipers ?? '';
        outsideReportConrollers[3].text =
            outsideCarReport!.data!.data!.scratches ?? '';
        outsideReportConrollers[4].text =
            outsideCarReport!.data!.data!.tires ?? '';
        outsideReportConrollers[5].text =
            outsideCarReport!.data!.data!.note ?? '';

        restoredOutsideReportImageList[1] =
            outsideCarReport!.data!.data!.lightsImage ?? [];
        restoredOutsideReportImageList[2] =
            outsideCarReport!.data!.data!.carWipersImage ?? [];
        restoredOutsideReportImageList[3] =
            outsideCarReport!.data!.data!.scratchesImage ?? [];
        restoredOutsideReportImageList[4] =
            outsideCarReport!.data!.data!.tiresImage ?? [];
        restoredOutsideReportImageList[5] =
            outsideCarReport!.data!.data!.noteImage ?? [];
        restoredOutsideReportImageList[0] =
            outsideCarReport!.data!.data!.bodyImage ?? [];

        emit(GetOutsideReportloadedState());
      } else {
        AppUtil.appAlert(context,
            contentType: ContentType.failure, msg: res['message']);
        emit(GetOutsideReportErrorState());
      }
    } catch (error) {
      emit(GetOutsideReportErrorState());
    }
  }

//===============get mechanical Report=======================
  MechanicalCarReport? mechanicalCarReport;
  final List<List<dynamic>> restoredMechaicalReportImageList =
      List.generate(8, (index) => []);
  Future<void> getMechanicalReport(int? appointmentId) async {
    emit(GetMechanicalReportloadingState());
    try {
      var res =
          await ExaminationReportRepository.getMechanicalReport(appointmentId);
      mechanicalCarReport = MechanicalCarReport.fromJson(res);
      if (mechanicalCarReport!.status!) {
        mechanicalReportConrollers[0].text =
            mechanicalCarReport!.data!.data!.engine ?? "";
        mechanicalReportConrollers[1].text =
            mechanicalCarReport!.data!.data!.transmissionGear ?? '';
        mechanicalReportConrollers[2].text =
            mechanicalCarReport!.data!.data!.brakes ?? '';
        mechanicalReportConrollers[3].text =
            mechanicalCarReport!.data!.data!.engineCoolingSystem ?? "";
        mechanicalReportConrollers[4].text =
            mechanicalCarReport!.data!.data!.fluidsOilsLeakage ?? "";
        mechanicalReportConrollers[5].text =
            mechanicalCarReport!.data!.data!.airConditionSystem ?? '';
        mechanicalReportConrollers[6].text =
            mechanicalCarReport!.data!.data!.computerSystemCheck ?? '';
        mechanicalReportConrollers[7].text =
            mechanicalCarReport!.data!.data!.note ?? '';

        restoredMechaicalReportImageList[0] =
            mechanicalCarReport!.data!.data!.engineImage ?? [];
        restoredMechaicalReportImageList[1] =
            mechanicalCarReport!.data!.data!.transmissionGearImage ?? [];
        restoredMechaicalReportImageList[2] =
            mechanicalCarReport!.data!.data!.brakesImage ?? [];
        restoredMechaicalReportImageList[3] =
            mechanicalCarReport!.data!.data!.engineCoolingSystemImage ?? [];
        restoredMechaicalReportImageList[4] =
            mechanicalCarReport!.data!.data!.fluidsOilsLeakageImage ?? [];
        restoredMechaicalReportImageList[5] =
            mechanicalCarReport!.data!.data!.airConditionSystemImage ?? [];
        restoredMechaicalReportImageList[6] =
            mechanicalCarReport!.data!.data!.computerSystemCheckImage ?? [];
        restoredMechaicalReportImageList[7] =
            mechanicalCarReport!.data!.data!.noteImage ?? [];

        emit(GetMechanicalReportloadedState());
      } else {
        emit(GetMechanicalReportErrorState());
      }
    } catch (error) {
      emit(GetMechanicalReportErrorState());
    }
  }

  //===============post Inside Report=======================

  Future<void> storeInsideReport(
    context, {
    int? carExaminationId,
  }) async {
    emit(StoreInsideReportloadingState());
    try {
      InsideCarExaminationDetailedData insideReportData =
          InsideCarExaminationDetailedData()
            ..seats = insideReportConrollers[0].text
            ..decore = insideReportConrollers[1].text
            ..airbags = insideReportConrollers[2].text
            ..airConditioner = insideReportConrollers[5].text
            ..floorMattresses = insideReportConrollers[3].text
            ..screen = insideReportConrollers[4].text
            ..windows = insideReportConrollers[6].text
            ..note = insideReportConrollers[7].text;
      var res = await ExaminationReportRepository.sendInsideReport(
          appointmentId: carExaminationId,
          airConditionerImages: insideReportImageList[5],
          airbagsImages: insideReportImageList[2],
          decoreImages: insideReportImageList[1],
          floorMattressesImages: insideReportImageList[3],
          noteImages: insideReportImageList[7],
          screenImages: insideReportImageList[4],
          seatsImages: insideReportImageList[0],
          windowsImages: insideReportImageList[6],
          query: insideReportData.toJson());
      InsideCarReport response = InsideCarReport.fromJson(res);
      if (response.status!) {
        examinationStatus[0] = await CacheHelper.assignData(
            key: 'isInternalExamined$carExaminationId', value: 'true');
        examinationStatus[0] = await CacheHelper.getData(
          key: 'isInternalExamined$carExaminationId',
        );

        EarbunNavigatorKeys.mainAppNavigatorKey.currentState!.pop(context);
        insideReportConrollers =
            List.generate(8, (index) => TextEditingController());
        insideReportImageList = List.generate(8, (index) => []);

        emit(StoreInsideReportloadedState());
      } else {
        AppUtil.appAlert(context,
            msg: res['message'], contentType: ContentType.failure);
        emit(StoreInsideReportErrorState());
      }
    } catch (error) {
      emit(StoreInsideReportErrorState());
    }
  }

//===============post outside Report=======================

  Future<void> storeOutsideReport(
    context, {
    int? carExaminationId,
  }) async {
    emit(StoreOutsideReportloadingState());
    try {
      OutsideCarDetailedReportData outsideReportData =
          OutsideCarDetailedReportData()
            ..body = outsideReportConrollers[0].text
            ..lights = outsideReportConrollers[1].text
            ..carWipers = outsideReportConrollers[2].text
            ..scratches = outsideReportConrollers[5].text
            ..tires = outsideReportConrollers[3].text
            ..note = outsideReportConrollers[4].text;

      var res = await ExaminationReportRepository.sendOutsideReport(
          appointmentId: carExaminationId,
          bodyImage: outsideReportImageList[0],
          lightsImage: outsideReportImageList[1],
          carWipersImage: outsideReportImageList[2],
          scratchesImage: outsideReportImageList[3],
          tiresImage: outsideReportImageList[4],
          noteImage: outsideReportImageList[5],
          query: outsideReportData.toJson());
      OutsideCarReport response = OutsideCarReport.fromJson(res);
      if (response.status!) {
        examinationStatus[1] = await CacheHelper.assignData(
            key: 'isExternalExamined$carExaminationId', value: 'true');
        examinationStatus[1] = await CacheHelper.getData(
          key: 'isExternalExamined$carExaminationId',
        );

        EarbunNavigatorKeys.mainAppNavigatorKey.currentState!.pop(context);
        outsideReportConrollers =
            List.generate(6, (index) => TextEditingController());
        outsideReportImageList = List.generate(6, (index) => []);
        emit(StoreOutsideReportloadedState());
      } else {
        AppUtil.appAlert(context,
            msg: res['message'], contentType: ContentType.failure);
        emit(StoreOutsideReportErrorState());
      }
    } catch (error) {
      emit(StoreOutsideReportErrorState());
    }
  }
//===============post mechanical Report=======================

  Future<void> storeMechanicalReport(
    context, {
    int? carExaminationId,
  }) 
  async {
    emit(StoreMechanicalReportloadingState());
    try {
      MechanicalCarDetailedReportData1 mechanicalReportData =
          MechanicalCarDetailedReportData1()
            ..engine = mechanicalReportConrollers[0].text
            ..transmissionGear = mechanicalReportConrollers[1].text
            ..brakes = mechanicalReportConrollers[2].text
            ..engineCoolingSystem = mechanicalReportConrollers[3].text
            ..fluidsOilsLeakage = mechanicalReportConrollers[4].text
            ..airConditionSystem = mechanicalReportConrollers[5].text
            ..computerSystemCheck = mechanicalReportConrollers[6].text
            ..note = mechanicalReportConrollers[7].text;

      var res = await ExaminationReportRepository.sendMechanicalReport(
          appointmentId: carExaminationId,
          query: mechanicalReportData.toJson(),
          airConditionSystemImage: mechanicalReportImageList[5],
          brakesImage: mechanicalReportImageList[2],
          computerSystemCheckImage: mechanicalReportImageList[6],
          engineCoolingSystemImage: mechanicalReportImageList[3],
          engineImage: mechanicalReportImageList[0],
          fluidsOilsLeakageImage: mechanicalReportImageList[4],
          noteImage: mechanicalReportImageList[7],
          transmissionGearImage: mechanicalReportImageList[1]);
      MechanicalCarReport response = MechanicalCarReport.fromJson(res);
      if (response.status!) {
        examinationStatus[2] = await CacheHelper.assignData(
            key: 'isMechanicalExamined$carExaminationId', value: 'true');
        examinationStatus[2] = await CacheHelper.getData(
            key: 'isMechanicalExamined$carExaminationId');
        EarbunNavigatorKeys.mainAppNavigatorKey.currentState!.pop(context);
        mechanicalReportConrollers =
            List.generate(8, (index) => TextEditingController());
        mechanicalReportImageList = List.generate(8, (index) => []);
        emit(StoreMechanicalReportloadedState());
      } else {
        AppUtil.appAlert(context,
            msg: res['message'], contentType: ContentType.failure);
        emit(StoreMechanicalReportErrorState());
      }
    } catch (error) {
      emit(StoreMechanicalReportErrorState());
    }
  }

  //===============finish examination Report=======================
  bool? isFinished=false;
  Future<void> finishExaminationReport(appointmentId, context) async {
    emit(FinishExaminationReportloadingState());
    try {
isFinished=false;
      var res = await ExaminationReportRepository.finishExaminationReport(
          appointmentId: appointmentId);
                  

      if (res['status']) {

        
        isFinished=true;
reportFile = null;

        reportImage = null;
       
        // await CacheHelper.clearCache(key: 'isInternalExamined$appointmentId');
        // await CacheHelper.clearCache(key: 'isMechanicalExamined$appointmentId');
        // await CacheHelper.clearCache(key: 'isExternalExamined$appointmentId');
        // examinationStatus = List.generate(3, (index) => 'false');

        emit(FinishExaminationReportloadedState());
      } else {
        AppUtil.appAlert(context,
            contentType: ContentType.success, msg: res['message']);

        emit(FinishExaminationReportErrorState());
      }
    } catch (error) {
      emit(FinishExaminationReportErrorState());
    }
  }

  //=========================get examination data============================
  bool? isExaminationShowed = false;
  void changeIsExaminationShowed(val) {
    isExaminationShowed = val;
    emit(ChangeIsExaminationShowedState());
  }

  //=============pdf reports==================
  File? reportFile;
  File? reportImage;
  Future<void> chooseImage(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      reportImage = File(pickedFile.path);
      emit(ImageSuccessState());
    }
  }

  Future<void> pickReportFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      reportFile = File(result.files.single.path!);
      emit(ChangeState());
    }
  }

int? currentPageIndex;
  
  Future<void> uploadPdfReport(appointmentId, context, isPDF) async {
    emit(UploadPdfReportloadingState());
    try {
  
     var res = await ExaminationReportRepository.uploadPdfReport(context,
          appointmentId: appointmentId, pdfFile:isPDF==1? reportFile:reportImage, isPDF: isPDF);
      if (res['status']) {
               
               
       await finishExaminationReport(appointmentId, context);
        if (currentPageIndex == 0) {
          AppointmentsCubit.get(context).scrollController=null;
          EarbunNavigatorKeys.appointmentsNavigatorKey.currentState!
              .pushNamed(Routes.appointment);
        } else if (currentPageIndex == 1) {
                    ReportsCubit.get(context).scrollController=null;

          EarbunNavigatorKeys.rebortsNavigatorKey.currentState!
              .pushNamed(Routes.reports);
        } else {
          EarbunNavigatorKeys.homeNavigatorKey.currentState!
              .pushNamed(Routes.mainHome);
        }
        emit(UploadPdfReportloadedState());
      } else {
        AppUtil.appAlert(context,
            contentType: ContentType.success, msg: res['messages']);

        emit(UploadPdfReportErrorState());
      }
    } catch (error) {
      emit(UploadPdfReportErrorState());
    }
  }

  GetReportModel? reportModel;

  Future<void> getExaminationData(carExaminationId) async {
    emit(GetExaminationDataloadingState());
    try {
      reportModel=null;
      var res = await ReportsRepositories.getExaminationReport(
          appointmentId: carExaminationId);
      reportModel = GetReportModel.fromJson(res);
     


      if (reportModel!.status!) {
        emit(GetExaminationDataloadedState());
      } else {
        emit(GetExaminationDataErrorState());
      }
    } catch (error) {
      emit(GetExaminationDataErrorState());
    }
  }

  //==============open pdf report================
  Future<void> launchPdf() async {
    String url =
        AppUi.assets.networkUrlImgBase + reportModel!.data!.data!.pdfReport!;
    emit(ViewPdfReportloadingState());
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }

    emit(ViewPdfReportloadedState());
  }
}
