// import 'package:arboon/blocs/auth_cubit/auth_cubit.dart';
// import 'package:arboon/core/components/app_app_bar.dart';
// import 'package:arboon/core/components/app_button.dart';
// import 'package:arboon/core/components/app_text.dart';
// import 'package:arboon/core/components/app_text_form_field.dart';
// import 'package:arboon/core/utils/app_ui.dart';
// import 'package:arboon/core/utils/app_utilities.dart';
// import 'package:arboon/core/utils/icon_broken.dart';
// import 'package:buildcondition/buildcondition.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lottie/lottie.dart';
// import 'package:sizer/sizer.dart';

// class NewPassword extends StatelessWidget {
//   const NewPassword({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthCubit, AuthState>(
//       builder: (context, state) {
//         var authCubit = AuthCubit.get(context);
//         return Scaffold(
//           appBar: EarbunAppbar(
//             context,
//             actions: const [],
//             titleText: 'تغيير الرقم السرى',
//           ),
//           body: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 5.w),
//             child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   Center(
//                       child:
//                           Lottie.asset(AppUi.assets.passwordOTP, height: 37.h,fit: BoxFit.cover)),
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 1.5.h),
//                     child: const AppText(
//                       'الرقم السرى الجديد',
//                     ),
//                   ),
//                   AppTextFormFeild(
//                     hint: 'الرقم السرى ',
//                     controller: authCubit.password,
//                     prefixIcon: Icon(
//                       IconBroken.Lock,
//                       size: 6.w,
//                       color: AppUi.colors.subTitleColor.withOpacity(.5),
//                     ),
//                     validation: true,
//                     suffixIcon: InkWell(
//                       onTap: () {
//                         authCubit.loginChangeVisibility();
//                       },
//                       child: Icon(authCubit.loginVisibilityIcon),
//                     ),
//                     obscureText: authCubit.isVisibleLogin,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 1.5.h),
//                     child: const AppText(
//                       ' تاكيد الرقم السرى الجديد ',
//                     ),
//                   ),
//                   AppTextFormFeild(
//                     hint: 'تاكيد الرقم السرى الجديد',
//                     controller: authCubit.passwordConfirmation,
//                     prefixIcon: Icon(
//                       IconBroken.Lock,
//                       size: 6.w,
//                       color: AppUi.colors.subTitleColor.withOpacity(.5),
//                     ),
//                     validation: true,
//                     suffixIcon: InkWell(
//                       onTap: () {
//                         authCubit.loginChangeVisibility();
//                       },
//                       child: Icon(authCubit.loginVisibilityIcon),
//                     ),
//                     obscureText: authCubit.isVisibleLogin,
//                   ),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   BuildCondition(
//                     condition: state is ResetPasswordloadingState,
//                     builder: (context)=>AppUtil.appLoader(height: 10.h),
//                     fallback: (context) {
//                       return ErboonButton(
//                         title: 'تغيير الرقم السرى',
//                         onTap: () async {
//                           await authCubit.resetPassword(context);
//                         },
//                       );
//                     }
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
