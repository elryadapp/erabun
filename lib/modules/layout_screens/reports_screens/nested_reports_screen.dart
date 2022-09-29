import 'package:arboon/blocs/reports_cubit/reports_cubit.dart';
import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/config/routes/earbun_navigator_keys.dart';
import 'package:arboon/modules/layout_screens/examination_screens/examination_screen.dart';
import 'package:arboon/modules/layout_screens/home_screens/car_body_img.dart';
import 'package:arboon/modules/layout_screens/reports_screens/main_report_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

class NestedReportsScreen extends StatefulWidget {
  
  const NestedReportsScreen({Key? key}) : super(key: key);

  @override
  State<NestedReportsScreen> createState() => _NestedReportsScreenState();
}

class _NestedReportsScreenState extends State<NestedReportsScreen> {
  @override
 
   void initState() {
    var cubit= ReportsCubit.get(context);
    scrollController=ScrollController();
   cubit.page=1;
        initializeDateFormatting('ar');
cubit.scrollController=scrollController;
        ReportsCubit.get(context).getAllReports(context);
    cubit.scrollController!.addListener(() {
      if (cubit.scrollController!.position.pixels ==
          cubit.scrollController!.position.maxScrollExtent) {
        fetchData();
      }
    });
    super.initState();
  }
ScrollController? scrollController;

  fetchData() async {
    var cubit = ReportsCubit.get(context);

    cubit.page++;

    ReportsCubit.get(context)
        .getAllReports(context, page: cubit.page);
  }
 @override
  void dispose() {
  scrollController!.dispose();
    super.dispose();
  }
 

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: EarbunNavigatorKeys.rebortsNavigatorKey,
      initialRoute: Routes.reports,
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case Routes.reports:
            page = const MainReportScreen();
            break;
   case Routes.carBody:
            page =  CarBodyImage(dataModel:ReportsCubit.get(context).currentReport! ,);
            break;
               case Routes.examinationScreen:
            page =  ExaminationScreen(carObg: ReportsCubit.get(context).currentReport! ,);
            break;
          default:
            page =  Container();
            break;
        }

        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => page,
            transitionDuration: const Duration(seconds: 0));
      },
    );
  }
}
