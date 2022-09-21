import 'package:arboon/blocs/profile_cubit/profile_cubit.dart';
import 'package:arboon/core/components/app_app_bar.dart';
import 'package:arboon/core/components/app_button.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/components/app_text_form_field.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:arboon/core/utils/icon_broken.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class PhoneEditScreen extends StatelessWidget {
  const PhoneEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        return Scaffold(
          appBar: EarbunAppbar(
            context,
            actions: const [],
            titleText: 'تعديل رقم الجوال',
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText('ادخل هاتفك الجديد لارسال الكود', fontSize: 2.3.h),
                  SizedBox(
                    height: 2.h,
                  ),
                  Lottie.asset(AppUi.assets.phoneOTP),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    child: AppTextFormFeild(
                      hint: 'الهاتف',
                      textInputType: TextInputType.phone,
                      controller: cubit.newPhoneNum,
                      prefixIcon: CountryCodePicker(
                        padding: EdgeInsets.zero,
                        onChanged: (val) {
                          if (val.code != '') {
                            cubit.newPhoneNumCode = val.dialCode!;
                          }
                        },
                        dialogSize: Size(Constants.getwidth(context) * .8,
                            Constants.getHeight(context) * .7),
                        dialogTextStyle:
                            TextStyle(color: AppUi.colors.mainColor),
                        searchDecoration: const InputDecoration(
                          prefixIcon: Icon(IconBroken.Search),
                          hintText: 'ابحث عن الدولة',
                        ),
                        initialSelection: 'sa',
                        textStyle: TextStyle(color: AppUi.colors.mainColor),
                        flagDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                      ),
                      validation: true,
                    ),
                  ),
                  BuildCondition(
                      builder: (context) => AppUtil.appLoader(height: 10.h),
                      condition: state is UpdateMobileloadingState,
                      fallback: (context) {
                        return EarbunButton(
                          title: 'تعديل رقم الجوال ',
                          onTap: () {
                            cubit.updatePhoneNumber(context);
                          },
                        );
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
