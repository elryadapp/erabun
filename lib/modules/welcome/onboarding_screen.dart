import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/core/components/app_button.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sizer/sizer.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Constants.getwidth(context),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
              AppUi.colors.splashColor,
              AppUi.colors.secondryColor
            ])),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 7.w),
          child: AnimationLimiter(
            child: AnimationConfiguration.staggeredList(
              position: 5,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SlideAnimation(
                          verticalOffset: -150,
                          duration: const Duration(milliseconds: 1300),
                          child: Image.asset(AppUi.assets.onboardingImg1)),
                      SlideAnimation(
                        horizontalOffset: -150,
                          duration: const Duration(milliseconds: 1300),
                        child: Image.asset(AppUi.assets.onboradingImg2))
                    ],
                  ),
                  EarbunButton(
                    title: 'تسجيل الدخول',
                    onTap: () {
                      Navigator.pushReplacementNamed(context, Routes.login);
                    },
                    color: AppUi.colors.whiteColor,
                    titleColor: AppUi.colors.mainColor,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  EarbunButton(
                    title: 'انشاء حساب',
                    onTap: () {
                      Navigator.pushReplacementNamed(context, Routes.register);
                    },
                    border: Border.all(color: AppUi.colors.whiteColor),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
