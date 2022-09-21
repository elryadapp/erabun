import 'package:arboon/blocs/profile_cubit/profile_cubit.dart';
import 'package:arboon/core/components/app_app_bar.dart';
import 'package:arboon/core/components/app_button.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/modules/profile_screens/components/edit_appointment_row.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class TimeTableEdit extends StatefulWidget {
  const TimeTableEdit({Key? key}) : super(key: key);

  @override
  State<TimeTableEdit> createState() => _TimeTableEditState();
}

class _TimeTableEditState extends State<TimeTableEdit> {
  @override
  void initState() {
    ProfileCubit.get(context).getTimeTableData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var cubit=ProfileCubit.get(context);
       
        return Scaffold(
          appBar: EarbunAppbar(
            context,
            actions: const[],
            titleText: 'تعديل المواعيد',
          ),
          body: BuildCondition(
            condition: state is GetProfileTimeTableloadingState ,
            builder: (context)=>AppUtil.appLoader(),
            fallback: (context) {
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
                        height: 5.h,
                      ),
                      ...cubit.oldAppointmentTimeList
                          .map((e) => EditAppoinmentRow(appointment: e)),
                  BuildCondition(
                    condition: state is UpdateProfileTimeTableloadingState,
                    builder: (context)=>AppUtil.appLoader(height: 10.h),
                    fallback: (context)=>    EarbunButton(
                        title: 'تعديل المواعيد',
                        onTap: () async{
                          await cubit.updateTimeTable(context);
                        },
                      ),
                  ),
                      SizedBox(
                        height: 1.h,
                      ),
                   
                    ],
                  ),
                ),
              );
            }
          ),
        );
      },
    );
  }
}
