import 'package:arboon/blocs/profile_cubit/profile_cubit.dart';
import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/components/drawer_item.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/core/utils/icon_broken.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class DrawerContainer extends StatefulWidget {
  const DrawerContainer({Key? key}) : super(key: key);

  @override
  State<DrawerContainer> createState() => _DrawerContainerState();
}

class _DrawerContainerState extends State<DrawerContainer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var cubit=ProfileCubit.get(context);
        return Container(
          color: AppUi.colors.whiteColor,
          child: Padding(
            padding: EdgeInsets.only(
              top: 10.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.profile);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BuildCondition(
                          condition: state is GetProfileDataloadingState,
                          builder: (context) => AppUtil.appLoader(height: 10.h),
                          fallback: (context) {
                            return Container(
                              height: 10.h,
                              width: 10.w,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppUi.colors.subTitleColor,
                                  ),
                                  image: cubit.profileDataModel?.image != null
                                      ? DecorationImage(
                                          image: NetworkImage(
                                            AppUi.assets.networkUrlImgBase +
                                                cubit.profileDataModel!.image!,
                                          ),
                                          fit: BoxFit.cover)
                                      : DecorationImage(
                                          image: AssetImage(
                                            AppUi.assets.launcher,
                                          ),
                                          fit: BoxFit.cover)),
                            );
                          }),
                      SizedBox(width: 3.w),
                      AppText(cubit.profileDataModel?.name ?? '')
                    ],
                  ),
                ),
                DrawerItem(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.termesAndConditions);
                    },
                    title: 'الشروط والاحكام',
                    icon: IconBroken.Info_Circle),
                BuildCondition(
                    condition: state is ShareAppLinkloadingState,
                    builder: (context) => AppUtil.appLoader(height: 10.h),
                    fallback: (context) {
                      return DrawerItem(
                          onTap: () {
                            cubit.shareApp(context);
                          },
                          title: 'مشاركة التطبيق',
                          icon: Icons.share_outlined);
                    }),
                BuildCondition(
                    condition: state is GetWhatsAppUrlloadingState,
                    builder: (context) => AppUtil.appLoader(height: 10.h),
                    fallback: (context) {
                      return DrawerItem(
                        onTap: () async {
                          await cubit.getWhatsAppUrl(context);
                        },
                        title: 'تواصل معنا',
                        icon: Icons.whatsapp_outlined,
                      );
                    }),
                BuildCondition(
                    condition: state is LogoutloadingState,
                    builder: (context) => AppUtil.appLoader(height: 10.h),
                    fallback: (context) {
                      return DrawerItem(
                          onTap: () async {
                            await cubit.logout(context);
                          },
                          title: 'تسجيل خروج',
                          icon: IconBroken.Logout);
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
