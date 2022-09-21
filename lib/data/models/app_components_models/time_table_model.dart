
class TimeTableModel {
    List<TimeDataModel>? data;
     bool? status;
    String? message;


    TimeTableModel({this.data, this.status, this.message,});

    TimeTableModel.fromJson(Map<String, dynamic> json) {
       status = json["status"];
        message = json["message"];
        data = json["data"]==null ? null : (json["data"] as List).map((e)=>TimeDataModel.fromJson(e)).toList();
       
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
            data["status"] = status;
        data["message"] = message;
        if(this.data != null){
            data["data"] = this.data?.map((e)=>e.toJson()).toList();
        }
       
        return data;
    }
}

class TimeDataModel {
    int? dayId;
    String? day;
    String? from;
    String? to;

    TimeDataModel({this.dayId, this.day,this.from, this.to});

    TimeDataModel.fromJson(Map<String, dynamic> json) {
        dayId = json["day_id"];
        from = json["from"];
        to = json["to"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["day_id"] = dayId;
        data["from"] = from;
        data["to"] = to;
        return data;
    }
}