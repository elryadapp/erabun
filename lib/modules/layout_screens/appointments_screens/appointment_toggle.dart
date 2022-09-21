import 'package:arboon/blocs/appointments_cubit/appointments_cubit.dart';
import 'package:arboon/core/components/app_button.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class AppointmentToggleWidget extends StatelessWidget {
  const AppointmentToggleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentsCubit, AppointmentsState>(
      builder: (context, state) {
        var cubit =AppointmentsCubit.get(context);
        return Container(
          height: 5.5.h,
          child: Row(
            children: [
              Expanded(
                  child: EarbunButton(
                title: 'المواعيد',
                color: cubit.currentIndex != 0
                    ? AppUi.colors.whiteColor
                    : AppUi.colors.mainColor,
                onTap: () {
                  
                  cubit.changeAppointmentIndex(0);
                },
                fontSize: 2.h,
                titleColor: cubit.currentIndex == 0
                    ? AppUi.colors.whiteColor
                    : AppUi.colors.mainColor,
                borderRadius: BorderRadius.circular(20),
              )),
              Expanded(
                  child: EarbunButton(
                      onTap: () {
                                      
                        cubit.changeAppointmentIndex(1);
                      },
                      fontSize: 2.h,
                      titleColor: cubit.currentIndex == 1
                          ? AppUi.colors.whiteColor
                          : AppUi.colors.mainColor,
                      title: 'المواعيد الملغيه',
                      color: cubit.currentIndex != 1
                          ? AppUi.colors.whiteColor
                          : AppUi.colors.mainColor,
                      borderRadius: BorderRadius.circular(20)))
            ],
          ),
          margin: EdgeInsets.only(left:5.h,right: 5.h,top: 5.h),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    color: AppUi.colors.subTitleColor.withOpacity(.2))
              ],
              borderRadius: BorderRadius.circular(20),
              color: AppUi.colors.whiteColor),
        );
      },
    );
  }
}
