import 'package:arboon/blocs/profile_cubit/profile_cubit.dart';
import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/core/components/app_app_bar.dart';
import 'package:arboon/core/components/app_button.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/core/utils/icon_broken.dart';
import 'package:arboon/modules/reviews/components/review_card.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    ProfileCubit.get(context)
        .getCities(context)
        .then((value) => ProfileCubit.get(context).getProfileData(context));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: EarbunAppbar(
            context,
            actions: const [],
            titleText: 'صفحة المركز',
          ),
          body: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              var cubit = ProfileCubit.get(context);
              return BuildCondition(
                  condition: state is GetProfileDataloadingState ||
                      state is GetProfileCitiesloadingState,
                  builder: (context) => AppUtil.appLoader(),
                  fallback: (context) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.all(3.h),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 2.h),
                              Center(
                                child: Stack(
                                  alignment: AlignmentDirectional.bottomStart,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: AppUi
                                          .colors.subTitleColor
                                          .withOpacity(.3),
                                      radius: 6.7.h,
                                      child: cubit.profileDataModel?.image ==
                                              null
                                          ? CircleAvatar(
                                              radius: 6.5.h,
                                              backgroundImage:
                                                  AssetImage(AppUi.assets.logo),
                                            )
                                          : CircleAvatar(
                                              radius: 6.5.h,
                                              backgroundImage: NetworkImage(
                                                  AppUi.assets
                                                          .networkUrlImgBase +
                                                      cubit.profileDataModel!
                                                          .image!),
                                            ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routes.profileEdit);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(.7.h),
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppUi.colors.whiteColor,
                                            border: Border.all(
                                                color: AppUi
                                                    .colors.subTitleColor
                                                    .withOpacity(.4))),
                                        child: Icon(
                                          IconBroken.Camera,
                                          size: 2.3.h,
                                          color: AppUi.colors.subTitleColor
                                              .withOpacity(.5),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Center(
                                child: AppText(
                                  cubit.profileDataModel!.name!,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 2.3.h,
                                  height: 2.5,
                                ),
                              ),
                              BuildCondition(
                                  condition:
                                      state is ChangeProfileStatusloadingState,
                                  builder: (context) =>
                                      AppUtil.appLoader(height: 10.h),
                                  fallback: (context) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 3.h),
                                      child: Row(
                                        children: [
                                          AppText(
                                            'اختيار الحالة',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 2.3.h,
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Theme(
                                            data: ThemeData(
                                                unselectedWidgetColor:
                                                    AppUi.colors.mainColor),
                                            child: Radio(
                                                activeColor:
                                                    AppUi.colors.mainColor,
                                                value: 1,
                                                groupValue: cubit.status!,
                                                onChanged: (value) {
                                                  cubit.changeUserStatus(value);
                                                  cubit.changeCenterStatus(
                                                      1, context);
                                                }),
                                          ),
                                          const AppText('متاح'),
                                          Theme(
                                            data: ThemeData(
                                                unselectedWidgetColor:
                                                    AppUi.colors.mainColor),
                                            child: Radio(
                                                activeColor:
                                                    AppUi.colors.mainColor,
                                                value: 0,
                                                groupValue: cubit.status!,
                                                onChanged: (value) {
                                                  cubit.changeUserStatus(value);
                                                  cubit.changeCenterStatus(
                                                      0, context);
                                                }),
                                          ),
                                          const AppText('غير متاح'),
                                        ],
                                      ),
                                    );
                                  }),
                              EarbunButton(
                                color:
                                    AppUi.colors.subTitleColor.withOpacity(.3),
                                titleWidget: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      IconBroken.Edit_Square,
                                      color: AppUi.colors.mainColor,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    const AppText(
                                      'تعديل بيانات المركز',
                                      fontWeight: FontWeight.w600,
                                    )
                                  ],
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.profileEdit);
                                },
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              EarbunButton(
                                color:
                                    AppUi.colors.subTitleColor.withOpacity(.3),
                                titleWidget: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      IconBroken.Edit_Square,
                                      color: AppUi.colors.mainColor,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    const AppText(
                                      'تعديل رقم الجوال',
                                      fontWeight: FontWeight.w600,
                                    )
                                  ],
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.phoneEdit);
                                },
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              EarbunButton(
                                color:
                                    AppUi.colors.subTitleColor.withOpacity(.3),
                                titleWidget: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      IconBroken.Calendar,
                                      color: AppUi.colors.mainColor,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    const AppText(
                                      'تعديل مواعيد المركز',
                                      fontWeight: FontWeight.w600,
                                    )
                                  ],
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.timeTableEdit);
                                },
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              BuildCondition(
                                  condition: state is DeleteAccountloadingState,
                                  builder: (context) =>
                                      AppUtil.appLoader(height: 10.h),
                                  fallback: (context) {
                                    return EarbunButton(
                                      color: AppUi.colors.subTitleColor
                                          .withOpacity(.3),
                                      titleWidget: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            IconBroken.Delete,
                                            color: AppUi.colors.mainColor,
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          const AppText(
                                            'مسح الحساب الشخصى',
                                            fontWeight: FontWeight.w600,
                                          )
                                        ],
                                      ),
                                      onTap: () {
                                        cubit.deleteAccount(context);
                                      },
                                    );
                                  }),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.h),
                                child: const Divider(
                                  thickness: 1.5,
                                ),
                              ),
                              if (cubit.profileDataModel!.reviews!.isNotEmpty)
                                Row(
                                  children: [
                                    const AppText(
                                      'تقييمات المركز',
                                      fontWeight: FontWeight.w600,
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routes.reviews);
                                      },
                                      child: AppText(
                                        'عرض الكل',
                                        textDecoration:
                                            TextDecoration.underline,
                                        decorationColor: AppUi.colors.mainColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              if (cubit.profileDataModel!.reviews!.isNotEmpty)
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 2.5.h),
                                  child: Row(
                                    children: [
                                      AppUtil.appRater(double.parse(cubit
                                          .profileDataModel!.rate!
                                          .toString())),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3.w),
                                        child: AppText(
                                          cubit.profileDataModel!.rate!
                                              .toString(),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Icon(
                                        IconBroken.User,
                                        color: AppUi.colors.mainColor,
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      AppText(
                                        cubit.profileDataModel!.reviewsNum!
                                            .toString(),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                ),
                              if (cubit.profileDataModel!.reviews!.isNotEmpty)
                                SizedBox(
                                  height: 2.h,
                                ),
                              if (cubit.profileDataModel!.reviews!.isNotEmpty)
                                SizedBox(
                                  height: 30.h,
                                  child: ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        const ReviewCard(),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(width: 2.w),
                                    itemCount: 10,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                ),
                              if (cubit.profileDataModel!.reviews!.isEmpty)
                                Column(
                                  children: [
                                    AppUtil.emptyLottie(top: 0.h),
                                    const AppText('لا يوجد لديك تقييمات حاليا')
                                  ],
                                )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
          ),
        );
      },
    );
  }
}
