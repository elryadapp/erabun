
class InsideCarReport {
  bool? status;
  InsideCarExaminationData? data;

  InsideCarReport({this.status, this.data});

  InsideCarReport.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = json["data"] == null
        ? null
        : InsideCarExaminationData.fromJson(
            json["data"],
          );
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

class InsideCarExaminationData {
  String? token;
  InsideCarExaminationDetailedData? data;

  InsideCarExaminationData({this.token, this.data});

  InsideCarExaminationData.fromJson(Map<String, dynamic> json) {
    token = json["token"];
    data = json["data"] == null
        ? null
        : InsideCarExaminationDetailedData.fromJson(json["data"]);
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

class InsideCarExaminationDetailedData {
  int? id;
  int? carExaminationId;
  String? carAdName;
  String? seats;
  String? decore;
  String? airbags;
  String? floorMattresses;
  String? airConditioner;
  String? screen;
  String? windows;
  List? seatsImage;
  List? decoreImage;
  List? airbagsImage;
  List? floorMattressesImage;
  List? airConditionerImage;
  List? screenImage;
  List? windowsImage;
  String? note;
  List? noteImage;

  InsideCarExaminationDetailedData(
      {this.id,
      this.carExaminationId,
      this.carAdName,
      this.seats,
      this.decore,
      this.airbags,
      this.floorMattresses,
      this.airConditioner,
      this.screen,
      this.windows,
      this.seatsImage,
      this.decoreImage,
      this.airbagsImage,
      this.floorMattressesImage,
      this.airConditionerImage,
      this.screenImage,
      this.windowsImage,
      this.note,
      this.noteImage});

  InsideCarExaminationDetailedData.fromJson(
    Map<String, dynamic> json, ) {
    id = json["id"];
    carExaminationId = json["car_examination_id"];
    carAdName = json["car_ad_name"];
    seats = json["seats"];
    decore = json["decore"];
    airbags = json["airbags"];
    floorMattresses = json["floor_mattresses"];
    airConditioner = json["air_conditioner"];
    screen = json["screen"];
    windows = json["windows"];
    
    seatsImage = json["seats_image"] == null
        ? null
        : List.from(json["seats_image"]);
    decoreImage = json["decore_image"] == null
        ? null
        : List.from(json["decore_image"]);
    airbagsImage = json["airbags_image"] == null
        ? null
        : List.from(json["airbags_image"]);
    floorMattressesImage = json["floor_mattresses_image"] == null
        ? null
        : List.from(json["floor_mattresses_image"]);
    airConditionerImage = json["air_conditioner_image"] == null
        ? null
        : List.from(json["air_conditioner_image"]);
    screenImage = json["screen_image"] == null
        ? null
        : List.from(json["screen_image"]);
    windowsImage = json["windows_image"] == null
        ? null
        : List.from(json["windows_image"]);
    note = json["note"];
    noteImage =
        json["note_image"] == null ? null : List.from(json["note_image"]);
  }

  Map<String, dynamic> toJson({
    seatsImageLen,
    decoreImageLen,
    airbagsImageLen,
    floorMattressesImageLen,
    airConditionerImageLen,
    screenImageLen,
    windowsImageLen,
    noteImageLen

  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["car_examination_id"] = carExaminationId;
    data["car_ad_name"] = carAdName;
    data["seats"] = seats;
    data["decore"] = decore;
    data["airbags"] = airbags;
    data["floor_mattresses"] = floorMattresses;
    data["air_conditioner"] = airConditioner;
    data["screen"] = screen;
    data["windows"] = windows;
   
    return data;
  }
}
