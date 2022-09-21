import 'package:arboon/core/utils/app_ui.dart';
import 'package:flutter/cupertino.dart';

class ContentType {
  final String message;

  final Color? color;

  ContentType(this.message, [this.color]);

  static ContentType help = ContentType('help',AppUi.colors.helpBlue);
  static ContentType failure = ContentType('failure', AppUi.colors.failureRed);
  static ContentType success =
      ContentType('success', AppUi.colors.successGreen);
  static ContentType warning =
      ContentType('warning', AppUi.colors.warningYellow);
}