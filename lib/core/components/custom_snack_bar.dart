import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:arboon/data/models/app_components_models/content_type.dart';
import'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
class ErboonSnackbarContent extends StatelessWidget {
  
  final String title;

  final String message;

  final Color? color;

  final ContentType contentType;

  const ErboonSnackbarContent({
    Key? key,
    this.color,
    required this.title,
    required this.message,
    required this.contentType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final hsl = HSLColor.fromColor(color ?? contentType.color!);
    final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: Constants.getwidth(context)*.8,
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.025,
          ),
          decoration: BoxDecoration(
            color: color ?? contentType.color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: size.height * 0.025,
                  color: Colors.white,
                ),
              ),

              Text(
                message,
                style: TextStyle(
                  fontSize: size.height * 0.016,
                  color: Colors.white,
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),

        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
            ),
            child: SvgPicture.asset(
               AppUi.assets.bubbles,
              height: size.height * 0.06,
              width: size.width * 0.05,
              color: hslDark.toColor(),
            ),
          ),
        ),
        PositionedDirectional(
          top: -size.height * 0.02,
          end: 10.w,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                 AppUi.assets.back,
                height: size.height * 0.06,
                color: hslDark.toColor(),
              ),
              Positioned(
                top: size.height * 0.015,
            
                child: SvgPicture.asset(
                  assetSVG(contentType),
                  height: size.height * 0.022,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  String assetSVG(ContentType contentType) {
    if (contentType == ContentType.failure) {
      return  AppUi.assets.failure;
    } else if (contentType == ContentType.success) {
      return  AppUi.assets.success;
    } else if (contentType == ContentType.warning) {
      return  AppUi.assets.warning;
    } else if (contentType == ContentType.help) {
      return  AppUi.assets.help;
    } else {
      return  AppUi.assets.failure;
    }
  }
}