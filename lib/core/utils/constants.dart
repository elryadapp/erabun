import 'package:arboon/core/network/local/cache_helper.dart';
import 'package:flutter/cupertino.dart';

class Constants {
  static double getHeight(context) => MediaQuery.of(context).size.height;
  static double getwidth(context) => MediaQuery.of(context).size.width;
  static String token = CacheHelper.getData(key: 'jwt') ?? '';
  static String userId=CacheHelper.getData(key: 'user_id') ?? '';
}
