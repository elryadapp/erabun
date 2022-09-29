import 'package:arboon/blocs/appointments_cubit/appointments_cubit.dart';
import 'package:arboon/blocs/examination_cubit/examination_cubit.dart';
import 'package:arboon/blocs/layout_cubit/layout_cubit.dart';
import 'package:arboon/blocs/reports_cubit/reports_cubit.dart';
import 'package:arboon/config/routes/earbun_navigator_keys.dart';
import 'package:arboon/core/components/app_app_bar.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/network/local/cache_helper.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:arboon/data/models/remote_data_models/appointment_models/all_appointment_model.dart';
import 'package:arboon/modules/layout_screens/examination_screens/components/examination_header.dart';
import 'package:arboon/modules/layout_screens/examination_screens/components/examination_toggle_widget.dart';
import 'package:arboon/modules/layout_screens/examination_screens/components/main_card.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ExaminationScreen extends StatefulWidget {
  final AppointmentDataModel carObg;
  const ExaminationScreen({Key? key, required this.carObg}) : super(key: key);

  @override
  State<ExaminationScreen> createState() => _ExaminationScreenState();
}

class _ExaminationScreenState extends State<ExaminationScreen> {
  @override
  void initState() {
  
    var cubit = ExaminationCubit.get(context);
 cubit.currentPageIndex=   LayoutCubit.get(context).currentPageIndex;
AppointmentsCubit.get(context).scrollController=null;
                    ReportsCubit.get(context).scrollController=null;

    cubit.reportFile = null;
    cubit.reportImage = null;
    cubit.getExaminationData(widget.carObg.carExaminationId);
    // cubit.examinationStatus = [
    //   CacheHelper.getData(
    //       key: 'isInternalExamined${widget.carObg.carExaminationId}'),
    //   CacheHelper.getData(
    //       key: 'isExternalExamined${widget.carObg.carExaminationId}'),
    //   CacheHelper.getData(
    //       key: 'isMechanicalExamined${widget.carObg.carExaminationId}'),
    // ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExaminationCubit, ExaminationState>(
      builder: (context, state) {
        var cubit = ExaminationCubit.get(context);

        return WillPopScope(
          onWillPop: () {
            if (cubit.isExaminationShowed!) {
              cubit.changeIsExaminationShowed(false);
            }
            return Future(() => false);
          },
          child: Scaffold(
            appBar: EarbunAppbar(
              context,
              titleText: "اجراء الفحص",
            ),
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                if (!cubit.isExaminationShowed!)
                  const SliverToBoxAdapter(
                    child: ExaminationToggleWidget(),
                  ),
                if (cubit.currentIndex == 0 &&
                    cubit.reportModel?.data?.data?.pdfReport == null)
                  SliverToBoxAdapter(
                    child: BuildCondition(
                        condition: state is GetExaminationDataloadingState,
                        builder: (context) => AppUtil.appLoader(top: 30.h),
                        fallback: (context) {
                          return ExaminationHeader(
                              appointmentDataModel: widget.carObg,
                              child: Column(
                                children: [
                                  cubit.reportImage != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.file(cubit.reportImage!))
                                      : Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 1.h),
                                          width: 50.w,
                                          height: 15.h,
                                          child: MainCard(
                                            isChecked: false,
                                            e: cubit.examinationData[0],
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              gradient: LinearGradient(
                                                  colors: [
                                                    AppUi.colors.splashColor,
                                                    AppUi.colors.secondryColor
                                                  ],
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter)),
                                        )
                                ],
                              ));
                        }),
                  ),
                if (cubit.reportModel?.data?.data?.pdfReport != null &&
                    cubit.reportModel?.data?.data?.reportFlag == 0)
                  SliverToBoxAdapter(
                    child: ExaminationHeader(
                      appointmentDataModel: widget.carObg,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: AppUtil.appCachedImage(
                              width: Constants.getwidth(context),
                              height: Constants.getHeight(context) * .8,
                              imgUrl: AppUi.assets.networkUrlImgBase +
                                  cubit.reportModel!.data!.data!.pdfReport!)),
                    ),
                  ),
                if (cubit.currentIndex == 1 ||
                    cubit.reportModel?.data?.data?.reportFlag == 1)
                  SliverToBoxAdapter(
                    child: ExaminationHeader(
                        onCheckedTap: () {},
                        appointmentDataModel: widget.carObg,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                if (cubit.reportModel?.data?.data?.pdfReport !=
                                        null &&
                                    cubit.reportModel?.data?.data?.reportFlag ==
                                        1) {
                                  cubit.launchPdf();
                                }
                              },
                              child: Image.asset(
                                AppUi.assets.pdfIcon,
                                height: 12.h,
                              ),
                            ),
                            if (cubit.reportFile != null)
                              SizedBox(
                                height: 3.h,
                              ),
                            SizedBox(
                              height: 3.h,
                            ),
                            if (cubit.isExaminationShowed!)
                              const AppText('عرض التقرير'),
                            if (cubit.reportFile != null)
                              AppText(cubit.reportFile!.path.split('/').last)
                          ],
                        )),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
