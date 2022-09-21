import 'package:arboon/core/network/remote/dio_helper.dart';
import 'package:arboon/core/network/remote/end_points.dart';
import 'package:arboon/core/utils/constants.dart';

class TimeTableRepository{
  //================get time table================
   static Future<Map<String, dynamic>> getTimeTable(
    ) async {
    var res = await DioHelper.getData(
      url: ApiEndPoints.getTimeTable,
            token: 'Bearer '+Constants.token

    );
    return res.data;
  }
  //================update time table============
   

    static Future<Map<String, dynamic>> updateOrInsertTimeTable(
    {Map<String,dynamic>?query}) async {
    var res = await DioHelper.postData(
      url: ApiEndPoints.updateTimeTable,
      data: query,
      token: 'Bearer '+Constants.token
    );
    return res.data;
  }
}