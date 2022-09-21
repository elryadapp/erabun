
import 'package:arboon/data/models/remote_data_models/examination_report_models/inside_car_examination_model.dart';
import 'package:arboon/data/models/remote_data_models/examination_report_models/mechanical_car_report_model.dart';
import 'package:arboon/data/models/remote_data_models/examination_report_models/outside_car_examination_model.dart';

class GetReportModel {
    bool? status;
    AllExaminationReportData? data;

    GetReportModel({this.status, this.data});

    GetReportModel.fromJson(Map<String, dynamic> json) {
        status = json["status"];
        data = json["data"] == null ? null : AllExaminationReportData.fromJson(json["data"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["status"] = status;
        if(this.data != null){
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
        if(this.data != null){
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
    String? pdfReport;
    String? carBodyNumberImage;
    String? carBodyNumber;
    InsideCarExaminationDetailedData?   examinationInsideCarReport;
    OutsideCarDetailedReportData?       examinationOutsideCarReport;
    MechanicalCarDetailedReportData1?   examinationMechnicalReport;

    ReportData({this.carExaminationId,this.pdfReport, this.carAdName, this.canFinishReport, this.reportIsFinish, this.carBodyNumberImage, this.carBodyNumber, this.examinationInsideCarReport, this.examinationOutsideCarReport, this.examinationMechnicalReport});

    ReportData.fromJson(Map<String, dynamic> json) {
        carExaminationId = json["car_examination_id"];
        pdfReport=json['pdf_report'];
        carAdName = json["car_ad_name"];
        canFinishReport = json["canFinishReport"];
        reportIsFinish = json["reportIsFinish"];
        carBodyNumberImage = json["car_body_number_image"];
        carBodyNumber = json["car_body_number"];
        examinationInsideCarReport = json["examinationInsideCarReport"] == null ? null : InsideCarExaminationDetailedData.fromJson(json["examinationInsideCarReport"]);
        examinationOutsideCarReport = json["examinationOutsideCarReport"] == null ? null : OutsideCarDetailedReportData.fromJson(json["examinationOutsideCarReport"]);
        examinationMechnicalReport = json["examinationMechnicalReport"] == null ? null : MechanicalCarDetailedReportData1.fromJson(json["examinationMechnicalReport"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["car_examination_id"] = carExaminationId;
        data['pdf_report']=pdfReport;
        data["car_ad_name"] = carAdName;
        data["canFinishReport"] = canFinishReport;
        data["reportIsFinish"] = reportIsFinish;
        data["car_body_number_image"] = carBodyNumberImage;
        data["car_body_number"] = carBodyNumber;
        if(examinationInsideCarReport != null){
            data["examinationInsideCarReport"] = examinationInsideCarReport?.toJson();
        }
        if(examinationOutsideCarReport != null)
        {
            data["examinationOutsideCarReport"] = examinationOutsideCarReport?.toJson();
        }
        if(examinationMechnicalReport != null){
            data["examinationMechnicalReport"] = examinationMechnicalReport?.toJson();
        }
        return data;
    }
}

