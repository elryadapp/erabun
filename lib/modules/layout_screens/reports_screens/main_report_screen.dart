import 'package:arboon/blocs/reports_cubit/reports_cubit.dart';
import 'package:arboon/core/components/animated_commponent.dart';
import 'package:arboon/core/components/app_app_bar.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/modules/layout_screens/reports_screens/components/report_card.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class MainReportScreen extends StatelessWidget {
  const MainReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsCubit, ReportsState>(
      builder: (context, state) {
        var cubit = ReportsCubit.get(context);
        return Scaffold(
            appBar: EarbunAppbar(context,
                titleText: 'التقارير', leading: Container()),
            body: BuildCondition(
                condition: state is GetAllReportsLoadingState,
                builder: (context) => AppUtil.appLoader(top: 30.h),
                fallback: (context) {
                  return Stack(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: BuildCondition(
                              condition: cubit.reportsList.isEmpty,
                              builder: (context) => Column(
                                    children: [
                                      AppUtil.emptyLottie(),
                                      const AppText(
                                          'لا يوجد لديك تقارير ')
                                    ],
                                  ),
                              fallback: (context) {
                                return ErboonSlideAnimation(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 3.h),
                                    child: ListView.separated(
                                          controller: cubit.scrollController,

                                        physics:
                                            const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return ReportCard(
                                              isCompleted: cubit
                                                      .reportsList[index]
                                                      .status ==
                                                  'finished',
                                              reportsDataModel: cubit
                                                  .reportsList[index]);
                                        },
                                        separatorBuilder:
                                            (context, index) => SizedBox(
                                                  height: 2.h,
                                                ),
                                        itemCount:
                                            cubit.reportsList.length),
                                  ),
                                );
                              })),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: ReportsCubit.get(context)
                                    .allReportsModel!
                                    .data!
                                    .isEmpty
                                ? AppUi.colors.failureRed.withOpacity(.9)
                                : Colors.transparent,
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 5.w,vertical: 6.h),
                          height: state is GetPaginatedReportsLoadingState
                              ? ReportsCubit.get(context)
                                      .allReportsModel!
                                      .data!
                                      .isEmpty
                                  ? 6.h
                                  : 12.h
                              : 0,
                          width: double.infinity,
                          child: Center(
                            child: ReportsCubit.get(context)
                                    .allReportsModel!
                                    .data!
                                    .isEmpty
                                ? AppText(
                                    'لا يوجد المزيد من التقارير',
                                    fontSize: 1.8.h,
                                    color: AppUi.colors.whiteColor,
                                  )
                                : AppUtil.appLoader(height: 10.h),
                          ),
                        ),
                      )
                    ],
                  );
                }));
      },
    );
  }
}
