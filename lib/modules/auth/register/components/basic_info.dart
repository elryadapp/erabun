import 'package:arboon/blocs/auth_cubit/auth_cubit.dart';
import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/core/components/animated_commponent.dart';
import 'package:arboon/core/components/app_button.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/components/app_text_form_field.dart';
import 'package:arboon/core/components/erboon_searchable_field.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:arboon/core/utils/icon_broken.dart';
import 'package:arboon/data/models/app_components_models/app_button_model.dart';
import 'package:arboon/data/models/app_components_models/content_type.dart';
import 'package:arboon/modules/layout_screens/home_screens/components/row_button.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class BasicInfo extends StatelessWidget {
  const BasicInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        var authCubit = AuthCubit.get(context);

        return Stack(
          children: [
            Form(
                key: authCubit.registerFormKey,
                child: ErboonSlideAnimation(
                    child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 6.h,
                      horizontal: 5.w,
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: AppText(
                                'مرحبا بك ادخل بياناتك لإنشاء حساب',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 1.5.h, top: 5.h),
                              child: const AppText(
                                'اسم مركز الفحص',
                              ),
                            ),
                            AppTextFormFeild(
                              hint: 'اسم مركز الفحص',
                              textInputType: TextInputType.emailAddress,
                              controller:
                                  authCubit.registerCenterNameController,
                              prefixIcon: Icon(
                                IconBroken.Work,
                                size: 6.w,
                                color:
                                    AppUi.colors.subTitleColor.withOpacity(.5),
                              ),
                              validation: true,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 1.5.h),
                              child: const AppText(
                                'صورة مركز الفحص',
                              ),
                            ),
                            AppTextFormFeild(
                              hint: 'صورة مركز الفحص',
                              textInputType: TextInputType.text,
                              controller:
                                  authCubit.registerCenterImageController,
                                  readOnly: true,
                              prefixIcon: Icon(
                                IconBroken.Camera,
                                size: 6.w,
                                color: AppUi.colors.subTitleColor
                                    .withOpacity(.5),
                              ),
                            
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
                                              authCubit
                                                  .chooseCenterImage(
                                                      ImageSource.camera)
                                                  .then((value) => authCubit
                                                          .registerCenterImageController
                                                          .text =
                                                      authCubit
                                                          .centerImage!.path
                                                          .split('/')
                                                          .last);

                                              Navigator.pop(context);
                                            }),
                                        AppButtonModel(
                                            title: 'اختيار من المعرض',
                                            icon: IconBroken.Image,
                                            onTap: () {
                                              authCubit
                                                  .chooseCenterImage(
                                                      ImageSource.gallery)
                                                  .then((value) => authCubit
                                                      .registerCenterImageController
                                                      .text = authCubit
                                                          .centerImage?.path
                                                          .split('/')
                                                          .last ??
                                                      '');

                                              Navigator.pop(context);
                                            })
                                      ]),
                                    ));
                              
                              },
                              validation: true,
                            ),
                            if (authCubit.centerImage != null)
                              SizedBox(
                                height: 1.h,
                              ),
                            if (authCubit.centerImage != null)
                              InkWell(
                                onTap: () {
                                  authCubit.changeIsShowed(true);
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
                              controller:
                                  authCubit.registerCenterOwnerNameController,
                              prefixIcon: Icon(
                                IconBroken.User,
                                size: 6.w,
                                color:
                                    AppUi.colors.subTitleColor.withOpacity(.5),
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
                              controller: authCubit.registerEmailController,
                              prefixIcon: Icon(
                                IconBroken.Message,
                                size: 6.w,
                                color:
                                    AppUi.colors.subTitleColor.withOpacity(.5),
                              ),
                              validation: true,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 1.5.h),
                              child: const AppText(
                                'رقم الجوال',
                              ),
                            ),
                            AppTextFormFeild(
                              hint: 'رقم الجوال',
                              textInputType: TextInputType.phone,
                              controller: authCubit.registerPhoneController,
                              prefixIcon: CountryCodePicker(
                                padding: EdgeInsets.zero,
                                onChanged: (val) {
                                  if (val.code != '') {
                                    authCubit.registerCountryCode =
                                        val.dialCode;
                                  }
                                },
                                dialogSize: Size(
                                    Constants.getwidth(context) * .8,
                                    Constants.getHeight(context) * .7),
                                dialogTextStyle:
                                    TextStyle(color: AppUi.colors.mainColor),
                                searchDecoration: const InputDecoration(
                                  prefixIcon: Icon(IconBroken.Search),
                                  hintText: 'ابحث عن الدولة',
                                ),
                                initialSelection: 'sa',
                                textStyle:
                                    TextStyle(color: AppUi.colors.mainColor),
                                flagDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                showCountryOnly: false,
                                showOnlyCountryWhenClosed: false,
                              ),
                              validation: true,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 1.5.h),
                              child: const AppText(
                                'الموقع',
                              ),
                            ),
                            AppTextFormFeild(
                              hint: 'الموقع',
                                 onTap: () async {
                                Position position =
                                    await AppUtil.getCurrentLocation(context);
                                authCubit.latLng = LatLng(
                                    position.latitude, position.longitude);
                                Navigator.pushNamed(context, Routes.location);
                              },
                              textInputType: TextInputType.text,
                              controller:
                                  authCubit.registerLocationController,
                              readOnly: true,
                              prefixIcon: Icon(
                                IconBroken.Location,
                                size: 6.w,
                                color: AppUi.colors.subTitleColor
                                    .withOpacity(.5),
                              ),
                              validation: true,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 1.5.h),
                              child: const AppText(
                                'المدينة',
                              ),
                            ),
                            BuildCondition(
                                condition: state is GetCitiesloadingState,
                                builder: (context) =>
                                    AppUtil.appLoader(height: 10.h),
                                fallback: (context) {
                                  return authCubit.cities.isNotEmpty
                                      ? ErboonSearchableField(
                                          hint: 'المدينة',

                                          suggestions: authCubit.cities,
                                          controller: authCubit
                                              .registerCityController,
                                          prefixIcon: Icon(
                                            IconBroken.Location,
                                            size: 6.w,
                                            color: AppUi.colors.subTitleColor
                                                .withOpacity(.5),
                                          ),
                                        )
                                      : AppTextFormFeild(
                                          hint: 'المدينه',
                                            onTap: () {
                                authCubit.getCities(context);
                              },
                                          textInputType: TextInputType.text,
                                          controller: authCubit
                                              .registerCityController,
                                          readOnly:
                                              state is !GetCitiesloadingState,
                                          prefixIcon: Icon(
                                            IconBroken.Location,
                                            size: 6.w,
                                            color: AppUi.colors.subTitleColor
                                                .withOpacity(.5),
                                          ),
                                          validation: true,
                                        );
                                }),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 1.5.h),
                              child: const AppText(
                                'الحى',
                              ),
                            ),
                            AppTextFormFeild(
                              hint: 'الحى',
                              textInputType: TextInputType.emailAddress,
                              controller: authCubit.registerStateController,
                              prefixIcon: Icon(
                                IconBroken.Location,
                                size: 6.w,
                                color:
                                    AppUi.colors.subTitleColor.withOpacity(.5),
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
                              controller: authCubit.registerStreetController,
                              prefixIcon: Icon(
                                IconBroken.Location,
                                size: 6.w,
                                color:
                                    AppUi.colors.subTitleColor.withOpacity(.5),
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
                              controller:
                                  authCubit.registerComercialReportController,
                              prefixIcon: Icon(
                                IconBroken.Folder,
                                size: 6.w,
                                color:
                                    AppUi.colors.subTitleColor.withOpacity(.5),
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
                              controller: authCubit.registerPasswordController,
                              prefixIcon: Icon(
                                IconBroken.Lock,
                                size: 6.w,
                                color:
                                    AppUi.colors.subTitleColor.withOpacity(.5),
                              ),
                              validation: true,
                              suffixIcon: InkWell(
                                onTap: () {
                                  authCubit.registerChangeVisibility();
                                },
                                child: Icon(authCubit.registerVisibilityIcon),
                              ),
                              obscureText: authCubit.isVisibleRegister,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 1.5.h),
                              child: const AppText(
                                'تأكيد الرقم السرى',
                              ),
                            ),
                            AppTextFormFeild(
                              hint: 'تأكيد الرقم السرى',
                              controller:
                                  authCubit.registerConfirmPasswordController,
                              prefixIcon: Icon(
                                IconBroken.Lock,
                                size: 6.w,
                                color:
                                    AppUi.colors.subTitleColor.withOpacity(.5),
                              ),
                              validation: true,
                              suffixIcon: InkWell(
                                onTap: () {
                                  authCubit.registerChangeConfirmVisibility();
                                },
                                child: Icon(
                                    authCubit.registerVisibilityConfirmIcon),
                              ),
                              obscureText: authCubit.isVisibleConfirmRegister,
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            BuildCondition(
                                condition: state is RegisterloadingState ,
                                builder: (context) =>
                                    AppUtil.appLoader(height: 10.h),
                                fallback: (context) {
                                  return EarbunButton(
                                    title: 'الخطوة التالية',
                                    onTap: () async {
                                      if (authCubit
                                          .registerFormKey.currentState!
                                          .validate()) {
                                        if (
                                            authCubit.registerCityController
                                                    .text !=
                                                '') {
                                          await authCubit.authRegister(context);
                                        } else {
                                          AppUtil.appAlert(context,
                                          contentType: ContentType.failure,
                                          msg: 'من فضلك ادخل المدينه اولا'
                                          );
                                        }
                                      }
                                    },
                                  );
                                }),
                            SizedBox(
                              height: 2.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 3.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppText('هل تمتلك حساب ؟',
                                      color: AppUi.colors.subTitleColor),
                                  InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routes.login);
                                      },
                                      child: const AppText('تسجيل دخول'))
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
                ))),
            if (authCubit.isShowed!)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Container(
                  alignment: AlignmentDirectional.topStart,
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(8),
                      image: authCubit.centerImage != null
                          ? DecorationImage(
                              image: FileImage(
                                authCubit.centerImage!,
                              ),
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image: AssetImage(
                                AppUi.assets.launcher,
                              ),
                              fit: BoxFit.cover,
                            )),
                  height: Constants.getHeight(context) * .7,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 15),
                    child: IconButton(
                        onPressed: () {
                          authCubit.changeIsShowed(false);
                        },
                        icon: Icon(
                          IconBroken.Close_Square,
                          color: AppUi.colors.whiteColor,
                          size: 6.h,
                        )),
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
