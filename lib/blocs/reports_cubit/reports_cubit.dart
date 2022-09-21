import 'package:arboon/core/utils/app_utilities.dart';
import 'package:arboon/data/models/app_components_models/content_type.dart';
import 'package:arboon/data/models/remote_data_models/appointment_models/all_appointment_model.dart';
import 'package:arboon/data/models/remote_data_models/reports_model/all_reports_model.dart';
import 'package:arboon/data/repos/reports_repo/reports_repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit() : super(ReportsInitial());
  static ReportsCubit get(context) => BlocProvider.of(context);
int page=1;
  ScrollController? scrollController ;

  //============================get all appointment========================
  AllReportsModel? allReportsModel;
AppointmentDataModel? currentReport;
  List<AppointmentDataModel> reportsList = [];
  Future<void> getAllReports(context, {page = 1}) async {
    if (page == 1) {
     reportsList = [];
      emit(GetAllReportsLoadingState());
    } else {
      emit(GetPaginatedReportsLoadingState());
    }
    try {
      var res = await ReportsRepositories.getAllReports(page: page);
      allReportsModel = AllReportsModel.fromJson(res);

      if (allReportsModel!.status!) {
       
        reportsList.addAll(allReportsModel?.data??[]);
        
        emit(GetAllReportsLoadedState());
      } else {
        AppUtil.appAlert(context,
            contentType: ContentType.failure, msg: 'حدث خطا ');
        emit(GetAllReportsErrorState());
      }
    } catch (error) {
      emit(GetAllReportsErrorState());
    }
  }


 

  
}

