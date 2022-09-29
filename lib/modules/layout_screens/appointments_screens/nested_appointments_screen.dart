import 'package:arboon/blocs/appointments_cubit/appointments_cubit.dart';
import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/config/routes/earbun_navigator_keys.dart';
import 'package:arboon/modules/layout_screens/appointments_screens/cancel_appointment.dart';
import 'package:arboon/modules/layout_screens/appointments_screens/cancel_examination.dart';
import 'package:arboon/modules/layout_screens/appointments_screens/main_appoinment_screen.dart';
import 'package:arboon/modules/layout_screens/examination_screens/examination_screen.dart';
import 'package:arboon/modules/layout_screens/home_screens/car_body_img.dart';
import 'package:arboon/modules/layout_screens/home_screens/show_appointment.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

class NestedAppointmentScreen extends StatefulWidget {
  const NestedAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<NestedAppointmentScreen> createState() =>
      _NestedAppointmentScreenState();
}

class _NestedAppointmentScreenState extends State<NestedAppointmentScreen> {
  @override
  void initState() {
    initializeDateFormatting('ar');
scrollController = ScrollController();

       var cubit = AppointmentsCubit.get(context);

cubit.scrollController=scrollController;
    cubit.scrollController!.addListener(() {
      if (cubit.scrollController!.position.pixels ==
          cubit.scrollController!.position.maxScrollExtent) {
        fetchData();
      }
    });

    super.initState();
  }

  ScrollController? scrollController ;

  fetchData() async {
    var cubit = AppointmentsCubit.get(context);
    if (cubit.currentIndex == 0) {
      cubit.page++;

      AppointmentsCubit.get(context)
          .getAllAppointments(context, page: cubit.page);
    } else {
      cubit.canceledPage++;

      AppointmentsCubit.get(context)
          .getCanceledAppointments(context, page: cubit.canceledPage);
    }
  }

//   @override
//   void dispose() {
// scrollController!.dispose();
//     super.dispose();
//   }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: EarbunNavigatorKeys.appointmentsNavigatorKey,
      initialRoute: Routes.appointment,
      onGenerateRoute: (RouteSettings settings) {
        Widget page;

        switch (settings.name) {
          case Routes.appointment:
            page = const MainAppoinmentScreen();
            break;

          case Routes.cancelAppointment:
            page = const CancelAppointment();
            break;
          case Routes.showAppointment:
            page = ShowAppointment(
              appointmentDataModel:
                  AppointmentsCubit.get(context).currenAppointment!,
              onQRReview: AppointmentsCubit.get(context).onQRViewCreated,
            );
            break;
          case Routes.cancelExamination:
            page = const CancelExamination();
            break;

          case Routes.carBody:
            page = CarBodyImage(
              dataModel: AppointmentsCubit.get(context).currenAppointment!,
            );
            break;
          case Routes.examinationScreen:
            page = ExaminationScreen(
                carObg: AppointmentsCubit.get(context).currenAppointment!);
            break;

          default:
            page = Container();
            break;
        }

        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => page,
            transitionDuration: const Duration(seconds: 0));
      },
    );
  }
}
