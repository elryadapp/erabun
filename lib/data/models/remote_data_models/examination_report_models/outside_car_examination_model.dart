

class OutsideCarReport {
    bool? status;
    OutsideCarReportData? data;

    OutsideCarReport({this.status, this.data});

    OutsideCarReport.fromJson(Map<String, dynamic> json) {
        status = json["status"];
        data = json["data"] == null ? null : OutsideCarReportData.fromJson(json["data"]);
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

class OutsideCarReportData {
    String? token;
    OutsideCarDetailedReportData? data;

    OutsideCarReportData({this.token, this.data});

    OutsideCarReportData.fromJson(Map<String, dynamic> json) {
        token = json["token"];
        data = json["data"] == null ? null : OutsideCarDetailedReportData.fromJson(json["data"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data =<String, dynamic>{};
        data["token"] = token;
        if(this.data != null){
            data["data"] = this.data?.toJson();
        }
        return data;
    }
}

class OutsideCarDetailedReportData {
    int? id;
    int? carExaminationId;
    String? carAdName;
    String? body;
    String? lights;
    String? tires;
    String? carWipers;
    String? scratches;
    List? bodyImage;
    List? lightsImage;
    List? tiresImage;
    List? carWipersImage;
    List? scratchesImage;
    List? noteImage;

    String? note;

    OutsideCarDetailedReportData({this.id, this.carExaminationId, this.carAdName, this.body, this.lights, this.tires, this.carWipers, this.scratches, this.bodyImage, this.lightsImage, this.tiresImage, this.carWipersImage, this.scratchesImage, this.note, this.noteImage});

    OutsideCarDetailedReportData.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        carExaminationId = json["car_examination_id"];
        carAdName = json["car_ad_name"];
        body = json["body"];
        lights = json["lights"];
        tires = json["tires"];
        carWipers = json["car_wipers"];
        scratches = json["scratches"];
        bodyImage = json["body_image"]==null ? null : List.from(json["body_image"]);
        lightsImage = json["lights_image"]==null ? null : List.from(json["lights_image"]);
        tiresImage = json["tires_image"]==null ? null : List.from(json["tires_image"]);
        carWipersImage = json["car_wipers_image"]==null ? null : List.from(json["car_wipers_image"]);
        scratchesImage = json["scratches_image"]==null ? null : List.from(json["scratches_image"]);
        note = json["note"];
        noteImage = json["note_image"]==null ? null : List.from(json["note_image"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["id"] = id;
        data["car_examination_id"] = carExaminationId;
        data["car_ad_name"] = carAdName;
        data["body"] = body;
        data["lights"] = lights;
        data["tires"] = tires;
        data["car_wipers"] = carWipers;
        data["scratches"] = scratches;
        if(bodyImage != null){
            data["body_image"] = bodyImage;
        }
        if(lightsImage != null)
        {
            data["lights_image"] = lightsImage;
        }
        if(tiresImage != null)
        {
            data["tires_image"] = tiresImage;
        }
        if(carWipersImage != null){
            data["car_wipers_image"] = carWipersImage;
        }
        if(scratchesImage != null){
            data["scratches_image"] = scratchesImage;
        }
        data["note"] = note;
        if(noteImage != null){
            data["note_image"] = noteImage;
        }
        return data;
    }
}