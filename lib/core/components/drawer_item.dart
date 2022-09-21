import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon; 
  final Function() onTap;
  const DrawerItem({Key? key, required this.title, required this.icon,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   ListTile(
      onTap: onTap,
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 5.w,
                  horizontalTitleGap: 3.w,
                  leading: Icon(
                   icon,
                    color: AppUi.colors.mainColor,
                  ),
                  title:  AppText(title)
                );
    
  }
}