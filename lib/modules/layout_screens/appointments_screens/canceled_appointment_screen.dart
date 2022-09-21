import 'package:arboon/blocs/appointments_cubit/appointments_cubit.dart';
import 'package:arboon/core/components/animated_commponent.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/modules/layout_screens/components/appointment_card.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
class CanceledAppointmentScreen extends StatefulWidget {
  const CanceledAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<CanceledAppointmentScreen> createState() => _CanceledAppointmentScreenState();
}

class _CanceledAppointmentScreenState extends State<CanceledAppointmentScreen> {
  @override
  void initState() {
    var cubit=AppointmentsCubit.get(context);
   cubit.getCanceledAppointments(context,page:cubit.canceledPage );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentsCubit, AppointmentsState>(
      builder: (context, state) {
        var cubit=AppointmentsCubit.get(context);
        return BuildCondition(
            condition: 
                state is GetCanceledAppointmentsLoadingState,
            builder: (context) => AppUtil.appLoader(top:20.h ),
            fallback: (context) {
              return Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: BuildCondition(
                        condition: cubit.canceledappointmentList.isEmpty,
                        builder: (context) => Column(
                              children: [
                                AppUtil.emptyLottie(top: 5.h),
                                const AppText(
                                    ' لا يوجد لديك مواعيد ملغية')
                              ],
                            ),
                        fallback: (context) {
                          return ErboonSlideAnimation(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3.h),
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  physics:
                                      const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      AppointmentCard(
                                          appointmentDataModel:
                                              cubit.canceledappointmentList[
                                                  index],
                                          isConfirmed: cubit
                                                  .canceledappointmentList[
                                                      index]
                                                  .status ==
                                              'confirmed',
                                         ),
                                  separatorBuilder:
                                      (context, index) => SizedBox(
                                            height: 2.h,
                                          ),
                                  itemCount:
                                      cubit.canceledappointmentList.length),
                            ),
                          );
                        }),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppointmentsCubit.get(context)
                                .canceledAppointmentModel!
                                .data!
                                .isEmpty
                            ? AppUi.colors.failureRed.withOpacity(.9)
                            : Colors.transparent,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 5.w,vertical: 6.h),
                      height:
                          state is GetPaginatedCanceledAppointmentsLoadingState
                              ? AppointmentsCubit.get(context)
                                      .canceledAppointmentModel!
                                      .data!
                                      .isEmpty
                                  ? 6.h
                                  : 12.h
                              : 0,
                      width: double.infinity,
                      child: Center(
                        child: AppointmentsCubit.get(context)
                                .canceledAppointmentModel!
                                .data!
                                .isEmpty
                            ? AppText(
                                'لا يوجد المزيد من المواعيد',
                                  fontSize: 1.8.h,
                                color: AppUi.colors.whiteColor,
                              )
                            : AppUtil.appLoader(height: 10.h),
                      ),
                    ),
                  )
                ],
              );
            });
      },
    );
    
  }
}