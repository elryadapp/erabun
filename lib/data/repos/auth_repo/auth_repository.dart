import 'package:arboon/core/network/remote/dio_helper.dart';
import 'package:arboon/core/network/remote/end_points.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http_parser/http_parser.dart';

class AuthRepository {
  //=================registeration==================

  static Future<Map<String, dynamic>> authRegister(
      {Map<String, dynamic>? query, centerImage}) async {
    final formData = dio.FormData.fromMap(query!);

    final file = await dio.MultipartFile.fromFile(centerImage!.path,
        filename: centerImage.path.split('/').last,
        contentType: MediaType("image", centerImage.path.split('/').last));

    formData.files.add(MapEntry('image', file));

    var response = await DioHelper.postData(
        token: 'Bearer ${Constants.token}',
        url: ApiEndPoints.register,
        data: formData);
    return response.data;
  }

  //===================login=======================
  static Future<Map<String, dynamic>> authLogin(
      {Map<String, dynamic>? query}) async {
    var res = await DioHelper.postData(
      url: ApiEndPoints.login,
      data: query,
    );
    return res.data;
  }



  //=====================reset register====================
    static Future<Map<String, dynamic>> sendResetPhone(
      {Map<String, dynamic>? query}) async {
    var res = await DioHelper.postData(
      url: ApiEndPoints.sendResetPasswordEmail,
      data: query,
    );
    return res.data;
  }

//================change password=============================
  static Future<Map<String, dynamic>> changePassword(
      {Map<String, dynamic>? query}) async {
    var res = await DioHelper.postData(
      url: ApiEndPoints.resetPassword,
      data: query,
      token: 'Bearer ${Constants.token}'
    );
    return res.data;
  }

  //=======================verify mobile======================

    static Future<Map<String, dynamic>> verifyMobile(
      {Map<String, dynamic>? query}) async {
    var res = await DioHelper.postData(
      url: ApiEndPoints.verfiyMobile,
      token:'Bearer ${Constants.token}' ,
      data: query,
    );
    return res.data;
  }

//======================resend verification====================
  static Future<Map<String, dynamic>> resendVerification(
      ) async {
    var res = await DioHelper.postData(
      url: ApiEndPoints.resendVerficationCode,
       token:'Bearer ${Constants.token}' ,
    );
    return res.data;
  }
    static Future<Map<String, dynamic>> nextResendVerification(
      ) async {
    var res = await DioHelper.postData(
      url: ApiEndPoints.resendNextVerficationCode,
    );
    return res.data;
  }

  //=================get cities============================

  static Future<Map<String, dynamic>> getCities(
      ) async {
    var res = await DioHelper.getData(
      url: ApiEndPoints.cities,
    );
    return res.data;
  }

//=================get dayes======================

  static Future<Map<String, dynamic>> getDays(
    ) async {
    var res = await DioHelper.getData(
      url: ApiEndPoints.dayes,
    );
    return res.data;
  }


//=================check user avalibality==================

  static Future<Map<String, dynamic>> checkUserAvaliabality(
    {userId}
    ) async {
    var res = await DioHelper.getData(
      url: '${ApiEndPoints.checkUserAvaliabality}/$userId',
    );
    return res.data;
  }
}
