import 'package:arboon/blocs/appointments_cubit/appointments_cubit.dart';
import 'package:arboon/core/components/app_app_bar.dart';
import 'package:arboon/modules/layout_screens/appointments_screens/all_appointment_screen.dart';
import 'package:arboon/modules/layout_screens/appointments_screens/appointment_toggle.dart';
import 'package:arboon/modules/layout_screens/appointments_screens/canceled_appointment_screen.dart';
import 'package:arboon/modules/layout_screens/home_screens/components/home_qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainAppoinmentScreen extends StatelessWidget {
  const MainAppoinmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentsCubit, AppointmentsState>(
      builder: (context, state) {
        var cubit = AppointmentsCubit.get(context);
        return Scaffold(
            appBar: EarbunAppbar(
              context,
              titleText: 'المواعيد',
              leading: Container(),
            ),
            body: cubit.isScan
                ? EarabunQRView(onQRReview: cubit.onQRViewCreated)
                : RefreshIndicator(
                    onRefresh: () {
                      if (cubit.currentIndex == 0) {
                        return cubit.getAllAppointments(context,
                            isRefresh: true);
                      } else {
                        return cubit.getCanceledAppointments(context,
                            isRefresh: true);
                      }
                    },
                    child: CustomScrollView(
                      controller: cubit.scrollController,
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        const SliverToBoxAdapter(
                          child: AppointmentToggleWidget(),
                        ),
                        SliverToBoxAdapter(
                          child: cubit.currentIndex == 0
                              ? const AllAppointmentScreen()
                              : const CanceledAppointmentScreen(),
                        ),
                      ],
                    ),
                  ));
      },
    );
  }
}
