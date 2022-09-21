import 'package:arboon/blocs/auth_cubit/auth_cubit.dart';
import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/core/components/app_button.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/modules/auth/register/components/appointment_row.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CompleteInfo extends StatelessWidget {
  const CompleteInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 5.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: AppText(
                      'ادخل مواعيد الفتح والاغلاق',
                      fontSize: 2.3.h,
                    )),
                SizedBox(
                  height: 3.h,
                ),
                ...cubit.appointmentTimeList
                    .map((e) => AppoinmentRow(appointment: e)),
                BuildCondition(
                    condition: state is InsertTimeTableloadingState,
                    builder: (context) => AppUtil.appLoader(height: 10.h),
                    fallback: (context) {
                      return EarbunButton(
                        title: 'انشاء حساب',
                        onTap: () async {
                          await cubit.timeTableInsert(context);
                        },
                      );
                    }),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        ' هل تمتلك حساب ؟',
                        color: AppUi.colors.subTitleColor,
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.login);
                          },
                          child: const AppText('تسجيل دخول'))
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
