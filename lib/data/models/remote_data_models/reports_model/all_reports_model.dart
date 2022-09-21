
import 'package:arboon/data/models/remote_data_models/appointment_models/all_appointment_model.dart';

class AllReportsModel {
    List<AppointmentDataModel>? data;
    ReportsLinks? links;
    ReportsMeta? meta;
    bool? status;
    String? token;

    AllReportsModel({this.data, this.links, this.meta, this.status, this.token});

    AllReportsModel.fromJson(Map<String, dynamic> json) {
        data = json["data"]==null ? null : (json["data"] as List).map((e)=>AppointmentDataModel.fromJson(e)).toList();
        links = json["links"] == null ? null : ReportsLinks.fromJson(json["links"]);
        meta = json["meta"] == null ? null : ReportsMeta.fromJson(json["meta"]);
        status = json["status"];
        token = json["token"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        if(this.data != null){
            data["data"] = this.data?.map((e)=>e.toJson()).toList();
        }
        if(links != null){
            data["links"] = links?.toJson();
        }
        if(meta != null)
        {
            data["meta"] = meta?.toJson();
        }
        data["status"] = status;
        data["token"] = token;
        return data;
    }
}

class ReportsMeta {
    int? currentPage;
    int? from;
    int? lastPage;
    List<ReportsLinks1>? links;
    String? path;
    int? perPage;
    int? to;
    int? total;

    ReportsMeta({this.currentPage, this.from, this.lastPage, this.links, this.path, this.perPage, this.to, this.total});

    ReportsMeta.fromJson(Map<String, dynamic> json) {
        currentPage = json["current_page"];
        from = json["from"];
        lastPage = json["last_page"];
        links = json["links"]==null ? null : (json["links"] as List).map((e)=>ReportsLinks1.fromJson(e)).toList();
        path = json["path"];
        perPage = json["per_page"];
        to = json["to"];
        total = json["total"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["current_page"] = currentPage;
        data["from"] = from;
        data["last_page"] = lastPage;
        if(links != null){
            data["links"] = links?.map((e)=>e.toJson()).toList();
        }
        data["path"] = path;
        data["per_page"] = perPage;
        data["to"] = to;
        data["total"] = total;
        return data;
    }
}

class ReportsLinks1 {
    dynamic url;
    String? label;
    bool? active;

    ReportsLinks1({this.url, this.label, this.active});

    ReportsLinks1.fromJson(Map<String, dynamic> json) {
        url = json["url"];
        label = json["label"];
        active = json["active"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data =<String, dynamic>{};
        data["url"] = url;
        data["label"] = label;
        data["active"] = active;
        return data;
    }
}

class ReportsLinks {
    String? first;
    String? last;
    dynamic prev;
    dynamic next;

    ReportsLinks({this.first, this.last, this.prev, this.next});

    ReportsLinks.fromJson(Map<String, dynamic> json) {
        first = json["first"];
        last = json["last"];
        prev = json["prev"];
        next = json["next"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["first"] = first;
        data["last"] = last;
        data["prev"] = prev;
        data["next"] = next;
        return data;
    }
}

// class ReportsDataModel {
//     int? carExaminationId;
//     String? sellerName;
//     String? buyerName;
//     String? carName;
//     int? carAdId;
//     String? examinationDate;
//     String? examinationTime;
//     int? buyerAttend;
//     String? buyerAttendenceTime;
//     String? buyerAttendenceDate;
//     int? sellerAttend;
//     String? sellerAttendenceTime;
//     String? sellerAttendenceDate;
//     String? status;

//     ReportsDataModel({this.carExaminationId, this.sellerName, this.buyerName, this.carName, this.carAdId, this.examinationDate, this.examinationTime, this.buyerAttend, this.buyerAttendenceTime, this.buyerAttendenceDate, this.sellerAttend, this.sellerAttendenceTime, this.sellerAttendenceDate, this.status});

//     ReportsDataModel.fromJson(Map<String, dynamic> json) {
//         carExaminationId = json["car_examination_id"];
//         sellerName = json["seller_name"];
//         buyerName = json["buyer_name"];
//         carName = json["car_name"];
//         carAdId = json["car_ad_id"];
//         examinationDate = json["examination_date"];
//         examinationTime = json["examination_time"];
//         buyerAttend = json["buyer_attend"];
//         buyerAttendenceTime = json["buyer_attendence_time"];
//         buyerAttendenceDate = json["buyer_attendence_date"];
//         sellerAttend = json["seller_attend"];
//         sellerAttendenceTime = json["seller_attendence_time"];
//         sellerAttendenceDate = json["seller_attendence_date"];
//         status = json["status"];
//     }

//     Map<String, dynamic> toJson() {
//         final Map<String, dynamic> data = <String, dynamic>{};
//         data["car_examination_id"] = carExaminationId;
//         data["seller_name"] = sellerName;
//         data["buyer_name"] = buyerName;
//         data["car_name"] = carName;
//         data["car_ad_id"] = carAdId;
//         data["examination_date"] = examinationDate;
//         data["examination_time"] = examinationTime;
//         data["buyer_attend"] = buyerAttend;
//         data["buyer_attendence_time"] = buyerAttendenceTime;
//         data["buyer_attendence_date"] = buyerAttendenceDate;
//         data["seller_attend"] = sellerAttend;
//         data["seller_attendence_time"] = sellerAttendenceTime;
//         data["seller_attendence_date"] = sellerAttendenceDate;
//         data["status"] = status;
//         return data;
//     }
// }