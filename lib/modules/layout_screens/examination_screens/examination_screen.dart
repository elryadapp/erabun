import 'package:arboon/blocs/examination_cubit/examination_cubit.dart';
import 'package:arboon/config/routes/earbun_navigator_keys.dart';
import 'package:arboon/core/components/app_app_bar.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/network/local/cache_helper.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
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
    cubit.getExaminationData(widget.carObg.carExaminationId);
    cubit.examinationStatus = [
      CacheHelper.getData(
          key: 'isInternalExamined${widget.carObg.carExaminationId}'),
      CacheHelper.getData(
          key: 'isExternalExamined${widget.carObg.carExaminationId}'),
      CacheHelper.getData(
          key: 'isMechanicalExamined${widget.carObg.carExaminationId}'),
    ];

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
                              isBranched: true,
                              child: Column(
                                children: [
                                  ...cubit.examinationData
                                      .asMap()
                                      .entries
                                      .map((e) => InkWell(
                                            onTap: () {
                                              EarbunNavigatorKeys
                                                  .mainAppNavigatorKey
                                                  .currentState!
                                                  .pushNamed(e.value.route,
                                                      arguments: widget.carObg);
                                            },
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 1.h),
                                              width: 50.w,
                                              height: 15.h,
                                              child: MainCard(
                                                isChecked:
                                                    cubit.examinationStatus[
                                                            e.key] ==
                                                        'true',
                                                e: e.value,
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        AppUi
                                                            .colors.splashColor,
                                                        AppUi.colors
                                                            .secondryColor
                                                      ],
                                                      begin: Alignment
                                                          .bottomCenter,
                                                      end:
                                                          Alignment.topCenter)),
                                            ),
                                          )),
                                ],
                              ));
                        }),
                  )
                else
                  SliverToBoxAdapter(
                    child: ExaminationHeader(
                            onCheckedTap: () {},
                            appointmentDataModel: widget.carObg,
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    cubit.launchPdf();
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
                                  AppText(
                                      cubit.reportFile!.path.split('/').last)
                              ],
                            )),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
