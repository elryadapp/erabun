import 'package:arboon/blocs/examination_cubit/examination_cubit.dart';
import 'package:arboon/blocs/reports_cubit/reports_cubit.dart';
import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/config/routes/earbun_navigator_keys.dart';
import 'package:arboon/core/components/app_button.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/icon_broken.dart';
import 'package:arboon/data/models/remote_data_models/appointment_models/all_appointment_model.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ReportCard extends StatelessWidget {
  final AppointmentDataModel reportsDataModel;
  final bool isCompleted;
  const ReportCard(
      {Key? key, required this.isCompleted, required this.reportsDataModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EarbunButton(
            height: 4.h,
            width: 30.w,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(15),
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(0)),
            fontSize: 1.3.h,
            title: isCompleted ? 'المرسلة' : 'الغير مكتملة',
          ),
          Padding(
            padding: EdgeInsets.all(1.5.h),
            child: Row(
              children: [
                Image.asset(AppUi.assets.carIcon,
                    color: AppUi.colors.subTitleColor.withOpacity(.5)),
                SizedBox(
                  width: 2.w,
                ),
                AppText(
                  reportsDataModel.carName!,
                  fontWeight: FontWeight.w600,
                ),
                const Spacer(),
                Icon(
                  IconBroken.Calendar,
                  color: AppUi.colors.subTitleColor.withOpacity(.5),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: AppText(
                      DateFormat.MEd('ar').format(
                          DateTime.parse(reportsDataModel.examinationDate!)),
                      color: AppUi.colors.subTitleColor,
                      fontWeight: FontWeight.w600),
                ),
                AppText(reportsDataModel.examinationTime!,
                    fontWeight: FontWeight.w600)
              ],
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          Padding(
            padding: EdgeInsets.all(1.h),
            child: Row(
              children: [
                Icon(IconBroken.User,
                    color: AppUi.colors.subTitleColor.withOpacity(.5)),
                SizedBox(
                  width: 2.w,
                ),
                AppText(
                  'المعلن : ',
                  fontWeight: FontWeight.w600,
                  color: AppUi.colors.hintColor.withOpacity(.8),
                ),
                AppText(
                  reportsDataModel.sellerName!,
                  fontWeight: FontWeight.w600,
                  color: AppUi.colors.hintColor.withOpacity(.8),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          Padding(
            padding: EdgeInsets.all(1.h),
            child: Row(
              children: [
                Icon(IconBroken.User,
                    color: AppUi.colors.subTitleColor.withOpacity(.5)),
                SizedBox(
                  width: 2.w,
                ),
                AppText(
                  'المشترى : ',
                  fontWeight: FontWeight.w600,
                  color: AppUi.colors.hintColor.withOpacity(.8),
                ),
                AppText(
                  reportsDataModel.buyerName!,
                  fontWeight: FontWeight.w600,
                  color: AppUi.colors.hintColor.withOpacity(.8),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
            child: EarbunButton(
              height: 5.h,
              fontSize: 2.h,
              title: isCompleted ? 'عرض' : 'إكمال',
              onTap: () {
                ReportsCubit.get(context).currentReport = reportsDataModel;

                if (!isCompleted) {
                  if(reportsDataModel.carImage==0){
                       EarbunNavigatorKeys.rebortsNavigatorKey.currentState!
                      .pushNamed(Routes.carBody);
                  }
                  else{
                     EarbunNavigatorKeys.rebortsNavigatorKey.currentState!
                      .pushNamed(Routes.examinationScreen);
                  }
               
                } else {
                  ExaminationCubit.get(context).changeIsExaminationShowed(true);
                  EarbunNavigatorKeys.rebortsNavigatorKey.currentState!
                      .pushNamed(Routes.examinationScreen);
                }
              },
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: AppUi.colors.whiteColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                blurRadius: 4,
                color: AppUi.colors.subTitleColor.withOpacity(.2))
          ]),
    );
  }
}
