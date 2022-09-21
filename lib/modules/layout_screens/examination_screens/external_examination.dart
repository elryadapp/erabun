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

class ExternalExamination extends StatefulWidget {
  final dynamic carObg;
  const ExternalExamination({Key? key,required this.carObg}) : super(key: key);

  @override
  State<ExternalExamination> createState() => _ExternalExaminationState();
}

class _ExternalExaminationState extends State<ExternalExamination> {
  @override
  void initState() {
    var cubit = ExaminationCubit.get(context);

    if (cubit.examinationStatus[1]=='true'||cubit.isExaminationShowed!) {
      cubit.getOutsideReport(context,
    
             widget.carObg.carExaminationId);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExaminationCubit, ExaminationState>(
      builder: (context, state) {
        var cubit = ExaminationCubit.get(context);
        return Scaffold(
          appBar: EarbunAppbar(context,actions: const [] ,titleText: 'خارج السيارة'),
          body: ExaminationHeader(
             appointmentDataModel: widget.carObg,
            onCheckedTap: () {
              if(cubit.examinationStatus[1]!='true'){
              cubit.storeOutsideReport(context,
                 carExaminationId: widget.carObg.carExaminationId);}
            else{
                AppUtil.appAlert(context,contentType: ContentType.warning,msg: ' هذه البيانات تم تسجلها بالفعل '  );
              }
            },
            child: BuildCondition(
              condition: state is GetOutsideReportloadingState,
              builder: (context)=>AppUtil.appLoader(),
              fallback: (context) {
                return Column(
                  children: [
                    Column(
                      children: [
                        Image.asset(AppUi.assets.external),
                        SizedBox(
                          height: 2.h,
                        ),
                        const AppText(
                          'خارج السيارة',
                          fontWeight: FontWeight.w600,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    ...cubit.externalExaminationList
                        .asMap()
                        .entries
                        .map((e) => Column(
                              children: [
                                Row(
                                  children: [
                                   cubit.examinationStatus[1]=='true'||!cubit.isExaminationShowed!? Theme(
                                      data: ThemeData(
                                        unselectedWidgetColor:
                                            AppUi.colors.mainColor,
                                      ),
                                      child: Checkbox(
                                        activeColor: AppUi.colors.mainColor,
                                        value: cubit.outsideReportImageList[e.key]
                                            .isNotEmpty,
                                        onChanged: (value) {},
                                      ),
                                    ):SizedBox(width: 2.7.w,height: 6.h,),
                                    AppText(e.value),
                                  ],
                                ),
                                ReportImagesView(
                                  isEditied: cubit.examinationStatus[1]!='true'&&
                                            !cubit.isExaminationShowed!,
                                  insideReportConroller:
                                      cubit.outsideReportConrollers[e.key],
                                  onTap: () {
                                    cubit.chooseOutsideReportImages(e.key);
                                  },
                                  currentList:cubit.examinationStatus[1]=='true'||cubit.isExaminationShowed!? cubit.restoredOutsideReportImageList[e.key]:cubit.outsideReportImageList[e.key],
                                )
                              ],
                            )),
                    SizedBox(
                      height: 2.h,
                    ),
                    
                    if(state is StoreOutsideReportloadingState)
                    AppUtil.appLoader()
                  ],
                );
              }
            ),
          ),
        );
      },
    );
  }
}
