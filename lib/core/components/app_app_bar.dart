import 'package:arboon/blocs/profile_cubit/profile_cubit.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:sizer/sizer.dart';
import 'app_text.dart';

class EarbunAppbar extends AppBar {
  EarbunAppbar(
    context, {
    Key? key,
    Function()? onLeadingTap,
    bool? isTitleCenterd,
    Widget? leading,
    bool? isLeading = true,
    Color? leadingIconColor,
    Color? backIconColor,
    Widget? title,
    double? leadingWidth,
    bool? showMenu,
    Widget? flexibleSpace,
    String? titleText,
    List<Widget>? actions,
    void Function()? onActionTap,
    PreferredSizeWidget? bottom,
    Color? backgroundColor,
  }) : super(
          key: key,
          bottom: bottom,
          backgroundColor: AppUi.colors.splashColor,
          leadingWidth: leadingWidth ?? 56,
          leading: leading ??
              (IconButton(
                  onPressed: () {
                    if (onLeadingTap != null) {
                      onLeadingTap();
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ))),
          title: title ??
              AppText(
                titleText ?? '',
                color: AppUi.colors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                textOverflow: TextOverflow.visible,
              ),
          actions: actions ??
              [
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    var cubit=ProfileCubit.get(context);
                    return Directionality(
                        textDirection: TextDirection.ltr,
                        child: IconButton(
                            onPressed: () {
                              cubit.changeIsDrawerOpened(ZoomDrawer.of(context)!.isOpen(),context);
                            },
                            icon: !cubit.isDrawerOpened!
                                ? const Icon(Icons.clear)
                                : const Icon(Icons.short_text)));
                  },
                )
              ],
          centerTitle: isTitleCenterd ?? true,
          flexibleSpace: flexibleSpace,
          elevation: 0.0,
        );
}
