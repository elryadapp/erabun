import 'package:arboon/blocs/auth_cubit/auth_cubit.dart';
import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/core/components/app_app_bar.dart';
import 'package:arboon/core/components/app_button.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class VerficationScreen extends StatelessWidget {
  const VerficationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        var authCubit = AuthCubit.get(context);
        return Scaffold(
          appBar: EarbunAppbar(
            context,
            actions: const [],
            titleText: 'تأكيد الحساب',
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 7.h),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(AppUi.assets.passwordOTP, height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: AppText(
                      'سنقوم بإرسال كود على رقمك لتأكيد الحساب',
                      height: .2.h,
                      textAlign: TextAlign.center,
                      fontSize: 2.3.h,
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        children: [
                          ...authCubit.codeControllers.asMap().entries.map(
                            (e) {
                              return Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: TextFormField(
                                        controller: e.value,
                                        onChanged: (value) {
                                          if (value.length == 1 && e.key != 3) {
                                            FocusScope.of(context).nextFocus();
                                          } else {
                                            FocusScope.of(context).unfocus();
                                          }
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical:
                                                  Constants.getwidth(context) *
                                                      0.0153),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              borderSide: BorderSide(
                                                color: AppUi.colors.mainColor,
                                              )),
                                        ))),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  BuildCondition(
                      condition: state is VerifyMobileloadingState,
                      builder: (context) => AppUtil.appLoader(height: 10.h),
                      fallback: (context) {
                        return EarbunButton(
                          title: 'تأكيد',
                          onTap: () {
                            authCubit.verifyMobile(context);
                          },
                        );
                      }),
SizedBox(height: 5.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        if(state is ResendVerificationloadingState)  AppUtil.appLoader(height: 8.h),

                          InkWell(
                            onTap: (){
                              authCubit.resendVerification(context);
                            },
                            child: AppText('اعادة الارسال',textDecoration: TextDecoration.underline,
                            fontSize:2.5.h,
                            ),
                          )

                        ],
                      )

                      
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
