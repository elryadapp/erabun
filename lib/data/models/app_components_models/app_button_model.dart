import 'package:flutter/cupertino.dart';

class AppButtonModel{
  final String? title;
  final IconData? icon;
  final Function()? onTap;
  final Color? color;

  AppButtonModel({this.title, this.icon, this.onTap, this.color});
}