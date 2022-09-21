import 'package:arboon/blocs/auth_cubit/auth_cubit.dart';
import 'package:arboon/blocs/profile_cubit/profile_cubit.dart';
import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/components/drawer_container.dart';
import 'package:arboon/core/components/drawer_item.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/core/utils/icon_broken.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:sizer/sizer.dart';

class EarabunDrawer extends StatefulWidget {
  final Widget mainScreen;
  const EarabunDrawer({
    Key? key,
    required this.mainScreen,
  }) : super(key: key);

  @override
  State<EarabunDrawer> createState() => _EarabunDrawerState();
}

class _EarabunDrawerState extends State<EarabunDrawer> {
  @override
  void initState() {
    ProfileCubit.get(context).getProfileData(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        return ZoomDrawer(
            angle: 0.0,
            mainScreenAbsorbPointer: false,
            disableDragGesture: true,
            menuBackgroundColor: AppUi.colors.whiteColor,
            slideWidth: MediaQuery.of(context).size.width * 0.6,
            mainScreenScale: .1,
            menuScreen:const DrawerContainer(),
            mainScreen: widget.mainScreen);
      },
    );
  }
}
