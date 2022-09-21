import 'package:arboon/blocs/profile_cubit/profile_cubit.dart';
import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/components/app_text_form_field.dart';
import 'package:arboon/core/components/erboon_searchable_field.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:arboon/core/utils/icon_broken.dart';
import 'package:arboon/data/models/app_components_models/app_button_model.dart';
import 'package:arboon/modules/layout_screens/home_screens/components/row_button.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class ProfileEditData extends StatelessWidget {
  const ProfileEditData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 1.5.h, top: 5.h),
                  child: const AppText(
                    'اسم مركز الفحص',
                  ),
                ),
                AppTextFormFeild(
                  hint: 'اسم مركز الفحص',
                  textInputType: TextInputType.emailAddress,
                  controller: cubit.centerNameController,
                  prefixIcon: Icon(
                    IconBroken.Work,
                    size: 6.w,
                    color: AppUi.colors.subTitleColor.withOpacity(.5),
                  ),
                  validation: true,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: const AppText(
                    'صورة مركز الفحص',
                  ),
                ),
                InkWell(
                  onTap: () {
                    AppUtil.appDialoge(
                        context: context,
                        title: 'اختر الصورة',
                        content: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.h, horizontal: 3.w),
                          child: RowButton(appButtonModel: [
                            AppButtonModel(
                                title: 'فتح الكاميرا',
                                icon: IconBroken.Camera,
                                onTap: () {
                                  cubit
                                      .updateCenterImage(ImageSource.camera)
                                      .then((value) =>
                                          cubit.centerImageController.text =
                                              cubit.centerImage!.path
                                                  .split('/')
                                                  .last);

                                  Navigator.pop(context);
                                }),
                            AppButtonModel(
                                title: 'اختيار من المعرض',
                                icon: IconBroken.Image,
                                onTap: () {
                                  cubit.updateCenterImage(ImageSource.gallery);
                                  cubit.centerImageController.text =
                                      cubit.centerImage?.path.split('/').last??'';

                                  Navigator.pop(context);
                                })
                          ]),
                        ));
                  },
                  child: AppTextFormFeild(
                    hint: 'صورة مركز الفحص',
                    textInputType: TextInputType.text,
                    controller: cubit.centerImageController,
                    isEnable: false,
                    prefixIcon: Icon(
                      IconBroken.Camera,
                      size: 6.w,
                      color: AppUi.colors.subTitleColor.withOpacity(.5),
                    ),
                    validation: true,
                  ),
                ),
                if (cubit.profileDataModel!.image == null)
                  SizedBox(
                    height: 1.h,
                  ),
                if (cubit.profileDataModel!.image != null)
                  InkWell(
                    onTap: () {
                      cubit.changeIsShowed(true);
                    },
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Image,
                          color: AppUi.colors.mainColor,
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        const AppText(
                          'الصورة',
                          height: 2,
                        )
                      ],
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: const AppText(
                    'اسم صاحب المركز',
                  ),
                ),
                AppTextFormFeild(
                  hint: 'اسم صاحب المركز',
                  textInputType: TextInputType.emailAddress,
                  controller: cubit.centerOwnerNameController,
                  prefixIcon: Icon(
                    IconBroken.User,
                    size: 6.w,
                    color: AppUi.colors.subTitleColor.withOpacity(.5),
                  ),
                  validation: true,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: const AppText(
                    'البريد الالكترونى',
                  ),
                ),
                AppTextFormFeild(
                  hint: 'البريد الالكترونى',
                  textInputType: TextInputType.emailAddress,
                  controller: cubit.emailController,
                  prefixIcon: Icon(
                    IconBroken.Message,
                    size: 6.w,
                    color: AppUi.colors.subTitleColor.withOpacity(.5),
                  ),
                  validation: true,
                ),
              
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: const AppText(
                    'الموقع',
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Position position =
                        await AppUtil.getCurrentLocation(context);
                    cubit.latLng =
                        LatLng(position.latitude, position.longitude);
                    Navigator.pushNamed(context, Routes.location);
                  },
                  child: AppTextFormFeild(
                    hint: 'الموقع',
                    textInputType: TextInputType.text,
                    controller: cubit.locationController,
                    isEnable: false,
                    prefixIcon: Icon(
                      IconBroken.Location,
                      size: 6.w,
                      color: AppUi.colors.subTitleColor.withOpacity(.5),
                    ),
                    validation: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: const AppText(
                    'المدينة',
                  ),
                ),
                ErboonSearchableField(
                  hint: 'المدينة',
                  suggestions: cubit.cities,
                  controller: cubit.cityController,
                  prefixIcon: Icon(
                    IconBroken.Location,
                    size: 6.w,
                    color: AppUi.colors.subTitleColor.withOpacity(.5),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: const AppText(
                    'الحى',
                  ),
                ),
                AppTextFormFeild(
                  hint: 'الحى',
                  textInputType: TextInputType.emailAddress,
                  controller: cubit.stateController,
                  prefixIcon: Icon(
                    IconBroken.Location,
                    size: 6.w,
                    color: AppUi.colors.subTitleColor.withOpacity(.5),
                  ),
                  validation: true,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: const AppText(
                    'الشارع',
                  ),
                ),
                AppTextFormFeild(
                  hint: 'الشارع',
                  textInputType: TextInputType.emailAddress,
                  controller: cubit.streetController,
                  prefixIcon: Icon(
                    IconBroken.Location,
                    size: 6.w,
                    color: AppUi.colors.subTitleColor.withOpacity(.5),
                  ),
                  validation: true,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: const AppText(
                    'السجل التجارى',
                  ),
                ),
                AppTextFormFeild(
                  hint: 'السجل التجارى',
                  textInputType: TextInputType.emailAddress,
                  controller: cubit.comercialReportController,
                  prefixIcon: Icon(
                    IconBroken.Folder,
                    size: 6.w,
                    color: AppUi.colors.subTitleColor.withOpacity(.5),
                  ),
                  validation: true,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: const AppText(
                    'الرقم السرى',
                  ),
                ),
                AppTextFormFeild(
                  hint: 'الرقم السرى',
                  controller: cubit.passwordController,
                  prefixIcon: Icon(
                    IconBroken.Lock,
                    size: 6.w,
                    color: AppUi.colors.subTitleColor.withOpacity(.5),
                  ),
                  validation: true,
                  suffixIcon: InkWell(
                    onTap: () {
                      cubit.changeVisibility();
                    },
                    child: Icon(cubit.visibilityIcon),
                  ),
                  obscureText: cubit.isPasswordVisible,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: const AppText(
                    'تأكيد الرقم السرى',
                  ),
                ),
                AppTextFormFeild(
                  hint: 'تأكيد الرقم السرى',
                  controller: cubit.confirmPasswordController,
                  prefixIcon: Icon(
                    IconBroken.Lock,
                    size: 6.w,
                    color: AppUi.colors.subTitleColor.withOpacity(.5),
                  ),
                  validation: true,
                  suffixIcon: InkWell(
                    onTap: () {
                      cubit.changeConfirmationVisibility();
                    },
                    child: Icon(cubit.visibilityConfirmationIcon),
                  ),
                  obscureText: cubit.isPasswordConfirmationVisible,
                ),
              ],
            ),
            if (cubit.isShowed!)
              Container(
                alignment: AlignmentDirectional.topStart,
                margin: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(8),
                    image: cubit.centerImage!=null? 
                    DecorationImage(
                      image:
                     FileImage(
                       cubit.centerImage!,
                      ),
                      fit: BoxFit.cover,
                    )
                    :
                    cubit.profileDataModel!.image!=null?
                    DecorationImage(
                      image:
                     NetworkImage(
                        AppUi.assets.networkUrlImgBase+cubit.profileDataModel!.image!,
                      ),
                      fit: BoxFit.cover,
                    )
                    :
                    DecorationImage(
                      image:
                     AssetImage(
                        AppUi.assets.launcher,
                      ),
                      fit: BoxFit.cover,
                    )),
                width: Constants.getwidth(context),
                height: Constants.getHeight(context) * .7,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 15),
                  child: IconButton(
                      onPressed: () {
                        cubit.changeIsShowed(false);
                      },
                      icon: Icon(
                        IconBroken.Close_Square,
                        color: AppUi.colors.whiteColor,
                        size: 6.h,
                      )),
                ),
              )
          ],
        );
      },
    );
  }
}
