import 'package:arboon/config/routes/app_routes.dart';
import 'package:arboon/config/routes/earbun_navigator_keys.dart';
import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/data/models/app_components_models/content_type.dart';
import 'package:arboon/data/models/remote_data_models/appointment_models/all_appointment_model.dart';
import 'package:arboon/data/repos/appointment_repo/appointment_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'appointments_state.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  AppointmentsCubit() : super(AppointmentsInitial());
  static AppointmentsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  void changeAppointmentIndex(newIndex) {
    currentIndex = newIndex;
    emit(ChangeAppointmentIndexState());
  }

  List<String> cancelReasone = ['البائع', 'المشترى', 'كلا الطرفين'];
  String? selectedCancelReson;
  void changeCancelationReson(val) {
    selectedCancelReson = val;
    emit(ChangeCancelationResonState());
  }

  bool isScan = false;
  void changeIsScan(isScanState) {
    isScan = isScanState;
    emit(ChangeIsScanState());
  }

//============================get all appointment========================
  AllAppointmentModel? allAppointmentModel;
  List<AppointmentDataModel> appointmentList = [];

  Future<void> getAllAppointments(context,
      {page = 1, isRefresh = false}) async {
    if (page == 1 && !isRefresh) {
      appointmentList = [];
      emit(GetAllAppointmentsLoadingState());
    } else if (isRefresh) {
      appointmentList = [];

      emit(GetRefreshAppointmentsLoadingState());
    } else {
      emit(GetPaginatedAppointmentsLoadingState());
    }
    try {
      var res = await AppointmentRepository.getAllAppointments(page: page);
      allAppointmentModel = AllAppointmentModel.fromJson(res);

      if (allAppointmentModel!.status!) {
        appointmentList.addAll(allAppointmentModel?.data ?? []);

        emit(GetAllAppointmentsLoadedState());
      } else {
        AppUtil.appAlert(context,
            contentType: ContentType.failure, msg: 'حدث خطا ');
        emit(GetAllAppointmentsErrorState());
      }
      isRefresh = false;
    } catch (error) {
      emit(GetAllAppointmentsErrorState());
    }
  }

  //=======================examination cancel=======================
  final examinationCancelResoneController = TextEditingController();
  AppointmentDataModel? currenAppointment;
  Future<void> cancelExamination(appointmentId, context) async {
    emit(CancelExaminationLoadingState());
    try {
      var res = await AppointmentRepository.cancelExamination(
          appointmentId: appointmentId.carExaminationId,
          query: {'cancel_reason': ''});
      if (res['status']) {
        currenAppointment = null;
         AppUtil.appAlert(context,
            contentType: ContentType.failure, msg: res['message']);
        await getAllAppointments(context);
        emit(CancelExaminationLoadedState());
      } else {
        AppUtil.appAlert(context,
            contentType: ContentType.failure, msg: res['message']);
        emit(CancelExaminationErrorState());
      }
    } catch (error) {
      emit(CancelExaminationErrorState());
    }
  }

  //=======================appointment cancel=======================
  final appointmentCancelResoneController = TextEditingController();
  Future<void> cancelAppointment(
    AppointmentDataModel appointment,
    context,
  ) async {
    emit(CancelAppointmentLoadingState());
    try {
      var res = await AppointmentRepository.cancelAppointment(
          appointmentId: appointment.carExaminationId,
          query: {
            'cancel_reason': selectedCancelReson == null
                ? appointment.buyerAttend == null
                    ? 'عدم حضور المشترى'
                    : 'عدم حضور البائع'
                : appointmentCancelResoneController.text,
            'cancel_by': selectedCancelReson == 'البائع'
                ? 'seller'
                : selectedCancelReson == 'المشترى'
                    ? 'buyer'
                    : appointment.buyerAttend == null
                        ? 'buyer'
                        : 'seller'
          });
      if (res['status']) {
        if(appointmentCancelResoneController.text.isNotEmpty){
        EarbunNavigatorKeys.appointmentsNavigatorKey.currentState!.maybePop();
        }
        currenAppointment = null;
        selectedCancelReson = null;
        appointmentCancelResoneController.text = '';
        await getAllAppointments(context);
        emit(CancelAppointmentLoadedState());
      } else {
        AppUtil.appAlert(context,
            contentType: ContentType.failure, msg: res['message']);
        emit(CancelAppointmentErrorState());
      }
    } catch (error) {
      emit(CancelAppointmentErrorState());
    }
  }

  int page = 1;
  int canceledPage = 1;
  void onQRViewCreated() {
    EarbunNavigatorKeys.appointmentsNavigatorKey.currentState!
        .pushNamed(Routes.showAppointment);
    changeIsScan(false);
  }

//============================get canceled appointment========================
  AllAppointmentModel? canceledAppointmentModel;
  List<AppointmentDataModel> canceledappointmentList = [];
  ScrollController? scrollController ;

  Future<void> getCanceledAppointments(context,
      {page = 1, isRefresh = false}) async {
    if (page == 1 && !isRefresh) {
      canceledappointmentList = [];
      emit(GetCanceledAppointmentsLoadingState());
    } else if (isRefresh) {
      canceledappointmentList = [];

      emit(GetRefreshCanceledAppointmentsLoadingState());
    } else {
      emit(GetPaginatedCanceledAppointmentsLoadingState());
    }
    try {
      var res = await AppointmentRepository.getCanceledAppointments(
          page: canceledPage);
      canceledAppointmentModel = AllAppointmentModel.fromJson(res);

      if (canceledAppointmentModel!.status!) {
        canceledappointmentList.addAll(canceledAppointmentModel?.data ?? []);

        emit(GetCanceledAppointmentsLoadedState());
      } else {
        AppUtil.appAlert(context,
            contentType: ContentType.failure, msg: 'حدث خطا ');
        emit(GetCanceledAppointmentsErrorState());
      }
      isRefresh = false;
    } catch (error) {
      emit(GetCanceledAppointmentsErrorState());
    }
  }
}
