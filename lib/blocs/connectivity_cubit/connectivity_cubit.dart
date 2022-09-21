import 'dart:async';

import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/data/models/app_components_models/content_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(ConnectivityInitial());
  static ConnectivityCubit get(context) => BlocProvider.of(context);
  final Connectivity connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;
  bool hasConnection = true;



  Future<void> checkConnection(context,{required Connectivity connectivity}) async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      hasConnection = false;

      AppUtil.appAlert(context,contentType: ContentType.failure,msg: 'انقطع الاتصال بالانترنت');
      emit(DisconnectedState());
    } else {
      hasConnection = true;
      emit(ConnectedState());
    }
  }
}
