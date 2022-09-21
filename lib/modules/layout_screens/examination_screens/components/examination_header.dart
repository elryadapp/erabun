import 'package:arboon/blocs/examination_cubit/examination_cubit.dart';
import 'package:arboon/blocs/layout_cubit/layout_cubit.dart';
import 'package:arboon/core/components/app_button.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/data/models/app_components_models/content_type.dart';
import 'package:arboon/data/models/remote_data_models/appointment_models/all_appointment_model.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                      if (!cubit.isExaminationShowed!)
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 3.5.h, horizontal: 3.w),
                            child: isBranched!
                                ? BuildCondition(
                                    condition: state
                                            is FinishExaminationReportloadingState ||
                                        state is UploadPdfReportloadingState,
                                    builder: (context) =>
                                        AppUtil.appLoader(height: 10.h),
                                    fallback: (context) {
                                      return EarbunButton(
                                        color: !cubit.examinationStatus
                                                    .contains('false') &&
                                                !cubit.examinationStatus
                                                    .contains(null)
                                            ? AppUi.colors.mainColor
                                            : AppUi.colors.secondryColor
                                                .withOpacity(.5),
                                        title: 'الانتهاء من الفحص ارسل التقرير',
                                        onTap: () {
                                          if (cubit.currentIndex == 0 &&
                                              !cubit.examinationStatus
                                                  .contains('false') &&
                                              !cubit.examinationStatus
                                                  .contains(null)) {
                                            cubit.finishExaminationReport(
                                                appointmentDataModel
                                                        ?.carExaminationId ??
                                                    LayoutCubit.get(context)
                                                        .scanQrCodeModel!
                                                        .carExaminationId,
                                                context);
                                          } else {
                                            AppUtil.appAlert(context,
                                                contentType:
                                                    ContentType.warning,
                                                msg:
                                                    'يجب الانتهاء من جميع الفحوص اولا');
                                          }
                                        },
                                      );
                                    })
                                : cubit.currentIndex == 0
                                    ? EarbunButton(
                                        color: AppUi.colors.splashColor,
                                        title: 'تم الفحص',
                                        onTap: () {
                                          onCheckedTap!();
                                        },
                                      )
                                    :state is UploadPdfReportloadingState? 
                                     AppUtil.appLoader(height: 10.h)
                                    :EarbunButton(
                                        color: AppUi.colors.splashColor,
                                        title: cubit.reportFile == null
                                            ? 'اختر الملف'
                                            : 'رفع الملف',
                                        fontSize: 1.8.h,
                                        height: 5.3.h,
                                        onTap: () {
                                          if (cubit.currentIndex == 1) {
                                            if (cubit.reportFile == null) {
                                              cubit.pickReportFile();
                                            } else {
                                              cubit.uploadPdfReport(
                                                  appointmentDataModel
                                                          ?.carExaminationId ??
                                                      LayoutCubit.get(context)
                                                          .scanQrCodeModel!
                                                          .carExaminationId,
                                                  context);
                                            }
                                          }
                                        },
                                      )),
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
