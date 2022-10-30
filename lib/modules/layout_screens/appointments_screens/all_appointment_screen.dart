import 'package:arboon/blocs/appointments_cubit/appointments_cubit.dart';
import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/config/routes/earbun_navigator_keys.dart';
import 'package:arboon/core/components/animated_commponent.dart';
import 'package:arboon/core/components/app_button.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/modules/layout_screens/components/appointment_card.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class AllAppointmentScreen extends StatefulWidget {
  const AllAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AllAppointmentScreen> createState() => _AllAppointmentScreenState();
}

class _AllAppointmentScreenState extends State<AllAppointmentScreen> {
  @override
  void initState() {
    var cubit = AppointmentsCubit.get(context);
    cubit.getAllAppointments(context, page: cubit.page);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentsCubit, AppointmentsState>(
      builder: (context, state) {
        var cubit = AppointmentsCubit.get(context);
        return BuildCondition(
            condition: state is GetAllAppointmentsLoadingState,
            builder: (context) => AppUtil.appLoader(top: 20.h),
            fallback: (context) {
              return Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: BuildCondition(
                        condition: cubit.appointmentList.isEmpty,
                        builder: (context) => Column(
                              children: [
                                AppUtil.emptyLottie(top: 5.h),
                                const AppText('لا يوجد لديك مواعيد ')
                              ],
                            ),
                        fallback: (context) {
                          return ErboonSlideAnimation(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 3.h),
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          AppointmentCard(
                                              appointmentDataModel:
                                                  cubit.appointmentList[index],
                                              isConfirmed: cubit
                                                      .appointmentList[index]
                                                      .status ==
                                                  'confirmed',
                                              firstOnTap: () {
                                                if (cubit.appointmentList[index]
                                                        .status ==
                                                    'confirmed') {
                                                  cubit.currenAppointment =
                                                      cubit.appointmentList[index];
                                                  if (cubit.appointmentList[index]
                                                          .carImage ==
                                                      0) {
                                                    EarbunNavigatorKeys
                                                        .appointmentsNavigatorKey
                                                        .currentState!
                                                        .pushNamed(
                                                      Routes.carBody,
                                                    );
                                                  } else {
                                                    EarbunNavigatorKeys
                                                        .appointmentsNavigatorKey
                                                        .currentState!
                                                        .pushNamed(
                                                      Routes.examinationScreen,
                                                    );
                                                  }
                                                } else {
                                                  cubit.currenAppointment =
                                                      cubit.appointmentList[index];
                                                  cubit.changeIsScan(true);
                                                }
                                              },
                                              lastOnTap: () {
                                                cubit.currenAppointment =
                                                    cubit.appointmentList[index];
                                                if (cubit.appointmentList[index]
                                                            .buyerAttend ==
                                                        null &&
                                                    cubit.appointmentList[index]
                                                            .sellerAttend ==
                                                        null) {
                                                  EarbunNavigatorKeys
                                                      .appointmentsNavigatorKey
                                                      .currentState!
                                                      .pushNamed(cubit
                                                                  .appointmentList[
                                                                      index]
                                                                  .status ==
                                                              'confirmed'
                                                          ? Routes.cancelExamination
                                                          : Routes
                                                              .cancelAppointment);
                                                } 
                                                else if( cubit
                                                      .appointmentList[index]
                                                      .status ==
                                                  'confirmed') {
AppUtil.appDialoge(
                                                      content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            AppText(
                                                              'هل ترغب فى تاكيد الغاء الفحص؟',
                                                              color: AppUi
                                                                  .colors.mainColor,
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          3.w,
                                                                      vertical:
                                                                          2.5.h),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                      child:
                                                                          EarbunButton(
                                                                    title: 'تاكيد',
                                                                    fontSize: 1.8.h,
                                                                    onTap: () {
                                                                      cubit.cancelExamination( cubit.appointmentList[index], context);
                                                                      EarbunNavigatorKeys.mainAppNavigatorKey.currentState!.maybePop();

                                                                    },
                                                                    color: AppUi
                                                                        .colors
                                                                        .confirmationBtnColor
                                                                        .withOpacity(
                                                                            .9),
                                                                    height: 4.5.h,
                                                                  )),
                                                                  SizedBox(
                                                                      width: 3.w),
                                                                  Expanded(
                                                                      child:
                                                                          EarbunButton(
                                                                    title: 'الغاء',
                                                                    fontSize: 1.8.h,
                                                                    onTap: () {
                                                                      EarbunNavigatorKeys.mainAppNavigatorKey.currentState!.maybePop();
                                                                    },
                                                                    color: AppUi
                                                                        .colors
                                                                        .failureRed
                                                                        .withOpacity(
                                                                            .9),
                                                                    height: 4.5.h,
                                                                  ))
                                                                ],
                                                              ),
                                                            )
                                                          ]),
                                                      context: context,
                                                      title: 'تنبيه');
                                                  }
                                                
                                                else{
                                                  AppUtil.appDialoge(
                                                      content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            AppText(
                                                              'هل ترغب فى تاكيد الغاء الموعد؟',
                                                              color: AppUi
                                                                  .colors.mainColor,
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          3.w,
                                                                      vertical:
                                                                          2.5.h),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                      child:
                                                                          EarbunButton(
                                                                    title: 'تاكيد',
                                                                    fontSize: 1.8.h,
                                                                    onTap: () {
                                                                      cubit.cancelAppointment( cubit.appointmentList[index], context);
                                                                      EarbunNavigatorKeys.mainAppNavigatorKey.currentState!.maybePop();

                                                                    },
                                                                    color: AppUi
                                                                        .colors
                                                                        .confirmationBtnColor
                                                                        .withOpacity(
                                                                            .9),
                                                                    height: 4.5.h,
                                                                  )),
                                                                  SizedBox(
                                                                      width: 3.w),
                                                                  Expanded(
                                                                      child:
                                                                          EarbunButton(
                                                                    title: 'الغاء',
                                                                    fontSize: 1.8.h,
                                                                    onTap: () {
                                                                      EarbunNavigatorKeys.mainAppNavigatorKey.currentState!.maybePop();
                                                                    },
                                                                    color: AppUi
                                                                        .colors
                                                                        .failureRed
                                                                        .withOpacity(
                                                                            .9),
                                                                    height: 4.5.h,
                                                                  ))
                                                                ],
                                                              ),
                                                            )
                                                          ]),
                                                      context: context,
                                                      title: 'تنبيه');
                                                }
                                              }),
                                 if  ( state is CancelAppointmentLoadingState )  Container(
                                        width: 20.w,
                                        child: Center(child: AppUtil.appLoader(height: 10.h)),
                                             decoration: BoxDecoration(
          color: AppUi.colors.splashColor.withOpacity(.2),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                blurRadius: 4,
                color: AppUi.colors.subTitleColor.withOpacity(.2))
          ]),
                                       )
                                        ],
                                      ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                  itemCount: cubit.appointmentList.length),
                            ),
                          );
                        }),
                  ),

                // Align(
                //         alignment: Alignment.bottomCenter,
                //         child: Container(

                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(30),
                //             color: AppointmentsCubit.get(context)
                //                     .allAppointmentModel!
                //                     .data!
                //                     .isEmpty
                //                 ? AppUi.colors.failureRed.withOpacity(.9)
                //                 : Colors.transparent,
                //           ),
                //           margin: EdgeInsets.symmetric(horizontal: 5.w,vertical: 6.h),
                //           height: state is GetPaginatedAppointmentsLoadingState
                //               ? AppointmentsCubit.get(context)
                //                     .allAppointmentModel!
                //                       .data!
                //                       .isEmpty
                //                   ? 6.h
                //                   : 12.h
                //               : 0,
                //           width: double.infinity,
                //           child: Center(
                //             child:AppointmentsCubit.get(context)
                //                     .allAppointmentModel!
                //                     .data!
                //                     .isEmpty
                //                 ? AppText(
                //                     'لا يوجد المزيد من المواعيد',
                //                     fontSize: 1.8.h,
                //                     color: AppUi.colors.whiteColor,
                //                   )
                //                 : AppUtil.appLoader(height: 10.h),
                //           ),
                //         ),
                //       )
                 
                  
                 
                   
                ]
              );
            });
      },
    );
  }
}
