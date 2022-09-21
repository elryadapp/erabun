import 'package:arboon/core/network/local/cache_helper.dart';
import 'package:arboon/core/network/remote/dio_helper.dart';
import 'package:arboon/core/utils/app_bloc_observer.dart';
import 'package:arboon/root/app_root.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async{

   WidgetsFlutterBinding.ensureInitialized();
   await CacheHelper.init();
   await DioHelper.init();

  BlocOverrides.runZoned(
    () =>runApp(  EasyLocalization(
          supportedLocales: const [Locale('ar'), Locale('en')],
          path: 'lang',
          startLocale: const Locale('ar'),
          fallbackLocale: const Locale('ar'),
          child: const Earabun())),
    blocObserver: AppBlocObserver()
  );
}
