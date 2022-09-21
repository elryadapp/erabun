import 'package:arboon/blocs/auth_cubit/auth_cubit.dart';
import 'package:arboon/core/components/app_app_bar.dart';
import 'package:arboon/modules/auth/register/components/basic_info.dart';
import 'package:arboon/modules/auth/register/components/complete_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        var authCubit = AuthCubit.get(context);

        return Scaffold(
            appBar: EarbunAppbar(
              context,
              actions: const [],
              leading: Container(),
              titleText: 'انشاء حساب',
            ),
            body: authCubit.currentRegisterIndex == 0
                ? const BasicInfo()
                : const CompleteInfo());
      },
    );
  }
}
