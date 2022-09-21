import 'package:arboon/core/network/remote/dio_helper.dart';
import 'package:arboon/core/network/remote/end_points.dart';
import 'package:arboon/core/utils/constants.dart';

class AppointmentRepository{
//==============================get all appointment========================
     static Future<Map<String, dynamic>> getAllAppointments(
      {page}
    ) async {
    var res = await DioHelper.getData(
      url: '${ApiEndPoints.appointments}?page=$page',
      token: 'Bearer '+Constants.token
    );
    return res.data;
  }

  //========================examination cancelling =============================
static Future<Map<String, dynamic>> cancelExamination(
      {Map<String, dynamic>? query, appointmentId}) async {
    var res = await DioHelper.postData(
        url: '${ApiEndPoints.centerCancelExamination}/$appointmentId',
        data: query,
        token: 'Bearer ${Constants.token}');
    return res.data;
  }


  //========================examination cancelling =============================
static Future<Map<String, dynamic>> cancelAppointment(
      {Map<String, dynamic>? query, appointmentId}) async {
    var res = await DioHelper.postData(
        url: '${ApiEndPoints.cancelAppointment}/$appointmentId',
        data: query,
        token: 'Bearer ${Constants.token}');
    return res.data;
  }

//==============================get canceled appointment========================
     static Future<Map<String, dynamic>> getCanceledAppointments(
      {page}
    ) async {
    var res = await DioHelper.getData(
      url:'${ApiEndPoints.canceledAppointment}?page=$page',
      token: 'Bearer '+Constants.token
    );
    return res.data;
  }

}