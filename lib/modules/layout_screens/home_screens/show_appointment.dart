import 'package:arboon/blocs/appointments_cubit/appointments_cubit.dart';
import 'package:arboon/blocs/layout_cubit/layout_cubit.dart';
import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/config/routes/earbun_navigator_keys.dart';
import 'package:arboon/core/components/app_app_bar.dart';
import 'package:arboon/core/components/app_button.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:arboon/data/models/remote_data_models/appointment_models/all_appointment_model.dart';
import 'package:arboon/modules/layout_screens/components/appointment_card.dart';
import 'package:arboon/modules/layout_screens/home_screens/components/home_qr_scanner.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ShowAppointment extends StatefulWidget {
  final AppointmentDataModel? appointmentDataModel;
  final String? id;
  final Function() onQRReview;

  const ShowAppointment({
    Key? key,
    this.appointmentDataModel,
    required this.onQRReview,
    this.id,
  }) : super(key: key);

  @override
  State<ShowAppointment> createState() => _ShowAppointmentState();
}

class _ShowAppointmentState extends State<ShowAppointment> {
  @override
  void initState() {
    var cubit = LayoutCubit.get(context);

    if (cubit.currentScanType != ScanType.examinationAppointmentScan) {
      cubit.confirmAttendence(
          widget.appointmentDataModel?.carExaminationId ??
              cubit.scanQrCodeModel!.carExaminationId,
          context);
    } else {
      cubit.scanQrCode(cubit.scanningResult!, context);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return Scaffold(
          appBar: EarbunAppbar(
            context,
            actions: const [],
            titleText: "عرض الموعد",
          ),
          body: Column(
            children: [
              BuildCondition(
                  condition: state is ScanQrCodeloadingState ||
                      state is ConfirmAttendenceloadingState,
                  builder: (context) => Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: AppUtil.appLoader(),
                      ),
                  fallback: (context) {
                    return BuildCondition(
                        condition: cubit.showedAppointment == null,
                        builder: (context) => Column(
                              children: [
                                SizedBox(
                                  height: 5.h,
                                ),
                                AppUtil.emptyLottie(),
                                AppText(cubit.scanErrorMsg ??
                                    'بيانات الفحص غير صحيحة')
                              ],
                            ),
                        fallback: (context) {
                          return cubit.currentScanType == ScanType.buyerScan
                              ? SizedBox(
                                  height: Constants.getHeight(context) - 140,
                                  child: EarabunQRView(
                                      onQRReview: widget.onQRReview))
                              :  Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3.h, horizontal: 3.w),
                                        child: BuildCondition(
                                            condition: state
                                                is ConfirmAttendenceloadingState,
                                            builder: (context) =>
                                                AppUtil.appLoader(height: 10.h),
                                            fallback: (context) {
                                              return AppointmentCard(
                                                  appointmentDataModel:
                                                      cubit.showedAppointment!,
                                                  isConfirmed: cubit
                                                          .showedAppointment!
                                                          .status ==
                                                      'confirmed',
                                                  firstOnTap: () {
                                                    if (cubit.showedAppointment!
                                                            .status ==
                                                        'confirmed') {
                                                      if (cubit
                                                              .showedAppointment!
                                                              .carImage ==
                                                          0) {
                                                        EarbunNavigatorKeys
                                                            .homeNavigatorKey
                                                            .currentState!
                                                            .pushNamed(
                                                          Routes.carBody,
                                                        );
                                                      } else {
                                                        EarbunNavigatorKeys
                                                            .homeNavigatorKey
                                                            .currentState!
                                                            .pushNamed(
                                                          Routes
                                                              .examinationScreen,
                                                        );
                                                      }
                                                    } else {
                                                      cubit.changeScaningState(
                                                          scanType: ScanType
                                                              .buyerScan);
                                                    }
                                                  },
                                                  lastOnTap: () {
                                                   
                                                    if (cubit
                                                               .showedAppointment!
                                                                .buyerAttend ==
                                                            null &&
                                                        cubit
                                                                .showedAppointment!
                                                                .sellerAttend ==
                                                            null) {
                                                      EarbunNavigatorKeys
                                                          .homeNavigatorKey
                                                          .currentState!
                                                          .pushNamed(cubit
                                                                      .showedAppointment!
                                                                      .status ==
                                                                  'confirmed'
                                                              ? Routes
                                                                  .cancelExamination
                                                              : Routes
                                                                  .cancelAppointment);
                                                    } else {
                                                      AppUtil.appDialoge(
                                                          content: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                AppText(
                                                                  'هل ترغب فى تاكيد الغاء الموعد؟',
                                                                  color: AppUi
                                                                      .colors
                                                                      .mainColor,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          3.w,
                                                                      vertical:
                                                                          2.5.h),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                          child:
                                                                              EarbunButton(
                                                                        title:
                                                                            'تاكيد',
                                                                        fontSize:
                                                                            1.8.h,
                                                                        onTap:
                                                                            () {
                                                                          AppointmentsCubit.get(context).cancelAppointment(
                                                                              cubit.showedAppointment!,
                                                                              context);
                                                                          EarbunNavigatorKeys
                                                                              .mainAppNavigatorKey
                                                                              .currentState!
                                                                              .maybePop();
                                                                        },
                                                                        color: AppUi
                                                                            .colors
                                                                            .confirmationBtnColor
                                                                            .withOpacity(.9),
                                                                        height:
                                                                            4.5.h,
                                                                      )),
                                                                      SizedBox(
                                                                          width:
                                                                              3.w),
                                                                      Expanded(
                                                                          child:
                                                                              EarbunButton(
                                                                        title:
                                                                            'الغاء',
                                                                        fontSize:
                                                                            1.8.h,
                                                                        onTap:
                                                                            () {
                                                                          EarbunNavigatorKeys
                                                                              .mainAppNavigatorKey
                                                                              .currentState!
                                                                              .maybePop();
                                                                        },
                                                                        color: AppUi
                                                                            .colors
                                                                            .failureRed
                                                                            .withOpacity(.9),
                                                                        height:
                                                                            4.5.h,
                                                                      ))
                                                                    ],
                                                                  ),
                                                                )
                                                              ]),
                                                          context: context,
                                                          title: 'تنبيه');
                                                    }
                                                  });

                                            }),
                                      );
                        });
                  }),
            ],
          ),
        );
      },
    );
  }
}
