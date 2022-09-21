import 'package:arboon/core/components/app_button.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/icon_broken.dart';
import 'package:arboon/data/models/remote_data_models/appointment_models/all_appointment_model.dart';
import 'package:arboon/modules/layout_screens/components/main_header.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class AppointmentCard extends StatelessWidget {
  final bool isConfirmed;
  final AppointmentDataModel appointmentDataModel;
  final Function? firstOnTap;
  final Function? lastOnTap;
  const AppointmentCard(
      {Key? key,
      required this.appointmentDataModel,
      required this.isConfirmed,
      this.firstOnTap,
       this.lastOnTap})
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
            title:firstOnTap==null?'ملغية'
:             isConfirmed ? 'مؤكدة' : 'بانتظار التاكيد',
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.all(1.5.h),
            child: Row(
              children: [
                Image.asset(AppUi.assets.carIcon,
                    color: AppUi.colors.subTitleColor.withOpacity(.5)),
                SizedBox(
                  width: 2.w,
                ),
                Expanded(
                  child: AppText(
                    appointmentDataModel.carName!,
                    fontSize: 2.h,
                    textOverflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Icon(
                  IconBroken.Calendar,
                  color: AppUi.colors.subTitleColor.withOpacity(.5),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: AppText(
                      DateFormat.MEd('ar').format(DateTime.parse(
                          appointmentDataModel.examinationDate!)),
                      fontSize: 2.h,
                      color: AppUi.colors.subTitleColor,
                      fontWeight: FontWeight.w600),
                ),
                AppText(appointmentDataModel.examinationTime!,
                    fontSize: 2.h, fontWeight: FontWeight.w600)
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
                  fontSize: 2.h,
                  fontWeight: FontWeight.w600,
                  color: AppUi.colors.hintColor.withOpacity(.8),
                ),
                AppText(
                  appointmentDataModel.sellerName!,
                  fontWeight: FontWeight.w600,
                  fontSize: 1.8.h,
                  color: AppUi.colors.hintColor.withOpacity(.8),
                ),
                const Spacer(),
                if (appointmentDataModel.sellerAttendenceDate != null)
                  Icon(
                    IconBroken.Calendar,
                    color: AppUi.colors.subTitleColor.withOpacity(.5),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: AppText(
                      appointmentDataModel.sellerAttendenceDate == null
                          ? ''
                          : DateFormat.MEd('ar').format(DateTime.parse(
                              appointmentDataModel.sellerAttendenceDate!)),
                      fontSize: 2.h,
                      color: AppUi.colors.subTitleColor,
                      fontWeight: FontWeight.w600),
                ),
                AppText(appointmentDataModel.sellerAttendenceTime ?? '',
                 fontSize: 2.h,
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
                  'المشترى : ',
                  fontSize: 2.h,
                  fontWeight: FontWeight.w600,
                  color: AppUi.colors.hintColor.withOpacity(.8),
                ),
                AppText(
                  appointmentDataModel.buyerName!,
                  fontSize: 1.8.h,
                  fontWeight: FontWeight.w600,
                  color: AppUi.colors.hintColor.withOpacity(.8),
                ),
                const Spacer(),
                if (appointmentDataModel.buyerAttendenceDate != null)
                  Icon(
                    IconBroken.Calendar,
                    color: AppUi.colors.subTitleColor.withOpacity(.5),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: AppText(
                      appointmentDataModel.buyerAttendenceDate == null
                          ? ''
                          : DateFormat.MEd('ar').format(DateTime.parse(
                              appointmentDataModel.buyerAttendenceDate)),
                      fontSize:2.h,
                      color: AppUi.colors.subTitleColor,
                      fontWeight: FontWeight.w600),
                ),
                AppText(appointmentDataModel.buyerAttendenceTime ?? '',
                 fontSize: 2.h,
                    fontWeight: FontWeight.w600)
              ],
            ),
          ),
          if(firstOnTap!=null)
          isConfirmed
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 3.w),
                  child: MainHeader(
                    firstTitle: 'إجراء الفحص',
                    lastTitle: 'الغاء اجراء الفحص',
                    firstOnTap: firstOnTap??(){},
                    lastOnTap: lastOnTap??(){},
                    isAppointment: false,
                    index: 0,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 3.w),
                  child: MainHeader(
                    firstTitle: 'تأكيد الحضور',
                    lastTitle:appointmentDataModel.buyerAttend==null&&appointmentDataModel.sellerAttend==null? 'الغاء الموعد':'تاكيد عدم الحضور',
                    firstOnTap: firstOnTap??(){},
                    lastOnTap: lastOnTap??(){},
                    isAppointment: false,
                    index: 0,
                  ),
                ),
                 if(firstOnTap==null)
                 SizedBox(height: 2.h,)
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
