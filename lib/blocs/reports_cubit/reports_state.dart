part of 'reports_cubit.dart';

@immutable
abstract class ReportsState {}

class ReportsInitial extends ReportsState {}
class ChangeCurrentReportIndexState extends ReportsState {}
//======================get all appointment states================
class GetPaginatedReportsLoadingState extends ReportsState {}

class GetAllReportsLoadingState extends ReportsState {}
class GetAllReportsLoadedState  extends ReportsState {}
class GetAllReportsErrorState   extends ReportsState {}

