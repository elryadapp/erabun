import 'package:arboon/blocs/profile_cubit/profile_cubit.dart';
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

class VerifyEditedPhone extends StatelessWidget {
  const VerifyEditedPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        return Scaffold(
          appBar: EarbunAppbar(context,
          titleText: 'تاكيد رقم الهاتف',
          actions:const [],
          ),
          body: SingleChildScrollView(
             physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Center(
               child:
                   Lottie.asset(AppUi.assets.passwordOTP, height: 37.h,fit: BoxFit.cover)),
           Padding(
             padding: EdgeInsets.only(bottom: 1.5.h),
             child: const AppText(
               'ادخل الكود المرسل اليك',
             ),
           ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        children: [
                          ...cubit.codeControllers.asMap().entries.map(
                            (e) {
                              return Expanded(
                                child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 5),
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
                                              vertical: Constants.getwidth(context) *
                                                  0.0153),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
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
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.h, left: 3.w, right: 3.w),
                    child: BuildCondition(
                        condition: state is VerifyMobileloadingState,
                        builder: (context) => AppUtil.appLoader(height: 10.h),
                        fallback: (context) {
                          return EarbunButton(
                            onTap: () {
                              cubit.verifyMobile(context);
                            },
                            title: 'ارسال',
                          );
                        }),
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
