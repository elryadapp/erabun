import 'package:arboon/core/components/app_button.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/data/models/app_components_models/app_button_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RowButton extends StatelessWidget {
  final List<AppButtonModel> appButtonModel;
  const RowButton({Key? key, required this.appButtonModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: EarbunButton(
              height: 5.h,
              color: appButtonModel[0].color??AppUi.colors.mainColor,
          titleWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                appButtonModel[0].icon!,
                color: AppUi.colors.whiteColor,
              ),
              SizedBox(
                width: 2.w,
              ),
              AppText(
                appButtonModel[0].title!,
                fontSize: 1.7.h,
                color: AppUi.colors.whiteColor,
              )
            ],
          ),
          onTap: () {
            appButtonModel[0].onTap!();
          },
        )),
        SizedBox(
          width: 3.w,
        ),
        Expanded(
            child: EarbunButton(
              height: 5.h,
          color: AppUi.colors.whiteColor,
          titleWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                appButtonModel[1].icon!,
                color: AppUi.colors.mainColor,
              ),
              SizedBox(
                width: 2.w,
              ),
              AppText(
                appButtonModel[1].title!,
                color: AppUi.colors.mainColor,
                fontSize: 1.7.h,
              )
            ],
          ),
          border: Border.all(color: AppUi.colors.mainColor),
          onTap: () {
            appButtonModel[1].onTap!();
          },
        ))
      ],
    );
  }
}
