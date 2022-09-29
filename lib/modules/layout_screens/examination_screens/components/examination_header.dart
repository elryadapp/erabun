import 'package:arboon/blocs/examination_cubit/examination_cubit.dart';
import 'package:arboon/blocs/layout_cubit/layout_cubit.dart';
import 'package:arboon/core/components/app_button.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/core/utils/icon_broken.dart';
import 'package:arboon/data/models/app_components_models/app_button_model.dart';
import 'package:arboon/data/models/remote_data_models/appointment_models/all_appointment_model.dart';
import 'package:arboon/modules/layout_screens/home_screens/components/row_button.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class ExaminationHeader extends StatelessWidget {
  final Widget child;
  final bool? isBranched;
  final AppointmentDataModel? appointmentDataModel;
  final Function()? onCheckedTap;
  const ExaminationHeader({
    Key? key,
    required this.child,
    this.isBranched = false,
    this.onCheckedTap,
    this.appointmentDataModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return BlocBuilder<ExaminationCubit, ExaminationState>(
      builder: (context, state) {
        var cubit = ExaminationCubit.get(context);
        return Form(
          key: formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(3.h),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(2.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(AppUi.assets.carIcon),
                          SizedBox(width: 3.w),
                          AppText(
                            appointmentDataModel?.carName ?? '',
                            fontSize: 2.2.h,
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      child,

                      Padding(
                        padding: EdgeInsets.all(2.h),
                        child: cubit.currentIndex == 0
                            ?  Column(
                              children: [
                               
                              
                                
                                !cubit.isExaminationShowed!&&!cubit.isFinished!? RowButton(appButtonModel: [
                                    AppButtonModel(
                                        title: 'فتح الكاميرا',
                                        icon: IconBroken.Camera,
                                        onTap: () {
                                          cubit.chooseImage(ImageSource.camera);
                                        }),
                                    AppButtonModel(
                                        title: 'اختيار من المعرض',
                                        icon: IconBroken.Image,
                                        onTap: () {
                                          cubit
                                              .chooseImage(ImageSource.gallery);
                                        })
                                  ]):Container(),
                                  SizedBox(height: 2.h,),
                            if(   cubit.reportImage!=null&&!cubit.isFinished!)    BuildCondition(
                                    condition:
                                        state is UploadPdfReportloadingState,
                                    builder: (context) =>
                                        AppUtil.appLoader(height: 10.h),
                                    fallback: (context) {
                                      return EarbunButton(
                                        color: AppUi.colors.splashColor,
                                        title: 'رفع صورة التقرير',
                                        fontSize: 1.8.h,
                                        height: 5.3.h,
                                        onTap: () {
                                          cubit.uploadPdfReport(
                                              appointmentDataModel
                                                      ?.carExaminationId ??
                                                  LayoutCubit.get(context)
                                                      .scanQrCodeModel!
                                                      .carExaminationId,
                                              context,
                                              0);
                                              
                                        },
                                      );
                                    }),
                              ],
                            )
                            :!cubit.isFinished!? BuildCondition(
                                condition: state is UploadPdfReportloadingState,
                                builder: (context) =>
                                    AppUtil.appLoader(height: 10.h),
                                fallback: (context) {
                                  return Column(
                                    children: [
                                      EarbunButton(
                                    color: AppUi.colors.splashColor,
                                    title:  'اختر الملف'
                                       ,
                                    fontSize: 1.8.h,
                                    height: 5.3.h,
                                    onTap: () {
                                      if (cubit.currentIndex == 1) {
                                        if (cubit.reportFile == null) {
                                          cubit.pickReportFile();
                                        } 
                                      }
                                    },
                                  ),
                                  SizedBox(height: 2.h,),
                                     if(cubit.reportFile != null&&!cubit.isFinished!) EarbunButton(
                                        color: AppUi.colors.splashColor,
                                        title: 
                                           'رفع الملف',
                                        fontSize: 1.8.h,
                                        height: 5.3.h,
                                        onTap: () {
                                         if (cubit.reportFile != null) {
                                              cubit.uploadPdfReport(
                                                  appointmentDataModel
                                                          ?.carExaminationId ??
                                                      LayoutCubit.get(context)
                                                          .scanQrCodeModel!
                                                          .carExaminationId,
                                                  context,
                                                  1);
                                            }
                                          }
                                        
                                      ),
                                         
                                    ],
                                  );
                                }):Container(),
                      )
                      // if (!cubit.isExaminationShowed!)
                      //   Padding(
                      //       padding: EdgeInsets.symmetric(
                      //           vertical: 3.5.h, horizontal: 3.w),
                      //       child: isBranched!
                      //           ? BuildCondition(
                      //               condition: state
                      //                       is FinishExaminationReportloadingState ||
                      //                   state is UploadPdfReportloadingState,
                      //               builder: (context) =>
                      //                   AppUtil.appLoader(height: 10.h),
                      //               fallback: (context) {
                      //                 return EarbunButton(
                      //                   color: !cubit.examinationStatus
                      //                               .contains('false') &&
                      //                           !cubit.examinationStatus
                      //                               .contains(null)
                      //                       ? AppUi.colors.mainColor
                      //                       : AppUi.colors.secondryColor
                      //                           .withOpacity(.5),
                      //                   title: 'الانتهاء من الفحص ارسل التقرير',
                      //                   onTap: () {
                      //                     if (cubit.currentIndex == 0 &&
                      //                         !cubit.examinationStatus
                      //                             .contains('false') &&
                      //                         !cubit.examinationStatus
                      //                             .contains(null)) {
                      //                       cubit.finishExaminationReport(
                      //                           appointmentDataModel
                      //                                   ?.carExaminationId ??
                      //                               LayoutCubit.get(context)
                      //                                   .scanQrCodeModel!
                      //                                   .carExaminationId,
                      //                           context);
                      //                     } else {
                      //                       AppUtil.appAlert(context,
                      //                           contentType:
                      //                               ContentType.warning,
                      //                           msg:
                      //                               'يجب الانتهاء من جميع الفحوص اولا');
                      //                     }
                      //                   },
                      //                 );
                      //               })
                      //           : cubit.currentIndex == 0
                      //               ? EarbunButton(
                      //                   color: AppUi.colors.splashColor,
                      //                   title: 'تم الفحص',
                      //                   onTap: () {
                      //                     onCheckedTap!();
                      //                   },
                      //                 )
                      //               :state is UploadPdfReportloadingState?
                      //                AppUtil.appLoader(height: 10.h)
                      //               :EarbunButton(
                      //                   color: AppUi.colors.splashColor,
                      //                   title: cubit.reportFile == null
                      //                       ? 'اختر الملف'
                      //                       : 'رفع الملف',
                      //                   fontSize: 1.8.h,
                      //                   height: 5.3.h,
                      //                   onTap: () {
                      //                     if (cubit.currentIndex == 1) {
                      //                       if (cubit.reportFile == null) {
                      //                         cubit.pickReportFile();
                      //                       } else {
                      //                         cubit.uploadPdfReport(
                      //                             appointmentDataModel
                      //                                     ?.carExaminationId ??
                      //                                 LayoutCubit.get(context)
                      //                                     .scanQrCodeModel!
                      //                                     .carExaminationId,
                      //                             context);
                      //                       }
                      //                     }
                      //                   },
                      //                 )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
