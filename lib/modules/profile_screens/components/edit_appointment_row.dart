import 'package:arboon/blocs/profile_cubit/profile_cubit.dart';
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

class EditAppoinmentRow extends StatefulWidget {
  final TimeDataModel appointment;
  const EditAppoinmentRow({Key? key, required this.appointment})
      : super(key: key);

  @override
  State<EditAppoinmentRow> createState() => _EditAppoinmentRowState();
}

class _EditAppoinmentRowState extends State<EditAppoinmentRow> {
  @override
  void initState() {
    ProfileCubit.get(context).appointmentIds = ProfileCubit.get(context)
        .selectedAppointmentTimeList
        .map((e) => e.dayId!)
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);

        return Padding(
          padding: EdgeInsets.only(bottom: 3.h),
          child: Row(
            children: [
              Theme(
                  data:
                      ThemeData(unselectedWidgetColor: AppUi.colors.mainColor),
                  child: Checkbox(
                      activeColor: AppUi.colors.mainColor,
                      value: cubit.appointmentIds
                          .contains(widget.appointment.dayId),
                      onChanged: (value) {
                        if (value!) {
                          AppUtil.appAlert(context,
                              contentType: ContentType.warning,
                              msg:
                                  'ستتم اضافة الموعيد تلقائيا بعد تحديد موعد الفتح و الاغلاق');
                        } else {
                          widget.appointment.from = '';
                          widget.appointment.to = '';
                          cubit.deletFromSelectedAppointmentList(
                              widget.appointment);
                          cubit.change();
                        }
                      })),
              SizedBox(
                width: 17.w,
                child: AppText(
                  widget.appointment.day!,
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
                        barrierDismissible: false,
                        context: context,
                        fromText: 'من',
                        toText: 'الى',
                        use24HourFormat: false,
                      );
                      if (res != null) {
                       if(res.endTime.period!=DayPeriod.am )
                       { var startHour = res.startTime.hour < 10
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
                        widget.appointment.from =
                            startHour.toString() + ':' + startMinute.toString();
                        widget.appointment.to =
                            endHour.toString() + ':' + endMinute.toString();
                        if (widget.appointment.from != '' &&
                            widget.appointment.to != '') {
                          cubit
                              .addToSelectedAppointmentList(widget.appointment);}
                     
                       
                              
                        }
                          else{
                        AppUtil.appAlert(context,contentType: ContentType.warning,msg: 'يجب ان يكون ميعاد الاغلاق بعد ميعاد الفتح');
                       }

                          cubit.change();
                      
                      }

                      
                    },
                    titleWidget: AppText(widget.appointment.from!),
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
                    height: 4.h,
                      onTap: () async {
                      TimeRange? res = await showTimeRangePicker(
                        barrierDismissible: false,
                        context: context,
                        fromText: 'من',
                        toText: 'الى',
                        use24HourFormat: false,
                      );
                      if (res != null) {
                       if(res.endTime.period!=DayPeriod.am )
                       { var startHour = res.startTime.hour < 10
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
                        widget.appointment.from =
                            startHour.toString() + ':' + startMinute.toString();
                        widget.appointment.to =
                            endHour.toString() + ':' + endMinute.toString();
                        if (widget.appointment.from != '' &&
                            widget.appointment.to != '') {
                          cubit
                              .addToSelectedAppointmentList(widget.appointment);}
                     
                       
                              
                        }
                          else{
                        AppUtil.appAlert(context,contentType: ContentType.warning,msg: 'يجب ان يكون ميعاد الاغلاق بعد ميعاد الفتح');
                       }

                          cubit.change();
                      
                      }

                      
                    },
                    titleWidget: AppText(widget.appointment.to!),
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
