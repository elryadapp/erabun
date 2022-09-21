import 'package:arboon/blocs/auth_cubit/auth_cubit.dart';
import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/config/routes/earbun_navigator_keys.dart';
import 'package:arboon/core/components/animated_commponent.dart';
import 'package:arboon/core/components/app_app_bar.dart';
import 'package:arboon/core/components/app_button.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/components/app_text_form_field.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:arboon/core/utils/icon_broken.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:country_code_picker/country_code_picker.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        var authCubit = AuthCubit.get(context);
        return Scaffold(
            appBar: EarbunAppbar(
              context,
              leading: Container(),
              actions: const [],
              titleText: 'تسجيل دخول',
            ),
            body: Form(
                key: authCubit.loginFormKey,
                child: ErboonSlideAnimation(
                    verticalOffset: 200,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 6.h,
                          horizontal: 5.w,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: AppText(
                                  'مرحبا بك مرة اخرى',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: 1.5.h, top: 5.h),
                                child: const AppText(
                                  'الهاتف',
                                ),
                              ),
                              AppTextFormFeild(
                                hint: 'الهاتف',
                                textInputType: TextInputType.phone,
                                controller: authCubit.loginPhoneController,
                                prefixIcon: CountryCodePicker(
                                  padding: EdgeInsets.zero,
                                  onChanged: (val) {
                                    if (val.code != '') {
                                      authCubit.loginCountryCode = val.dialCode;
                                    }
                                  },
                                  
                                  dialogSize: Size(
                                      Constants.getwidth(context) * .8,
                                      Constants.getHeight(context) * .7),
                                  emptySearchBuilder: (context) {
                                    return Column(children: [
                                      AppUtil.emptyLottie(top: 2.h),
                                      const AppText(
                                        'لا يوجد دولة بهذه البيانات',
                                        height: 2,
                                      ),
                                 
                                    ]);
                                  },
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
                                  'الرقم السرى',
                                ),
                              ),
                              AppTextFormFeild(
                                hint: 'الرقم السرى',
                                controller: authCubit.loginPasswordController,
                                prefixIcon: Icon(
                                  IconBroken.Lock,
                                  size: 6.w,
                                  color: AppUi.colors.subTitleColor
                                      .withOpacity(.5),
                                ),
                                validation: true,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    authCubit.loginChangeVisibility();
                                  },
                                  child: Icon(authCubit.loginVisibilityIcon),
                                ),
                                obscureText: authCubit.isVisibleLogin,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 3.h),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routes.forgetPassword);
                                      },
                                      child: AppText(
                                        'نسيت الرقم السرى',
                                        color: AppUi.colors.mainColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              BuildCondition(
                                  condition: state is LoginloadingState ,
                                  builder: (context) =>
                                      AppUtil.appLoader(height: 10.h),
                                  fallback: (context) {
                                    return EarbunButton(
                                      title: 'تسجيل دخول',
                                      onTap: () {
                                        if (authCubit.loginFormKey.currentState!
                                            .validate()) {
                                          authCubit.authLogin(context);
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
                                    AppText('لا تمتلك حساب ؟ ',
                                        color: AppUi.colors.subTitleColor),
                                    InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, Routes.register);
                                        },
                                        child: const AppText('أنشئ حساب جديد'))
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    ))));
      },
    );
  }
}
