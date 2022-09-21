import 'package:arboon/core/network/remote/dio_helper.dart';
import 'package:arboon/core/network/remote/end_points.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class ExaminationReportRepository {
//==========================scan data post========================
  static Future<Map<String, dynamic>> scanQrCode(
      {Map<String, dynamic>? query, appointmentId}) async {
    var res = await DioHelper.postData(
        url: '${ApiEndPoints.scanQrCode}/$appointmentId',
        data: query,
        token: 'Bearer ${Constants.token}');
    return res.data;
  }

//==========================pdf report  post========================
  static Future<Map<String, dynamic>> uploadPdfReport(
      { appointmentId, pdfFile}) async {
    var formData = dio.FormData.fromMap({});

    if (pdfFile != null) {
      var file = await dio.MultipartFile.fromFile(pdfFile!.path,
          filename: pdfFile.path.split('/').last,
          contentType: MediaType("file", pdfFile.path.split('/').last));

      formData.files.add(MapEntry('pdf_report', file));
    }
    var response = await DioHelper.postData(
        token: 'Bearer ${Constants.token}',
        url: '${ApiEndPoints.examinationReportPdf}/$appointmentId',
        data: formData);
    return response.data;
  }
  //=======================confirm attendance===================
  static Future<Map<String, dynamic>> confirmAttendance(
      {Map<String, dynamic>? query, appointmentId}) async {
    var res = await DioHelper.postData(
        url: '${ApiEndPoints.confirmAttendance}/$appointmentId',
        data: query,
        token: 'Bearer ${Constants.token}');
    return res.data;
  }

  //==================upload car body==============================
  static Future<Map<String, dynamic>> uploadCarBody(
      {Map<String, dynamic>? query, appointmentId, carImage}) async {
    var formData = dio.FormData.fromMap(query!);

    if (carImage != null) {
      var file = await dio.MultipartFile.fromFile(carImage!.path,
          filename: carImage.path.split('/').last,
          contentType: MediaType("image", carImage.path.split('/').last));

      formData.files.add(MapEntry('car_body_number_image', file));
    }
    var response = await DioHelper.postData(
        token: 'Bearer ${Constants.token}',
        url: '${ApiEndPoints.uploadCarBodyImage}/$appointmentId',
        data: formData);
    return response.data;
  }

//=====================send inside report===================
  static dio.FormData? formData;
  static void listGeneration(list, key) async {
    for (var i = 0; i < list!.length; i++) {
      final file = await dio.MultipartFile.fromFile(list[i].path,
          filename: list[i].path.split('/').last,
          contentType: MediaType("$Key[$i]", list[i].path.split('/').last));

      formData!.files.add(MapEntry('$key[$i]', file));
    }
  }

  static Future<Map<String, dynamic>> sendInsideReport({
    Map<String, dynamic>? query,
    appointmentId,
    List<XFile>? seatsImages,
    List<XFile>? decoreImages,
    List<XFile>? airbagsImages,
    List<XFile>? floorMattressesImages,
    List<XFile>? airConditionerImages,
    List<XFile>? screenImages,
    List<XFile>? windowsImages,
    List<XFile>? noteImages,
  }) async {
    formData = dio.FormData.fromMap(query!);
    listGeneration(seatsImages!, 'seats_image');
    listGeneration(decoreImages!, 'decore_image');
    listGeneration(airbagsImages!, 'airbags_image');
    listGeneration(floorMattressesImages!, 'floor_mattresses_image');
    listGeneration(airConditionerImages!, 'air_conditioner_image');
    listGeneration(noteImages!, 'note_image');
    listGeneration(windowsImages!, 'windows_image');
    listGeneration(screenImages!, 'screen_image');

    var response = await DioHelper.postData(
        token: 'Bearer ${Constants.token}',
        url: '${ApiEndPoints.storeInsideCarReport}/$appointmentId',
        data: formData);

    return response.data;
  }

//=====================send outside report==================
  static Future<Map<String, dynamic>> sendOutsideReport(
      {Map<String, dynamic>? query,
      appointmentId,
      bodyImage,
      lightsImage,
      tiresImage,
      carWipersImage,
      scratchesImage,
      noteImage}) async {
    formData = dio.FormData.fromMap(query!);
    listGeneration(bodyImage!, 'body_image');
    listGeneration(lightsImage!, 'lights_image');
    listGeneration(tiresImage!, 'tires_image');
    listGeneration(carWipersImage!, 'car_wipers_image');
    listGeneration(scratchesImage!, 'scratches_image');
    listGeneration(noteImage!, 'note_image');

    var response = await DioHelper.postData(
        token: 'Bearer ${Constants.token}',
        url: '${ApiEndPoints.storeOutsideCarReport}/$appointmentId',
        data: formData);
    return response.data;
  }

//=====================send mechanical report===============
  static Future<Map<String, dynamic>> sendMechanicalReport(
      {Map<String, dynamic>? query,
      appointmentId,
      transmissionGearImage,
      engineImage,
      brakesImage,
      engineCoolingSystemImage,
      fluidsOilsLeakageImage,
      airConditionSystemImage,
      computerSystemCheckImage,
      noteImage}) async {
    formData = dio.FormData.fromMap(query!);
    listGeneration(transmissionGearImage!, 'transmission_gear_image');
    listGeneration(engineImage!, 'engine_image');
    listGeneration(brakesImage!, 'brakes_image');
    listGeneration(engineCoolingSystemImage!, 'engine_cooling_system_image');
    listGeneration(fluidsOilsLeakageImage!, 'fluids_oils_leakage_image');
     listGeneration(airConditionSystemImage!, 'air_condition_system_image');
    listGeneration(computerSystemCheckImage!, 'computer_system_check_image');
    listGeneration(noteImage!, 'note_image');

    var response = await DioHelper.postData(
        token: 'Bearer ${Constants.token}',
        url: '${ApiEndPoints.storeMechnicalCarReport}/$appointmentId',
        data: formData);
    return response.data;
  }

  //=================get inside report=======================
  static Future<Map<String, dynamic>> getInsideReport(appointmentId) async {
    var res = await DioHelper.getData(
        url: '${ApiEndPoints.getInsideCarReport}/$appointmentId',
        token: 'Bearer ${Constants.token}');
    return res.data;
  }

  //=================get out side report=====================
  static Future<Map<String, dynamic>> getOutsideReport(appointmentId) async {
    var res = await DioHelper.getData(
        url: '${ApiEndPoints.getOutsideCarReport}/$appointmentId',
        token: 'Bearer ${Constants.token}');
    return res.data;
  }

  //=================get mechanical report===================
  static Future<Map<String, dynamic>> getMechanicalReport(appointmentId) async {
    var res = await DioHelper.getData(
        url: '${ApiEndPoints.getMechnicalCarReport}/$appointmentId',
        token: 'Bearer ${Constants.token}');
    return res.data;
  }
//===============finish examination report======================

  static Future<Map<String, dynamic>> finishExaminationReport(
      {Map<String, dynamic>? query, appointmentId}) async {
    var res = await DioHelper.postData(
        url: '${ApiEndPoints.finishReport}/$appointmentId',
        data: query,
        token: 'Bearer ${Constants.token}');
    return res.data;
  }
}
