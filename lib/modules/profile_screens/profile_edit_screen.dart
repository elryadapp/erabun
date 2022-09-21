import 'package:arboon/blocs/profile_cubit/profile_cubit.dart';
import 'package:arboon/core/components/animated_commponent.dart';
import 'package:arboon/core/components/app_app_bar.dart';
import 'package:arboon/core/components/app_button.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/modules/profile_screens/components/profile_edit_data.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  void initState() {
    ProfileCubit.get(context).getCities(context);
        ProfileCubit.get(context).getProfileData(context);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var cubit=ProfileCubit.get(context);
        return Scaffold(
            appBar: EarbunAppbar(
              context,
              actions: const [],
              titleText: 'بيانات المركز',
            ),
            body: BuildCondition(
              condition: state is GetProfileCitiesloadingState||state is GetProfileDataloadingState ,
              builder: (context)=>AppUtil.appLoader(),
              fallback: (context) {
                return Form(
                    child: ErboonSlideAnimation(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                          ),
                          child: Column(
                            children: [
                              const ProfileEditData(),
                                  BuildCondition(
                                    condition: state is EditProfileInfoloadingState,
                                    builder: (context)=>AppUtil.appLoader(height: 10.h),
                                    fallback: (context) {
                                      return Padding(
                                        padding:  EdgeInsets.symmetric(vertical: 5.h),
                                        child: EarbunButton(
                              title: 'تعديل البيانات',
                              onTap: () {
                                cubit.editCenterInfo(context);
                              },
                            ),
                                      );
                                    }
                                  ),
                            ],
                          ))),
                ));
              }
            ));
      },
    );
  }
}
