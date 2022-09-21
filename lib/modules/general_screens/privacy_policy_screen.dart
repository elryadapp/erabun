import 'package:arboon/blocs/layout_cubit/layout_cubit.dart';
import 'package:arboon/core/components/app_app_bar.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/core/utils/constants.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webviewx/webviewx.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
    @override
  void initState() {
    LayoutCubit.get(context).getPrivacyPolicy();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        var cubit =LayoutCubit.get(context);
        return Scaffold(
          appBar: EarbunAppbar(
            context,
            titleText: 'سياسات الخصوصية',
            actions: const [],
          ),
          body:BuildCondition(
            condition: state is GetPrivacyloadingState,
            builder: (context)=>AppUtil.appLoader(),
            fallback: (context) {
              return WebViewX(
                height: Constants.getHeight(context)
                ,
                width: Constants.getwidth(context),
    initialContent: cubit.policyModel!.data!.data!.termsConditions??'',
    initialSourceType: SourceType.html,
   
);
            }
          ) ,
        );
      },
    );
  }
}
