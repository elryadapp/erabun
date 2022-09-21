
import 'package:arboon/core/components/app_app_bar.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class LostInternetConnection extends StatelessWidget {
  const LostInternetConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: EarbunAppbar(context,
actions: const[],
leading: Container(),
),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              AppUi.assets.noInternet,
              height: 50.h,
            ),
            SizedBox(height: 4.h,),
         const   AppText(
            ' يرجى التاكد من الاتصال بالانترنت'
            )
          ],

          
        ),
      ),
    );
  }
}
