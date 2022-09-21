import 'package:arboon/blocs/layout_cubit/layout_cubit.dart';
import 'package:arboon/core/components/app_app_bar.dart';
import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:arboon/modules/layout_screens/home_screens/components/home_qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return Column(
          children: [
            EarbunAppbar(
              context,
              leadingWidth: 0,
              leading: Container(),
              title: Row(
                children: [
                  Container(
                    height: 10.h,
                    width: 10.w,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppUi.colors.subTitleColor,
                        ),
                        image: LayoutCubit.get(context)
                                    .profileDataModel
                                    ?.image !=
                                null
                            ? DecorationImage(
                                image: NetworkImage(
                                  AppUi.assets.networkUrlImgBase +
                                      LayoutCubit.get(context)
                                          .profileDataModel!
                                          .image!,
                                ),
                                fit: BoxFit.cover)
                            : DecorationImage(
                                image: AssetImage(
                                  AppUi.assets.launcher,
                                ),
                                fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  AppText(
                    LayoutCubit.get(context).profileDataModel?.name ?? '',
                    color: AppUi.colors.whiteColor,
                  )
                ],
              ),
            ),
            Expanded(
              child: 
              cubit.currentScanType ==
                      ScanType.examinationAppointmentScan
                  ? EarabunQRView(
                      onQRReview: cubit.onQRViewCreated,
                    )
                  : 
                  Stack(
                      children: [
                        Image.asset(
                          AppUi.assets.homeBg,
                          height: Constants.getHeight(context),
                          width: Constants.getwidth(context),
                          fit: BoxFit.cover,
                        ),
                        Container(
                          color: Colors.black54,
                          child: Center(
                              child: InkWell(
                            onTap: () {
                              cubit.changeScaningState(
                                  scanType:
                                      ScanType.examinationAppointmentScan);
                              
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage(AppUi.assets.qrBorder))),
                              child: Padding(
                                padding: EdgeInsets.all(3.h),
                                child: Image.asset(AppUi.assets.qrCode),
                              ),
                            ),
                          )),
                        )
                      ],
                    ),
            )
          ],
        );
      },
    );
  }
}
