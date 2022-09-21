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

class CancelExamination extends StatelessWidget {

  const CancelExamination({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EarbunAppbar(
        context,
        titleText: 'الغاء اجراء الفحص',
      ),
      body: BlocBuilder<AppointmentsCubit, AppointmentsState>(

        builder: (context, state) {
          var cubit=AppointmentsCubit.get(context);
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 3.h),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(2.5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 2.w),
                      child: const AppText('ماهو سبب الغاء الفحص ؟'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: AppTextFormFeild(
                        controller: cubit.examinationCancelResoneController,
                        borderColor: AppUi.colors.subTitleColor.withOpacity(.5),
                        hint: 'هنا يتم كتابة سبب الالغاء',
                        textInputType: TextInputType.emailAddress,
                        maxLines: 6,
                        validation: true,
                      ),
                    ),
                    BuildCondition(
                      condition: state is CancelExaminationLoadingState,
                      builder: (context)=>AppUtil.appLoader(height: 10.h),
                      fallback: (context) {
                        return EarbunButton(
                          title: 'تأكيد عملية الالغاء',
                          onTap: () {
                          cubit.cancelExamination(cubit.currenAppointment!.carExaminationId, context);
                          },
                        );
                      }
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
