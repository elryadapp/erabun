import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/layout/layout_screen.dart';
import 'package:arboon/modules/auth/forget_password/forget_password.dart';
import 'package:arboon/modules/auth/login/login_screen.dart';
import 'package:arboon/core/components/location_screen.dart';
import 'package:arboon/modules/auth/register/register_screen.dart';
import 'package:arboon/modules/auth/verification/verification_screen.dart';
import 'package:arboon/modules/general_screens/privacy_policy_screen.dart';
import 'package:arboon/modules/general_screens/termes_and_condetions_screen.dart';
import 'package:arboon/modules/layout_screens/examination_screens/electric_screen.dart';
import 'package:arboon/modules/layout_screens/examination_screens/external_examination.dart';
import 'package:arboon/modules/layout_screens/examination_screens/internal_examination.dart';
import 'package:arboon/modules/profile_screens/phone_edit.dart';


import 'package:arboon/modules/profile_screens/profile_edit_screen.dart';
import 'package:arboon/modules/profile_screens/profile_screen.dart';
import 'package:arboon/modules/profile_screens/profile_table_edit.dart';
import 'package:arboon/modules/profile_screens/verify_edited_phone.dart';
import 'package:arboon/modules/reviews/reviews_screen.dart';
import 'package:arboon/modules/welcome/onboarding_screen.dart';
import 'package:arboon/modules/welcome/splash_screen.dart';
import 'package:flutter/material.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Routes.onboarding:
        return MaterialPageRoute(
            builder: (context) => const OnBoardingScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case Routes.register:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case Routes.verification:
        return MaterialPageRoute(
            builder: (context) => const VerficationScreen());
      case Routes.forgetPassword:
        return MaterialPageRoute(builder: (context) => const ForegetScreen());
      case Routes.phoneEdit:
        return MaterialPageRoute(builder: (context) => const PhoneEditScreen());
      case Routes.layout:
        return MaterialPageRoute(builder: (context) => const Layout());
       
 case Routes.verifyEditedPhone:
        return MaterialPageRoute(builder: (context) => const VerifyEditedPhone());
      case Routes.profile:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      case Routes.profileEdit:
        return MaterialPageRoute(
            builder: (context) => const ProfileEditScreen());
      case Routes.reviews:
        return MaterialPageRoute(builder: (context) => const ReviewsScreen());
      case Routes.termesAndConditions:
        return MaterialPageRoute(
            builder: (context) => const TermesAndConditionsScreen());
      case Routes.privacyPolicy:
        return MaterialPageRoute(
            builder: (context) => const PrivacyPolicyScreen());
      
     
   
      
      case Routes.location:
        return MaterialPageRoute(builder: (context) => const LocationScreen());
      case Routes.timeTableEdit:
        return MaterialPageRoute(builder: (context) => const TimeTableEdit());

       

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) => Scaffold(body: Container()));
  }
}
