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

class ElectricScreen extends StatefulWidget {
  final dynamic carObg;
  const ElectricScreen({Key? key,required this.carObg}) : super(key: key);

  @override
  State<ElectricScreen> createState() => _ElectricScreenState();
}

class _ElectricScreenState extends State<ElectricScreen> {
  @override
  void initState() {
    var cubit = ExaminationCubit.get(context);

    if (cubit.examinationStatus[2] == 'true'||cubit.isExaminationShowed!) {
      cubit.getMechanicalReport(widget.carObg?.carExaminationId );
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
              actions: const [], titleText: "ميكانيكا الكهرباء"),
          body: ExaminationHeader(
            appointmentDataModel:
                widget.carObg ,
            onCheckedTap: () {
              if (cubit.examinationStatus[2] != 'true') {
                cubit.storeMechanicalReport(context,
                    carExaminationId:widget.carObg?.carExaminationId  );
              } else {
                AppUtil.appAlert(context,
                    contentType: ContentType.warning,
                    msg: ' هذه البيانات تم تسجلها بالفعل ');
              }
            },
            child: BuildCondition(
                condition: state is GetMechanicalReportloadingState,
                builder: (context) => AppUtil.appLoader(),
                fallback: (context) {
                  return Column(
                    children: [
                      Column(
                        children: [
                          Image.asset(AppUi.assets.electirc),
                          SizedBox(
                            height: 2.h,
                          ),
                          const AppText(
                            "ميكانيكا الكهرباء",
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      ...cubit.mechanicalExaminationList
                          .asMap()
                          .entries
                          .map((e) => Column(
                                children: [
                                  Row(
                                    children: [
                                     cubit.examinationStatus[2] == 'true'||!cubit.isExaminationShowed!? Theme(
                                        data: ThemeData(
                                          unselectedWidgetColor:
                                              AppUi.colors.mainColor,
                                        ),
                                        child: Checkbox(
                                          activeColor: AppUi.colors.mainColor,
                                          value: cubit
                                              .mechanicalReportImageList[e.key]
                                              .isNotEmpty,
                                          onChanged: (value) {},
                                        ),
                                      ):SizedBox(width: 2.7.w,height: 6.h,),
                                      AppText(e.value),
                                    ],
                                  ),
                                  ReportImagesView(
                                    isEditied:  cubit.examinationStatus[2] !=
                                            'true'&&!cubit.isExaminationShowed!,
                                    insideReportConroller:
                                        cubit.mechanicalReportConrollers[e.key],
                                    onTap: () {
                                      cubit.chooseMechanicalReportImages(e.key);
                                    },
                                    currentList: cubit.examinationStatus[2] ==
                                            'true'||cubit.isExaminationShowed!
                                        ? cubit.restoredMechaicalReportImageList[
                                            e.key]
                                        : cubit
                                            .mechanicalReportImageList[e.key],
                                  )
                                ],
                              )),
                      SizedBox(
                        height: 2.h,
                      ),
                    
                      if (state is StoreMechanicalReportloadingState)
                        AppUtil.appLoader()
                    ],
                  );
                }),
          ),
        );
      },
    );
  }
}
