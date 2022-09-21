import 'package:arboon/core/network/remote/dio_helper.dart';
import 'package:arboon/core/network/remote/end_points.dart';
import 'package:arboon/core/utils/constants.dart';

class ReportsRepositories{
  //=============get all reports==========================

     static Future<Map<String, dynamic>> getAllReports(
      {page}
    ) async {
    var res = await DioHelper.getData(
      url: '${ApiEndPoints.reports}?page=$page',
      token: 'Bearer '+Constants.token
    );
    return res.data;
  }

  //========================get examination report=======================
  static Future<Map<String, dynamic>> getExaminationReport(
      {Map<String, dynamic>? query, appointmentId}) async {
    var res = await DioHelper.getData(
        url: '${ApiEndPoints.examinationReport}/$appointmentId',
       
        token: 'Bearer ${Constants.token}');
    return res.data;
  }

  

}