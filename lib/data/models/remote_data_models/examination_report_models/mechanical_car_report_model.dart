

class MechanicalCarReport {
    bool? status;
    MechanicalCarReportData? data;

    MechanicalCarReport({this.status, this.data});

    MechanicalCarReport.fromJson(Map<String, dynamic> json) {
        status = json["status"];
        data = json["data"] == null ? null : MechanicalCarReportData.fromJson(json["data"]);
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

class MechanicalCarReportData {
    String? token;
    MechanicalCarDetailedReportData1? data;

    MechanicalCarReportData({this.token, this.data});

    MechanicalCarReportData.fromJson(Map<String, dynamic> json) {
        token = json["token"];
        data = json["data"] == null ? null : MechanicalCarDetailedReportData1.fromJson(json["data"]);
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

class MechanicalCarDetailedReportData1 {
    int? id;
    int? carExaminationId;
    String? carAdName;
    String? transmissionGear;
    String? engine;
    String? brakes;
    String? engineCoolingSystem;
    String? fluidsOilsLeakage;
    String? airConditionSystem;
    String? computerSystemCheck;
    List? transmissionGearImage;
    List? engineImage;
    List? brakesImage;
    List? engineCoolingSystemImage;
    List? fluidsOilsLeakageImage;
    List? airConditionSystemImage;
    List? computerSystemCheckImage;
    List? noteImage;

    String? note;

    MechanicalCarDetailedReportData1({this.id, this.carExaminationId, this.carAdName, this.transmissionGear, this.engine, this.brakes, this.engineCoolingSystem, this.fluidsOilsLeakage, this.airConditionSystem, this.computerSystemCheck, this.transmissionGearImage, this.engineImage, this.brakesImage, this.engineCoolingSystemImage, this.fluidsOilsLeakageImage, this.airConditionSystemImage, this.computerSystemCheckImage, this.note, this.noteImage});

    MechanicalCarDetailedReportData1.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        carExaminationId = json["car_examination_id"];
        carAdName = json["car_ad_name"];
        transmissionGear = json["transmission_gear"];
        engine = json["engine"];
        brakes = json["brakes"];
        engineCoolingSystem = json["engine_cooling_system"];
        fluidsOilsLeakage = json["fluids_oils_leakage"];
        airConditionSystem = json["air_condition_system"];
        computerSystemCheck = json["computer_system_check"];
        transmissionGearImage = json["transmission_gear_image"]==null ? null : List.from(json["transmission_gear_image"]);
        engineImage = json["engine_image"]==null ? null : List.from(json["engine_image"]);
        brakesImage = json["brakes_image"]==null ? null : List.from(json["brakes_image"]);
        engineCoolingSystemImage = json["engine_cooling_system_image"]==null ? null : List.from(json["engine_cooling_system_image"]);
        fluidsOilsLeakageImage = json["fluids_oils_leakage_image"]==null ? null : List.from(json["fluids_oils_leakage_image"]);
        airConditionSystemImage = json["air_condition_system_image"]==null ? null : List.from(json["air_condition_system_image"]);
        computerSystemCheckImage = json["computer_system_check_image"]==null ? null : List.from(json["computer_system_check_image"]);
        note = json["note"];
        noteImage = json["note_image"]==null ? null : List.from(json["note_image"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["id"] = id;
        data["car_examination_id"] = carExaminationId;
        data["car_ad_name"] = carAdName;
        data["transmission_gear"] = transmissionGear;
        data["engine"] = engine;
        data["brakes"] = brakes;
        data["engine_cooling_system"] = engineCoolingSystem;
        data["fluids_oils_leakage"] = fluidsOilsLeakage;
        data["air_condition_system"] = airConditionSystem;
        data["computer_system_check"] = computerSystemCheck;
        if(transmissionGearImage != null){
            data["transmission_gear_image"] = transmissionGearImage;
        }
        if(engineImage != null){
            data["engine_image"] = engineImage;
        }
        if(brakesImage != null){
            data["brakes_image"] = brakesImage;
        }
        if(engineCoolingSystemImage != null){
            data["engine_cooling_system_image"] = engineCoolingSystemImage;
        }
        if(fluidsOilsLeakageImage != null){
            data["fluids_oils_leakage_image"] = fluidsOilsLeakageImage;
        }
        if(airConditionSystemImage != null){
            data["air_condition_system_image"] = airConditionSystemImage;
        }
        if(computerSystemCheckImage != null)
        {
            data["computer_system_check_image"] = computerSystemCheckImage;
        }
        data["note"] = note;
        if(noteImage != null){
            data["note_image"] = noteImage;}
        return data;
    }
}