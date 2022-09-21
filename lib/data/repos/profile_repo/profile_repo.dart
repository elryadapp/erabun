import 'package:arboon/core/network/remote/dio_helper.dart';
import 'package:arboon/core/network/remote/end_points.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:dio/dio.dart'as dio;
import'package:http_parser/http_parser.dart';
class ProfileRepository{
  //===================get user data================
  
  static Future<Map<String, dynamic>> getUserData(
    ) async {
    var res = await DioHelper.getData(
      url: ApiEndPoints.profile,
      token: 'Bearer '+Constants.token
    );
    return res.data;
  }

  //================get reviews====================
    static Future<Map<String, dynamic>> getReviews(
    ) async {
    var res = await DioHelper.getData(
      url: ApiEndPoints.reviews,
      token: 'Bearer '+Constants.token
    );
    return res.data;
  }

  //==============change state====================
    static Future<Map<String, dynamic>> changeUserStatus(
    {Map<String,dynamic>?query}) async {
    var res = await DioHelper.postData(
      url: ApiEndPoints.editStatus,
      query: query,
      token:  'Bearer '+Constants.token

    );
    return res.data;
  }
  //====================update user info=======================
     static Future<Map<String, dynamic>> updateUserInfo(
    {Map<String,dynamic>?query,centerImage}) async {
            var formData = dio.FormData.fromMap(query!);

if(centerImage!=null){
var file = await dio.MultipartFile.fromFile(centerImage!.path,
        filename: centerImage.path.split('/').last,
        contentType: MediaType("image", centerImage.path.split('/').last));

    formData.files.add(MapEntry('image', file));
}
      var response = await DioHelper.postData(
        token: 'Bearer ${Constants.token}',
        url: ApiEndPoints.updateInfo,
        data: formData);
    return response.data;
  }

  //====================logout==================
  static Future<Map<String, dynamic>> logout() async {
    var res = await DioHelper.postData(
        url: ApiEndPoints.logout, token: 'Bearer ${Constants.token}');
    return res.data;
  }

//============update Mobile============
static Future<Map<String,dynamic>>updatePhoneNumber({query})async{
   var res = await DioHelper.postData(
        url: ApiEndPoints.updateMobile,
        data: query,
         token: 'Bearer ${Constants.token}');
    return res.data;
}


//============update Mobile============
static Future<Map<String,dynamic>>deleteAccount()async{
   var res = await DioHelper.getData(
        url: ApiEndPoints.deleteMyAccount,
         token: 'Bearer ${Constants.token}');
    return res.data;
}


//============get app link============
static Future<Map<String,dynamic>>getAppLink({query})async{
   var res = await DioHelper.postData(
        url: ApiEndPoints.appLink,
        data: query,
         token: 'Bearer ${Constants.token}');
    return res.data;
}


}