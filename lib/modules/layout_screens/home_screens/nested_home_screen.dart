import 'package:arboon/blocs/layout_cubit/layout_cubit.dart';
import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/config/routes/earbun_navigator_keys.dart';
import 'package:arboon/modules/layout_screens/examination_screens/examination_screen.dart';
import 'package:arboon/modules/layout_screens/home_screens/car_body_img.dart';
import 'package:arboon/modules/layout_screens/home_screens/main_home_screen.dart';
import 'package:arboon/modules/layout_screens/home_screens/show_appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NestedHomeScreen extends StatefulWidget {
  const NestedHomeScreen({Key? key}) : super(key: key);

  @override
  State<NestedHomeScreen> createState() => _NestedHomeScreenState();
}

class _NestedHomeScreenState extends State<NestedHomeScreen> {
  @override
  void initState() {
    LayoutCubit.get(context).getUserData(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(builder: (context, state) {
      var cubit = LayoutCubit.get(context);
      return Navigator(
        key: EarbunNavigatorKeys.homeNavigatorKey,
        initialRoute: Routes.mainHome,
        onGenerateRoute: (RouteSettings settings) {
          Widget page;

          switch (settings.name) {
            case Routes.mainHome:
              page = const MainHomeScreen();

              break;
            case Routes.showAppointment:
              page = ShowAppointment(
                id: cubit.scanningResult!,
                onQRReview: cubit.onQRViewCreated,
              );
              break;
            case Routes.carBody:
              page = CarBodyImage(
                dataModel: cubit.scanQrCodeModel!,
              );
              
              break;
            case Routes.examinationScreen:
              page = ExaminationScreen(carObg: cubit.scanQrCodeModel!);
              break;

              
              
            default:
              page = const MainHomeScreen();
              break;
          }

          return PageRouteBuilder(
              pageBuilder: (_, __, ___) => page,
              transitionDuration: const Duration(seconds: 0));
        },
      );
    });
  }
}
