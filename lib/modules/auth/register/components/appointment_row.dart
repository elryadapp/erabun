import 'package:arboon/blocs/auth_cubit/auth_cubit.dart';
import 'package:arboon/core/components/app_button.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/data/models/app_components_models/content_type.dart';
import 'package:arboon/data/models/app_components_models/time_table_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:time_range_picker/time_range_picker.dart';

class AppoinmentRow extends StatelessWidget {
  final TimeDataModel appointment;
  const AppoinmentRow({Key? key, required this.appointment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        var authCubit = AuthCubit.get(context);
        return Padding(
          padding: EdgeInsets.only(bottom: 3.h),
          child: Row(
            children: [
              Theme(
                  data:
                      ThemeData(unselectedWidgetColor: AppUi.colors.mainColor),
                  child: Checkbox(
                      activeColor: AppUi.colors.mainColor,
                      value: authCubit.selectedAppointmentTimeList
                          .contains(appointment),
                      onChanged: (value) {
                        if (value!) {
                          AppUtil.appAlert(context,
                              contentType: ContentType.warning,
                              msg:
                                  'ستتم اضافة الموعيد تلقائيا بعد تحديد موعد الفتح و الاغلاق');
                        } else {
                          appointment.from = '';
                          appointment.to = '';
                          authCubit
                              .deletFromSelectedAppointmentList(appointment);
                        }
                      })),
              SizedBox(
                width: 17.w,
                child: AppText(
                  appointment.day!,
                  fontSize: 2.3.h,
                ),
              ),
              SizedBox(
                width: 6.w,
              ),
              AppText(
                'من',
                color: AppUi.colors.subTitleColor,
                fontSize: 2.3.h,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: EarbunButton(
                    height: 4.h,
                    onTap: () async {
                      TimeRange? res = await showTimeRangePicker(
                        context: context,
                        barrierDismissible: false,
                        use24HourFormat: false,
                        fromText: 'من',
                        toText: 'الى',
                      );
                      if (res != null) {
                        if(res.endTime.period!=DayPeriod.am){
 var startHour = res.startTime.hour < 10
                            ? '0${res.startTime.hour}'
                            : '${res.startTime.hour}';
                        var startMinute = res.startTime.minute < 10
                            ? '0${res.startTime.minute}'
                            : '${res.startTime.minute}';
                          var endHour = res.endTime.hour < 10
                            ? '0${res.endTime.hour}'
                            : '${res.endTime.hour}';
                        var endMinute = res.endTime.minute < 10
                            ? '0${res.endTime.minute}'
                            : '${res.endTime.minute}';
                        appointment.from =
                            startHour.toString() + ':' + startMinute.toString();
                        appointment.to =
                            endHour.toString() + ':' + endMinute.toString();
                        if (appointment.from != '' && appointment.to != '') {
                          authCubit.addToSelectedAppointmentList(appointment);
                        }
                      }
                       else{
                                              AppUtil.appAlert(context,contentType: ContentType.warning,msg: 'يجب ان يكون ميعاد الاغلاق بعد ميعاد الفتح');

                    }
                        }
                       
                   
                      authCubit.changeState();
                    },
                    titleWidget: AppText(appointment.from!),
                    color: AppUi.colors.whiteColor,
                    border: Border.all(
                        color: AppUi.colors.subTitleColor.withOpacity(.5)),
                  ),
                ),
              ),
              AppText(
                'الى',
                color: AppUi.colors.subTitleColor,
                fontSize: 2.3.h,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: EarbunButton(
                     onTap: () async {
                      TimeRange? res = await showTimeRangePicker(
                        context: context,
                        barrierDismissible: false,
                        use24HourFormat: false,
                        fromText: 'من',
                        toText: 'الى',
                      );
                      if (res != null) {
                        if(res.endTime.period!=DayPeriod.am){
 var startHour = res.startTime.hour < 10
                            ? '0${res.startTime.hour}'
                            : '${res.startTime.hour}';
                        var startMinute = res.startTime.minute < 10
                            ? '0${res.startTime.minute}'
                            : '${res.startTime.minute}';
                          var endHour = res.endTime.hour < 10
                            ? '0${res.endTime.hour}'
                            : '${res.endTime.hour}';
                        var endMinute = res.endTime.minute < 10
                            ? '0${res.endTime.minute}'
                            : '${res.endTime.minute}';
                        appointment.from =
                            startHour.toString() + ':' + startMinute.toString();
                        appointment.to =
                            endHour.toString() + ':' + endMinute.toString();
                        if (appointment.from != '' && appointment.to != '') {
                          authCubit.addToSelectedAppointmentList(appointment);
                        }
                      }
                      else{
                                              AppUtil.appAlert(context,contentType: ContentType.warning,msg: 'يجب ان يكون ميعاد الاغلاق بعد ميعاد الفتح');

                    }
                        }
                       
                    
                      authCubit.changeState();
                    },
                    height: 4.h,
                    titleWidget: AppText(appointment.to!),
                    color: AppUi.colors.whiteColor,
                    border: Border.all(
                        color: AppUi.colors.subTitleColor.withOpacity(.5)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
