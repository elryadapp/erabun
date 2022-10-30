import 'dart:io';
import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/config/routes/earbun_navigator_keys.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/data/models/app_components_models/content_type.dart';
import 'package:arboon/data/models/app_components_models/examination_steps_model.dart';
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

  int isPDF = 0;
  File? selectedFile;

  void changePdfViewStatus(isPdfViewed, selectedPdfFile) {
    isPDF = isPdfViewed;

    selectedFile = selectedPdfFile;
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
  ];

  //===============finish examination Report=======================
  bool? isFinished = false;
  Future<void> finishExaminationReport(appointmentId, context) async {
    emit(FinishExaminationReportloadingState());
    try {
      isFinished = false;
      var res = await ExaminationReportRepository.finishExaminationReport(
          appointmentId: appointmentId);

      if (res['status']) {
        isFinished = true;
        reportFilesList = [];

        reportImagesList = [];

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
  ImagePicker picker = ImagePicker();
  Future<void> chooseImage(ImageSource imageSource) async {
    final pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      reportImagesList.add(XFile(pickedFile.path));
      emit(ImageSuccessState());
    }
  }

  List<dynamic>reportImagesList = [];

  Future<void> chooseReportImages({ImageSource? imageSource}) async {
    if (imageSource != null) {
      chooseImage(ImageSource.camera);
    }

    final pickedFile = await picker.pickMultiImage();
    if (pickedFile != null) {
      reportImagesList.addAll(pickedFile);

      emit(MultipleImagePickerState());
    }
  }

  List<dynamic> reportFilesList = [];

  Future<void> pickReportFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      reportFilesList = result.paths.map((path) => File(path!)).toList();
      emit(ChangeState());
    }
  }

  int? currentPageIndex;

  Future<void> uploadPdfReport(appointmentId, context) async {
    emit(UploadPdfReportloadingState());
    try {
      var res = await ExaminationReportRepository.uploadPdfReport(
        context,
        appointmentId: appointmentId,
        pdfFile: reportFilesList,
        reportImagesList: reportImagesList,
      );
      if (res['status']) {
        await finishExaminationReport(appointmentId, context);
        if (currentPageIndex == 0) {
          EarbunNavigatorKeys.appointmentsNavigatorKey.currentState!
              .pushNamed(Routes.appointment);
        } else if (currentPageIndex == 1) {
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
      reportModel = null;
      reportFilesList=[];
      reportImagesList=[];
      var res = await ReportsRepositories.getExaminationReport(
          appointmentId: carExaminationId);
      reportModel = GetReportModel.fromJson(res);

      if (reportModel!.status!) {
        reportFilesList=reportModel?.data?.data?.pdfReport??[];
        reportImagesList=reportModel?.data?.data?.otherReport??[];
        emit(GetExaminationDataloadedState());
      } else {
        emit(GetExaminationDataErrorState());
      }
    } catch (error) {
      emit(GetExaminationDataErrorState());
    }
  }

  //==============open pdf report================
  Future<void> launchPdf(selectedUrl) async {
    String url =
        AppUi.assets.networkUrlImgBase + selectedUrl;
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
