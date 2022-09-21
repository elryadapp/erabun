import 'package:arboon/core/components/app_button.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MainHeader extends StatelessWidget {
  final String firstTitle;
  final String lastTitle;
  final int index;
  final Function firstOnTap;
  final Function lastOnTap;
  final bool isAppointment;
  const MainHeader(
      {Key? key,
      required this.firstTitle,
      required this.lastTitle,
      required this.firstOnTap,
      required this.lastOnTap,
      required this.isAppointment,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
   Expanded(
            child: EarbunButton(
          height: 4.5.h,
                      fontSize: 1.5.h,

          border: Border.all(color: AppUi.colors.splashColor),
          title: firstTitle,
          titleColor:
              index != 0 ? AppUi.colors.mainColor : AppUi.colors.whiteColor,
          color:
              index == 0 ? AppUi.colors.splashColor : AppUi.colors.whiteColor,
          onTap: firstOnTap,
        )),
        SizedBox(
          width: 3.w,
        ),
        Expanded(
            child: EarbunButton(
                          fontSize: 1.5.h,

                height: 4.5.h,
                border: Border.all(color: AppUi.colors.splashColor),
                title: lastTitle,
                color: index == 1 
                    ? AppUi.colors.splashColor
                    : AppUi.colors.whiteColor,
                titleColor: index != 1 
                    ? AppUi.colors.mainColor
                    : AppUi.colors.whiteColor,
                onTap: lastOnTap))
      ],
    );
  }
}
