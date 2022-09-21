import 'package:arboon/blocs/examination_cubit/examination_cubit.dart';
import 'package:arboon/core/components/app_app_bar.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/data/models/app_components_models/content_type.dart';
import 'package:arboon/modules/layout_screens/examination_screens/components/examination_header.dart';
import 'package:arboon/modules/layout_screens/examination_screens/components/report_images_view.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class InternalExamination extends StatefulWidget {
  final dynamic carObg;
  const InternalExamination({Key? key, required this.carObg}) : super(key: key);

  @override
  State<InternalExamination> createState() => _InternalExaminationState();
}

class _InternalExaminationState extends State<InternalExamination> {
  @override
  void initState() {
    var cubit = ExaminationCubit.get(context);

    if (cubit.examinationStatus[0] == 'true' || cubit.isExaminationShowed!) {
      cubit.getInsideReport(context,
          appointmentId: widget.carObg.carExaminationId);
    }



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExaminationCubit, ExaminationState>(
      builder: (context, state) {
        var cubit = ExaminationCubit.get(context);
        return Scaffold(
          appBar: EarbunAppbar(context,
              actions: const [], titleText: 'المقصورة الداخلية'),
          body: ExaminationHeader(
            appointmentDataModel: widget.carObg,
            onCheckedTap: () {
              if (cubit.examinationStatus[0] != 'true') {
                cubit.storeInsideReport(context,
                    carExaminationId: widget.carObg.carExaminationId);
              } else {
                AppUtil.appAlert(context,
                    contentType: ContentType.warning,
                    msg: ' هذه البيانات تم تسجلها بالفعل ');
              }
            },
            child: BuildCondition(
                condition: state is GetInsideReportloadingState,
                builder: (context) => AppUtil.appLoader(),
                fallback: (context) {
                  return Column(
                    children: [
                      Column(
                        children: [
                          Image.asset(AppUi.assets.internal),
                          SizedBox(
                            height: 2.h,
                          ),
                          const AppText(
                            'المقصورة الداخلية',
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      ...cubit.internalExaminationList
                          .asMap()
                          .entries
                          .map((e) => Column(
                                children: [
                                  Row(
                                    children: [
                                   cubit.examinationStatus[0] == 'true' || !cubit.isExaminationShowed!?
                                    Theme(
                                        data: ThemeData(
                                          unselectedWidgetColor:
                                              AppUi.colors.mainColor,
                                        ),
                                        child: Checkbox(
                                          activeColor: AppUi.colors.mainColor,
                                          value: cubit
                                              .insideReportImageList[e.key]
                                              .isNotEmpty,
                                          onChanged: (value) {},
                                        ),
                                      ):SizedBox(width: 2.7.w,height: 6.h,),
                                      AppText(e.value),
                                    ],
                                  ),
                                  ReportImagesView(
                                    isEditied:
                                        cubit.examinationStatus[0] != 'true' &&
                                            !cubit.isExaminationShowed!,
                                    insideReportConroller:
                                        cubit.insideReportConrollers[e.key],
                                    onTap: () {
                                      if (cubit.examinationStatus[0] !=
                                              'true' ||
                                          !cubit.isExaminationShowed!) {
                                        cubit.chooseInsideReportImages(e.key);
                                      }
                                    },
                                    currentList: cubit.examinationStatus[0] ==
                                                'true' ||
                                            cubit.isExaminationShowed!
                                        ? cubit.restoredInsideReportImageList[
                                            e.key]
                                        : cubit.insideReportImageList[e.key],
                                  )
                                ],
                              )),
                      SizedBox(
                        height: 2.h,
                      ),
                      if (state is StoreInsideReportloadingState)
                        AppUtil.appLoader(),
                    ],
                  );
                }),
          ),
        );
      },
    );
  }
}
