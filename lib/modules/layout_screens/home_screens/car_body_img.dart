import 'package:arboon/blocs/layout_cubit/layout_cubit.dart';
import 'package:arboon/core/components/app_app_bar.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/components/app_text_form_field.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:arboon/core/utils/icon_broken.dart';
import 'package:arboon/data/models/app_components_models/app_button_model.dart';
import 'package:arboon/data/models/remote_data_models/appointment_models/all_appointment_model.dart';
import 'package:arboon/modules/layout_screens/home_screens/components/row_button.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class CarBodyImage extends StatelessWidget {
  final AppointmentDataModel dataModel;
  const CarBodyImage({
    Key? key,required this.dataModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return Scaffold(
          appBar:  EarbunAppbar(
                    context,
                 
                    titleText: "اضافة رقم الهيكل",
                  ),
          body:  Column(
                  children: [
                   
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.all(2.h),
                          child: Container(
                            width: Constants.getwidth(context),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppUi.colors.whiteColor,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 2,
                                      color: AppUi.colors.subTitleColor
                                          .withOpacity(.3))
                                ]),
                            child: Padding(
                              padding: EdgeInsets.all(3.h),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  cubit.carImage == null
                                      ? Image.asset(
                                          AppUi.assets.carIcon,
                                          height: 6.h,
                                          fit: BoxFit.cover,
                                        )
                                      : ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.file(
                                            cubit.carImage!,
                                            height: 30.h,
                                            width: Constants.getwidth(context),
                                            fit: BoxFit.cover,
                                          )),
                                  SizedBox(height: 2.h),
                                  if (cubit.carImage == null)
                                    const AppText(
                                        'فضلا إضافة صورة رقم  هيكل السيارة'),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  AppTextFormFeild(
                                    hint: 'ادخل رقم السيارة',
                                    controller: cubit.carNumberController,
                                    textInputType: TextInputType.number,
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4.h),
                                      child: cubit.carImage != null
                                          ? BuildCondition(
                                              builder: (context) =>
                                                  AppUtil.appLoader(height: 10.h),
                                              condition: state
                                                  is UploadCarBodyloadingState,
                                              fallback: (context) {
                                                return RowButton(appButtonModel: [
                                                  AppButtonModel(
                                                      color: AppUi.colors
                                                          .confirmationBtnColor,
                                                      title: 'تأكيد الرقم',
                                                      icon: Icons
                                                          .check_circle_outline_rounded,
                                                      onTap: () {
                                                        cubit.uploadCarBody(
                                                          dataModel.carExaminationId.toString(),
                                                            context);
                                                      }),
                                                  AppButtonModel(
                                                      title: 'تغيير الصورة',
                                                      icon: IconBroken.Image,
                                                      onTap: () {
                                                        AppUtil.appDialoge(
                                                            context: context,
                                                            title: 'اختر الصورة',
                                                            content: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          3.h,
                                                                      horizontal:
                                                                          3.w),
                                                              child: RowButton(
                                                                  appButtonModel: [
                                                                    AppButtonModel(
                                                                        title:
                                                                            'فتح الكاميرا',
                                                                        icon: IconBroken
                                                                            .Camera,
                                                                        onTap:
                                                                            () {
                                                                          cubit.chooseImage(
                                                                              ImageSource.camera);
                                                                          Navigator.pop(
                                                                              context);
                                                                        }),
                                                                    AppButtonModel(
                                                                        title:
                                                                            'اختيار من المعرض',
                                                                        icon: IconBroken
                                                                            .Image,
                                                                        onTap:
                                                                            () {
                                                                          cubit.chooseImage(
                                                                              ImageSource.gallery);
                                                                          Navigator.pop(
                                                                              context);
                                                                        })
                                                                  ]),
                                                            ));
                                                      })
                                                ]);
                                              })
                                          : RowButton(appButtonModel: [
                                              AppButtonModel(
                                                  title: 'فتح الكاميرا',
                                                  icon: IconBroken.Camera,
                                                  onTap: () {
                                                    cubit.chooseImage(
                                                        ImageSource.camera);
                                                  }),
                                              AppButtonModel(
                                                  title: 'اختيار من المعرض',
                                                  icon: IconBroken.Image,
                                                  onTap: () {
                                                    cubit.chooseImage(
                                                        ImageSource.gallery);
                                                  })
                                            ]))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
              
      },
    );
  }
}
