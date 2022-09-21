import 'package:flutter/services.dart';
import 'package:scan/scan.dart';
import 'package:sizer/sizer.dart';
import 'package:arboon/blocs/layout_cubit/layout_cubit.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EarabunQRView extends StatefulWidget {
  final dynamic onQRReview;

  const EarabunQRView({Key? key, required this.onQRReview}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EarabunQRViewState();
}

class _EarabunQRViewState extends State<EarabunQRView> {
  String platformVersion = 'Unknown';

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await Scan.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      platformVersion = platformVersion;
    });
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        var cubit=LayoutCubit.get(context);
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            ScanView(
              controller: cubit.qrViewController,
              scanAreaScale: .7,
              scanLineColor: AppUi.colors.mainColor,
              onCapture: (data) {
                cubit.scanningResult=data;
                widget.onQRReview();
              },
            ),
            Positioned(
              top: 13.h,
              child: AppText(
                'Scan Qr Code',
                fontWeight: FontWeight.w600,
                fontSize: 3.h,
                color: AppUi.colors.whiteColor.withOpacity(.8),
              ),
            )
          ],
        );
      },
    );

    
  }
}
