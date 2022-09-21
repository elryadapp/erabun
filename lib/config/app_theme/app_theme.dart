import 'package:arboon/core/utils/app_ui.dart';
import 'package:flutter/material.dart';

class AppThemes {
 static Map<int, Color> color = {
    50: const Color (0xff0B2842,),
    100: const Color(0xff0B2842),
    200: const Color(0xff0B2842),
    300: const Color(0xff0B2842),
    400: const Color(0xff0B2842),
    500: const Color(0xff0B2842),
    600: const Color(0xff0B2842),
    700: const Color(0xff0B2842),
    800: const Color(0xff0B2842),
    900: const Color(0xff0B2842),
  };

 static ThemeData get lightTheme => ThemeData(
        primarySwatch: MaterialColor(0xff0B2842, color),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          elevation: 20,
          selectedItemColor: AppUi.colors.mainColor,
        ),
        appBarTheme: AppBarTheme(
            titleSpacing: 20,
            centerTitle: true,
            iconTheme: IconThemeData(color:  AppUi.colors.whiteColor),
            titleTextStyle: TextStyle(
              color: AppUi.colors.whiteColor,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
            // systemOverlayStyle: SystemUiOverlayStyle(
            //     statusBarColor: AppUi.colors.mainColor,
            //     statusBarBrightness: Brightness.dark,
            //     statusBarIconBrightness: Brightness.dark),
            // backgroundColor: AppUi.colors.mainColor,
            // elevation: 0,
            // iconTheme: IconThemeData(color: AppUi.colors.whiteColor)),
     
   ) );

     
}