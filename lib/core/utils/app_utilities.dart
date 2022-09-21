import 'dart:io';

import 'package:arboon/core/components/app_button.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/icon_broken.dart';
import 'package:arboon/data/models/app_components_models/content_type.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

class AppUtil {
  static final RegExp emailValidatorRegExp =
      RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-_]+\.[a-zA-Z0-9-.]+$)");
  static final RegExp phoneValidatorRegExp = RegExp(r'^\+[0-9]{10,}$');

  static Widget emptyLottie({height, top}) => Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: top ?? 12.h),
          child: Lottie.asset(AppUi.assets.empty, height: height ?? 30.h),
        ),
      );

  static appCachedImage({imgUrl,width,height}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CachedNetworkImage(
          imageUrl: imgUrl,
          imageBuilder: (context, imageProvider) => ClipRRect(
                                    borderRadius: BorderRadius.circular(5),

            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,

                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          placeholder: (context, url) => appLoader(height: 10.h),
          errorWidget: (context, url, error) => Lottie.asset(
            AppUi.assets.noInternet,
            height: 10.h,
          ),
        ),
      ],
    );
  }

  static Future appDialoge(
      {BuildContext? context, Widget? content,Widget?child, String? title}) async {
    return await showDialog(
      barrierDismissible: false,
        context: context!,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, builder) {
            return AlertDialog(

              
              contentPadding: EdgeInsets.zero,
              title:  title==null?child:AppText(
                title,
              ),
              content: content,
            );
          });
        });
  }

  static appRater(
    double initialRating,
  ) {
    return RatingBar.builder(
      initialRating: initialRating,
      minRating: 1,
      itemSize: 2.h,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {},
    );
  }

  static appAlert(context,
      {String? title, String? msg, ContentType? contentType}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        dismissDirection: DismissDirection.horizontal,
        padding: EdgeInsets.only(bottom: 8.h),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: Container(
            decoration: BoxDecoration(
              color: contentType == ContentType.failure
                  ? const Color.fromARGB(255, 238, 218, 217)
                  : contentType == ContentType.success
                      ? const Color.fromARGB(255, 187, 216, 203)
                      : const Color.fromARGB(255, 240, 213, 186),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 3.h),
                      decoration: BoxDecoration(
                        color: contentType == ContentType.failure
                            ? AppUi.colors.failureRed
                            : contentType == ContentType.success
                                ? AppUi.colors.successGreen
                                : AppUi.colors.warningYellow,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                      ),
                      child: contentType == ContentType.failure
                          ? Image.asset(AppUi.assets.errorIcon)
                          : contentType == ContentType.success
                              ? Image.asset(AppUi.assets.successIcon)
                              : SvgPicture.asset(AppUi.assets.warning)),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 3.w,vertical: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText(
                          title ?? 'تنبيه',
                          fontSize: 2.2.h,

                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        AppText(
                          msg ?? '',
                          maxLines: 2,
                          textOverflow: TextOverflow.ellipsis,
                          fontSize: 1.9.h,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ))));
  }

  static Widget appLoader({height,top}) => Column(
    children: [
      if(top!=null)
      SizedBox(height: top,),
      Align(
            alignment: Alignment.center,
            child: Lottie.asset(AppUi.assets.loading, height: height ?? 14.h),
          ),
    ],
  );

  static Future<String> getAddressFromLatLong(LatLng latLng, context) async {
    List<geocoding.Placemark> placemarks = await geocoding
        .placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    geocoding.Placemark place = placemarks[0];

    return '${place.subLocality} ${place.locality} ${place.country}';
  }

  static Future<Position> getCurrentLocation(context) async {
    LocationPermission permission;

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (Platform.isAndroid) {
        await appDialoge(
            context: context,
            title: 'alert',
            content: Row(
              children: [
                Expanded(
                  child: EarbunButton(
                    title: 'no',
                    color: AppUi.colors.failureRed,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: EarbunButton(
                    title: 'yes',
                    color: AppUi.colors.hintColor,
                    onTap: () {
                      Navigator.pop(context);
                      Geolocator.openLocationSettings();
                    },
                  ),
                ),
              ],
            ));
      } else {
        Geolocator.openLocationSettings();
      }
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }


  //==================time picker======================
  // Future<void>pickTimeRange(context)async{
     
  //    TimeRange result = await showTimeRangePicker(
  //               context: context,
  //             );
            
  // }
}
