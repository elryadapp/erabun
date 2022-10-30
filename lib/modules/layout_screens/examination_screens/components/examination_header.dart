import 'dart:io';
import 'package:arboon/blocs/examination_cubit/examination_cubit.dart';
import 'package:arboon/blocs/layout_cubit/layout_cubit.dart';
import 'package:arboon/config/routes/earbun_navigator_keys.dart';
import 'package:arboon/core/components/app_button.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:arboon/core/utils/icon_broken.dart';
import 'package:arboon/data/models/app_components_models/app_button_model.dart';
import 'package:arboon/data/models/remote_data_models/appointment_models/all_appointment_model.dart';
import 'package:arboon/modules/layout_screens/examination_screens/components/pdf_view_screen.dart';
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
        return cubit.isPDF == 1
            ? PdfViewScreen(file: cubit.selectedFile!)
            : Form(
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (!cubit.isExaminationShowed! &&
                                      !cubit.isFinished!)
                                    RowButton(appButtonModel: [
                                      AppButtonModel(
                                          title: 'صور التقرير',
                                          icon: IconBroken.Camera,
                                          onTap: () {
                                            AppUtil.appDialoge(
                                                context: context,
                                                title: 'اختر الصورة',
                                                content: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 3.h,
                                                      horizontal: 3.w),
                                                  child: RowButton(
                                                      appButtonModel: [
                                                        AppButtonModel(
                                                            title:
                                                                'فتح الكاميرا',
                                                            icon: IconBroken
                                                                .Camera,
                                                            onTap: () {
                                                              cubit.chooseImage(
                                                                  ImageSource
                                                                      .camera);
                                                              EarbunNavigatorKeys
                                                                  .mainAppNavigatorKey
                                                                  .currentState!
                                                                  .pop();
                                                            }),
                                                        AppButtonModel(
                                                            title:
                                                                'اختيار من المعرض',
                                                            icon: IconBroken
                                                                .Image,
                                                            onTap: () {
                                                              cubit
                                                                  .chooseReportImages();
                                                              EarbunNavigatorKeys
                                                                  .mainAppNavigatorKey
                                                                  .currentState!
                                                                  .pop();
                                                            })
                                                      ]),
                                                ));
                                          }),
                                      AppButtonModel(
                                          title: 'ملفات التقرير',
                                          icon: IconBroken.Document,
                                          onTap: () {
                                            cubit.pickReportFile();
                                          })
                                    ]),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  if (cubit.reportImagesList.isNotEmpty)
                                    ExpansionTile(
                                      title: AppText(
                                        'صور التقرير',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 2.3.h,
                                      ),
                                      children: [
                                        if (cubit.reportImagesList.isNotEmpty)
                                          ...cubit.reportImagesList
                                              .asMap()
                                              .entries
                                              .map(
                                                (e) => InkWell(
                                                  onTap: () {
                                                    AppUtil.appDialoge(
                                                        context: context,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 2.h),
                                                          child: Row(
                                                            children: [
                                                              InkWell(
                                                                  onTap: () {
                                                                    EarbunNavigatorKeys
                                                                        .mainAppNavigatorKey
                                                                        .currentState!
                                                                        .pop();
                                                                  },
                                                                  child: Icon(
                                                                    IconBroken
                                                                        .Close_Square,
                                                                    color: AppUi
                                                                        .colors
                                                                        .mainColor,
                                                                  )),
                                                              const Spacer(),
                                                              if (cubit
                                                                      .reportModel
                                                                      ?.data
                                                                      ?.data
                                                                      ?.otherReport ==
                                                                  null)
                                                                InkWell(
                                                                    onTap: () {
                                                                      cubit
                                                                          .reportImagesList
                                                                          .remove(
                                                                              cubit.reportImagesList[e.key]);
                                                                      EarbunNavigatorKeys
                                                                          .mainAppNavigatorKey
                                                                          .currentState!
                                                                          .pop();
                                                                      cubit
                                                                          .changeState();
                                                                    },
                                                                    child: Icon(
                                                                      IconBroken
                                                                          .Delete,
                                                                      color: AppUi
                                                                          .colors
                                                                          .failureRed,
                                                                    )),
                                                            ],
                                                          ),
                                                        ),
                                                        content: cubit
                                                                    .reportModel
                                                                    ?.data
                                                                    ?.data
                                                                    ?.otherReport ==
                                                                null
                                                            ? Image.file(
                                                                File(e.value
                                                                    .path),
                                                                height: Constants
                                                                        .getHeight(
                                                                            context) *
                                                                    .5,
                                                              )
                                                            : AppUtil.appCachedImage(
                                                                width:
                                                                    Constants.getwidth(context) *
                                                                        .9,
                                                                height: Constants.getHeight(
                                                                        context) *
                                                                    .5,
                                                                imgUrl: AppUi
                                                                        .assets
                                                                        .networkUrlImgBase +
                                                                    cubit.reportImagesList[
                                                                        e.key]));
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.h),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          IconBroken.Image,
                                                          color: AppUi.colors
                                                              .splashColor,
                                                        ),
                                                        SizedBox(
                                                          width: 2.w,
                                                        ),
                                                        Expanded(
                                                            child: AppText(
                                                          cubit
                                                                      .reportModel
                                                                      ?.data
                                                                      ?.data
                                                                      ?.otherReport ==
                                                                  null
                                                              ? e.value.path
                                                                  .split('/')
                                                                  .last
                                                              : e.value
                                                                  .split('/')
                                                                  .last,
                                                          maxLines: 1,
                                                        ))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  if (cubit.reportFilesList.isNotEmpty)
                                    ExpansionTile(
                                      title: AppText(
                                        'ملفات التقرير',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 2.3.h,
                                      ),
                                      children: [
                                        if (cubit.reportFilesList.isNotEmpty)
                                          ...cubit.reportFilesList.map(
                                            (e) => InkWell(
                                              onTap: () {
                                                if (cubit.reportModel?.data
                                                        ?.data?.pdfReport ==
                                                    null) {
                                                  cubit.changePdfViewStatus(
                                                      1, e);
                                                } else {
                                                  cubit.launchPdf(e);
                                                }
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2.h),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      IconBroken.Document,
                                                      color: AppUi
                                                          .colors.splashColor,
                                                    ),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    Expanded(
                                                        child: AppText(
                                                      cubit
                                                                  .reportModel
                                                                  ?.data
                                                                  ?.data
                                                                  ?.pdfReport ==
                                                              null
                                                          ? e.path
                                                              .split('/')
                                                              .last
                                                          : e.split('/').last,
                                                      maxLines: 1,
                                                    ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  if (cubit.reportModel?.data?.data
                                              ?.pdfReport ==
                                          null &&
                                      cubit.reportModel?.data?.data
                                              ?.otherReport ==
                                          null &&
                                      !cubit.isFinished!
                                      && (cubit.reportImagesList.isNotEmpty ||
                                      cubit.reportFilesList.isNotEmpty
                                      )

                                      )
                                    BuildCondition(
                                        condition: state
                                            is UploadPdfReportloadingState,
                                        builder: (context) =>
                                            AppUtil.appLoader(height: 10.h),
                                        fallback: (context) {
                                          return EarbunButton(
                                            color: AppUi.colors.splashColor,
                                            title: 'ارسال تقرير الفحص',
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
                                              );
                                            },
                                          );
                                        }),
                                ],
                              ),
                            ),
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
