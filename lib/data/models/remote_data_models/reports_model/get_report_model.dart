
class GetReportModel {
  bool? status;
  AllExaminationReportData? data;

  GetReportModel({this.status, this.data});

  GetReportModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = json["data"] == null
        ? null
        : AllExaminationReportData.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    if (this.data != null) {
      data["data"] = this.data?.toJson();
    }
    return data;
  }
}

class AllExaminationReportData {
  String? token;
  ReportData? data;

  AllExaminationReportData({this.token, this.data});

  AllExaminationReportData.fromJson(Map<String, dynamic> json) {
    token = json["token"];
    data = json["data"] == null ? null : ReportData.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    if (this.data != null) {
      data["data"] = this.data?.toJson();
    }
    return data;
  }
}

class ReportData {
  int? carExaminationId;
  String? carAdName;
  bool? canFinishReport;
  bool? reportIsFinish;
  List? pdfReport;
  List? otherReport;

  String? carBodyNumberImage;
  String? carBodyNumber;

  int? reportFlag;
  ReportData({
    this.carExaminationId,
    this.otherReport,
    this.reportFlag,
    this.pdfReport,
    this.carAdName,
    this.canFinishReport,
    this.reportIsFinish,
    this.carBodyNumberImage,
    this.carBodyNumber,
  });

  ReportData.fromJson(Map<String, dynamic> json) {
    carExaminationId = json["car_examination_id"];
    pdfReport = json["pdf_report"] == null
        ? null
        : (json["pdf_report"] as List).map((e) => e).toList();
    otherReport = json["other_report"] == null
        ? null
        : (json["other_report"] as List).map((e) => e).toList();
    reportFlag = json['report_flag'];
    carAdName = json["car_ad_name"];
    canFinishReport = json["canFinishReport"];
    reportIsFinish = json["reportIsFinish"];
    carBodyNumberImage = json["car_body_number_image"];
    carBodyNumber = json["car_body_number"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["car_examination_id"] = carExaminationId;
    if (data["pdf_report"] != null) {
      for(int i=0;data["pdf_report"].length;i++){
      pdfReport?.add(data['pdf_report'][i])  ;

      }
    }
    if (data["other_report"] != null) {
      for(int i=0;data['other_report'].length;i++){
      otherReport?.add( data['other_report'][i] );

      }
    }
    data["car_ad_name"] = carAdName;
    data["canFinishReport"] = canFinishReport;
    data["reportIsFinish"] = reportIsFinish;
    data["car_body_number_image"] = carBodyNumberImage;
    data["car_body_number"] = carBodyNumber;

    return data;
  }
}
