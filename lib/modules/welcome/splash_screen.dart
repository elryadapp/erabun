import 'package:arboon/blocs/layout_cubit/layout_cubit.dart';
import 'package:arboon/blocs/profile_cubit/profile_cubit.dart';
import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
        const Duration(
          milliseconds: 2000,
        ), () async {
      if (Constants.token != '') {
        await ProfileCubit.get(context).getProfileData(context);
        Navigator.pushReplacementNamed(context, Routes.layout);
      } else {
        Navigator.pushReplacementNamed(context, Routes.onboarding);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                  AppUi.colors.splashColor,
                  AppUi.colors.secondryColor
                ])),
            child: AnimationLimiter(
              child: AnimationConfiguration.staggeredList(
                position: 5,
                duration: const Duration(milliseconds: 1000),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SlideAnimation(
                        horizontalOffset: 100.0,
                        child: FadeInAnimation(
                            child: SizedBox(
                          width: 200.0,
                          height:18.h,
                          child: Shimmer.fromColors(
                              baseColor:  AppUi.colors.whiteColor,
                              highlightColor: AppUi.colors.subTitleColor.withOpacity(.4),
                              child: Center(
                                child: Image.asset(
                                  AppUi.assets.launcherIcon,
                                  height: 18.h,
                                  fit: BoxFit.cover,
                                ),
                              )),
                        )),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
