import 'package:arboon/blocs/appointments_cubit/appointments_cubit.dart';
import 'package:arboon/blocs/connectivity_cubit/connectivity_cubit.dart';
import 'package:arboon/blocs/layout_cubit/layout_cubit.dart';
import 'package:arboon/blocs/profile_cubit/profile_cubit.dart';
import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/core/components/app_button.dart';

import 'package:arboon/core/components/app_text.dart';
import 'package:arboon/core/components/erboon_drawer.dart';
import 'package:arboon/core/utils/app_ui.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:arboon/core/utils/icon_broken.dart';
import 'package:arboon/layout/lost_internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:sizer/sizer.dart';

class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  void initState() {
    LayoutCubit.get(context).checkUserAvalibality().then((value){
       if(!LayoutCubit.get(context).isUserAvalibal!){
        Navigator.pushReplacementNamed(
          context,
          Routes.login,
        );

    }
    });
   
    var connection = ConnectivityCubit.get(context);
    connection.connectivitySubscription =
        connection.connectivity.onConnectivityChanged.listen((event) {
      connection.checkConnection(context,
          connectivity: connection.connectivity);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EarabunDrawer(mainScreen: BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return WillPopScope(
          onWillPop: () async {
            if (ZoomDrawer.of(context)!.isOpen()) {
              ProfileCubit.get(context).changeIsDrawerOpened(true, context);
              return false;
            } else {
              if (cubit.currentPageIndex == 2 &&
                  cubit.currentScanType ==
                      ScanType.examinationAppointmentScan) {
                cubit.changeScaningState();
                return false;
              } 
              else if(cubit.currentPageIndex!=2&& !AppointmentsCubit.get(context).isScan){
                cubit.changeCurrentPageIndex(2);
                return false;
              }
                 else if(cubit.currentPageIndex!=2&& AppointmentsCubit.get(context).isScan){
                AppointmentsCubit.get(context).changeIsScan(false);
                return false;
              }
             
              else {
                bool? isConfirmed;
                AppUtil.appDialoge(
                    context: context,
                    title: '',
                    content: Padding(
                      padding: EdgeInsets.all(2.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const AppText('هل تريد الخروج من التطبيق؟'),
                          SizedBox(
                            height: 4.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: EarbunButton(
                                  width: 5.w,
                                  borderRadius: BorderRadius.circular(2),
                                  height: 4.h,
                                  title: 'لا',
                                  color: AppUi.colors.failureRed,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Expanded(
                                child: EarbunButton(
                                  width: 5.w,
                                  height: 4.h,
                                  title: 'نعم',
                                  borderRadius: BorderRadius.circular(2),
                                  color: AppUi.colors.successGreen,
                                  onTap: () {
                                    SystemNavigator.pop();
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                        ],
                      ),
                    ));
                return isConfirmed!;
              }
            }
          },
          child: Scaffold(
            body: BlocBuilder<ConnectivityCubit, ConnectivityState>(
              builder: (context, state) {
                var internetCubit = ConnectivityCubit.get(context);
                return !internetCubit.hasConnection
                    ? const LostInternetConnection()
                    : cubit.pages[cubit.currentPageIndex];
              },
            ),
            floatingActionButton:
                MediaQuery.of(context).viewInsets.bottom != 0.0
                    ? null
                    : FloatingActionButton(
                        backgroundColor: AppUi.colors.whiteColor,
                        onPressed: () {
                          cubit.changeCurrentPageIndex(
                            2,
                          );
                        },
                        child: Icon(
                          IconBroken.Scan,
                          color: AppUi.colors.mainColor,
                          size: 5.h,
                        ),
                      ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
                notchMargin: 6,
                clipBehavior: Clip.antiAlias,
                color: AppUi.colors.splashColor,
                shape: const CircularNotchedRectangle(),
                elevation: 9,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppUi.colors.splashColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  height: 60,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        cubit.pagesIcon.toList().length,
                        (index) => InkWell(
                          onTap: () {
                            cubit.changeCurrentPageIndex(
                              index,
                            );
                          },
                          child: EarbunButton(
                            height: 5.h,
                            color: AppUi.colors.splashColor,
                            width: Constants.getwidth(context) * .45,
                            titleWidget: Container(
                              padding: EdgeInsets.symmetric(vertical: 1.h),
                              margin: EdgeInsets.only(
                                  right: index == 1 ? 10.w : 0,
                                  left: index == 0 ? 10.w : 0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: cubit.currentPageIndex == index
                                      ? AppUi.colors.whiteColor
                                      : AppUi.colors.splashColor),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(cubit.pagesIcon.toList()[index],
                                      color: cubit.currentPageIndex == index
                                          ? AppUi.colors.splashColor
                                          : AppUi.colors.whiteColor),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  AppText(cubit.pageTitles[index],
                                      color: cubit.currentPageIndex == index
                                          ? AppUi.colors.splashColor
                                          : AppUi.colors.whiteColor),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          ),
        );
      },
    ));
  }
}
