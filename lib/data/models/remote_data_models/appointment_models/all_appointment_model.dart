
class AllAppointmentModel {
    List<AppointmentDataModel>? data;
    AppointmentLinks? links;
    AppointmentMeta? meta;
    bool? status;
    String? token;

    AllAppointmentModel({this.data, this.links, this.meta, this.status, this.token});

    AllAppointmentModel.fromJson(Map<String, dynamic> json) {
        data = json["data"]==null ? null : (json["data"] as List).map((e)=>AppointmentDataModel.fromJson(e)).toList();
        links = json["links"] == null ? null : AppointmentLinks.fromJson(json["links"]);
        meta = json["meta"] == null ? null : AppointmentMeta.fromJson(json["meta"]);
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

class AppointmentMeta {
    int? currentPage;
    int? from;
    int? lastPage;
    List<AppointmentLinks1>? links;
    String? path;
    int? perPage;
    int? to;
    int? total;

    AppointmentMeta({this.currentPage, this.from, this.lastPage, this.links, this.path, this.perPage, this.to, this.total});

    AppointmentMeta.fromJson(Map<String, dynamic> json) {
        currentPage = json["current_page"];
        from = json["from"];
        lastPage = json["last_page"];
        links = json["links"]==null ? null : (json["links"] as List).map((e)=>AppointmentLinks1.fromJson(e)).toList();
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

class AppointmentLinks1 {
    dynamic url;
    String? label;
    bool? active;

    AppointmentLinks1({this.url, this.label, this.active});

    AppointmentLinks1.fromJson(Map<String, dynamic> json) {
        url = json["url"];
        label = json["label"];
        active = json["active"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["url"] = url;
        data["label"] = label;
        data["active"] = active;
        return data;
    }
}

class AppointmentLinks {
    String? first;
    String? last;
    dynamic prev;
    dynamic next;

    AppointmentLinks({this.first, this.last, this.prev, this.next});

    AppointmentLinks.fromJson(Map<String, dynamic> json) {
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

class AppointmentDataModel {
    dynamic carExaminationId;
    String? sellerName;
    String? buyerName;
    String? carName;
    int? carAdId;
    String? examinationDate;
    String? examinationTime;
    String? status;
    dynamic buyerAttend;
    dynamic buyerAttendenceTime;
    dynamic buyerAttendenceDate;
    dynamic sellerAttend;
    dynamic sellerAttendenceTime;
    dynamic sellerAttendenceDate;
    int? carImage;

    AppointmentDataModel({this.carExaminationId,this.carImage ,this.sellerName, this.buyerName, this.carName, this.carAdId, this.examinationDate, this.examinationTime, this.status, this.buyerAttend, this.buyerAttendenceTime, this.buyerAttendenceDate, this.sellerAttend, this.sellerAttendenceTime, this.sellerAttendenceDate});

    AppointmentDataModel.fromJson(Map<String, dynamic> json) {
        carExaminationId = json["car_examination_id"];
        sellerName = json["seller_name"];
        carImage=json['carImage'];
        buyerName = json["buyer_name"];
        carName = json["car_name"];
        carAdId = json["car_ad_id"];
        examinationDate = json["examination_date"];
        examinationTime = json["examination_time"];
        status = json["status"];
        buyerAttend = json["buyer_attend"];
        buyerAttendenceTime = json["buyer_attendence_time"];
        buyerAttendenceDate = json["buyer_attendence_date"];
        sellerAttend = json["seller_attend"];
        sellerAttendenceTime = json["seller_attendence_time"];
        sellerAttendenceDate = json["seller_attendence_date"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["car_examination_id"] = carExaminationId;
        data['carImage']=carImage;
        data["seller_name"] = sellerName;
        data["buyer_name"] = buyerName;
        data["car_name"] = carName;
        data["car_ad_id"] = carAdId;
        data["examination_date"] = examinationDate;
        data["examination_time"] = examinationTime;
        data["status"] = status;
        data["buyer_attend"] = buyerAttend;
        data["buyer_attendence_time"] = buyerAttendenceTime;
        data["buyer_attendence_date"] = buyerAttendenceDate;
        data["seller_attend"] = sellerAttend;
        data["seller_attendence_time"] = sellerAttendenceTime;
        data["seller_attendence_date"] = sellerAttendenceDate;
        return data;
    }
}