import 'package:arboon/core/network/remote/dio_helper.dart';
import 'package:arboon/core/network/remote/end_points.dart';

class GeneralRepository{
  //============termes=======================
    static Future<Map<String, dynamic>> getTermes(
    ) async {
    var res = await DioHelper.getData(
      url: ApiEndPoints.termes,
    );
    return res.data;
  }
  //=================policies=================
    static Future<Map<String, dynamic>> getPolicies(
    ) async {
    var res = await DioHelper.getData(
      url: ApiEndPoints.privacyPolicy,
    );
    return res.data;
  }

    //=================setting=================
    static Future<Map<String, dynamic>> getSettings(
    ) async {
    var res = await DioHelper.getData(
      url: ApiEndPoints.settings,
    );
    return res.data;
  }
}