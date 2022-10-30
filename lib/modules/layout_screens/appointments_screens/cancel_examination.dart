import 'package:arboon/blocs/appointments_cubit/appointments_cubit.dart';
import 'package:arboon/core/components/app_app_bar.dart';
import 'package:arboon/core/components/app_button.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/components/app_text_form_field.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CancelAppointment extends StatelessWidget {
  const CancelAppointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentsCubit, AppointmentsState>(
      builder: (context, state) {
        var cubit = AppointmentsCubit.get(context);
        return Scaffold(
          appBar: EarbunAppbar(
            context,
            titleText: 'الغاء موعد',
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 3.h),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Padding(
                      //   padding: EdgeInsetsDirectional.only(start: 3.w),
                      //   child: const AppText('من يريد الغاء موعد اجراء الفحص'),
                      // ),
                      // ...cubit.cancelReasone.map((e) => Row(
                      //       children: [
                      //         Theme(
                      //           data: ThemeData(
                      //               unselectedWidgetColor:
                      //                   AppUi.colors.mainColor),
                      //           child: Radio(
                      //             activeColor: AppUi.colors.mainColor,
                      //               value: e,
                      //               groupValue: cubit.selectedCancelReson,
                      //               onChanged: (val) {
                      //                 cubit.changeCancelationReson(val);
                      //               }),
                      //         ),
                            
                      //         AppText(e)
                      //       ],
                      //     )),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 2.w,top: 1.5.h),
                        child: const AppText('سبب الالغاء'),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: AppTextFormFeild(
                          controller: cubit.appointmentCancelResoneController,
                          borderColor: AppUi.colors.subTitleColor.withOpacity(.5),
                          hint: 'هنا يتم كتابة سبب الالغاء',
                          textInputType: TextInputType.emailAddress,
                          maxLines: 6,
                          validation: true,
                        ),
                      ),
                      BuildCondition(
                        condition: state is CancelAppointmentLoadingState,
                        builder: (context)=>AppUtil.appLoader(height: 10.h),
                        fallback: (context) {
                          return EarbunButton(
                            title: 'تأكيد عملية الالغاء',
                            onTap: () {
                             cubit.cancelAppointment(cubit.currenAppointment!, context);
                            },
                          );
                        }
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
