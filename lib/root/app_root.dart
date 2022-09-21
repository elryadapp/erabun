import 'package:arboon/blocs/appointments_cubit/appointments_cubit.dart';
import 'package:arboon/blocs/auth_cubit/auth_cubit.dart';
import 'package:arboon/blocs/connectivity_cubit/connectivity_cubit.dart';
import 'package:arboon/blocs/examination_cubit/examination_cubit.dart';
import 'package:arboon/blocs/layout_cubit/layout_cubit.dart';
import 'package:arboon/blocs/profile_cubit/profile_cubit.dart';
import 'package:arboon/blocs/reports_cubit/reports_cubit.dart';
import 'package:arboon/config/app_theme/app_theme.dart';
import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/config/routes/earbun_navigator_keys.dart';
import 'package:arboon/config/routes/route_generator.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';
class Earabun extends StatelessWidget {
  const Earabun({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => LayoutCubit(),
        ),
            BlocProvider(
          create: (context) => ReportsCubit(),
        ),
        BlocProvider(
          create: (context) => AppointmentsCubit(),
        ),
           BlocProvider(
          create: (context) => ConnectivityCubit(),
        ),
         BlocProvider(
          create: (context) => ExaminationCubit(),
        )
        , BlocProvider(
          create: (context) => ProfileCubit(),
        )
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
          return  MaterialApp(
              title: 'Earbun',
              navigatorKey: EarbunNavigatorKeys.mainAppNavigatorKey,
            localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: AppThemes.lightTheme,
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.splash,
              
              onGenerateRoute: RouterGenerator.generateRoute,
            
          );
        }
      ),
    );
  }
}
