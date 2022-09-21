import 'package:flutter/material.dart';

class AppUi {
  static _AppColors get colors => _AppColors();
  static _AppAssets get assets => _AppAssets();
}

class _AppColors {
  
  final helpBlue = const Color(0xff3282B8);
  final failureRed =const Color.fromARGB(255, 158, 9, 29);
  final successGreen = const Color(0xff2D6A4F);
  final warningYellow = const Color(0xffFCA652);
  final secondryColor = const Color(0xff154A79);
  final splashColor = const Color(0xff0B2842);
  final mainColor = const Color(0xff0D3558);
  final subTitleColor = const Color(0xff888888);
  final hintColor = const Color(0xff3A3A3A);
  final confirmationBtnColor = const Color(0xff27A519);
  final whiteColor = Colors.white;
}

class _AppAssets {
  final pdfIcon='assets/icons/pdf.png';
  final noInternet='assets/lottie/no-internet.json';
  final errorIcon='assets/icons/error_icon.png';
  final successIcon='assets/icons/success_icon.png';
  final phoneOTP='assets/lottie/otp.json';
  final passwordOTP='assets/lottie/password.json';
  final networkUrlImgBase='https://earabun.sa/storage/images/';
  final empty='assets/lottie/empty.json';
  final bubbles='assets/icons/bubbles.svg';
  final back='assets/icons/back.svg';
  final failure='assets/icons/failure.svg';
  final success='assets/icons/success.svg';
  final help='assets/icons/help.svg';
  final warning='assets/icons/warning.svg'; 
  final loading = 'assets/lottie/loading.json';
  final fakeUser = 'assets/icons/fake_user.png';
  final external = 'assets/images/external.png';
  final internal = 'assets/images/internal.png';
  final electirc = 'assets/images/electric.png';
  final carIcon = 'assets/icons/car_icon.png';
  final qrBorder = 'assets/images/qr.png';
  final qrCode = 'assets/images/qr_code.png';
  final homeBg = 'assets/images/home_bg.png';
  final fakeCenter = 'assets/images/fake.png';
  final logo = 'assets/images/logo.png';
  final logoMotive = 'assets/images/motive.png';
  final onboardingImg1 = 'assets/images/onboarding_bg.png';
  final onboradingImg2 = 'assets/images/onboarding.png';
  final launcherIcon = 'assets/icons/launcher_logo.png';
  final launcher='assets/images/icon_launcher.png';
}
