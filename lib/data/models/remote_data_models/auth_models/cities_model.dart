
class CitiesModel {
    List<CityModel>? data;
    bool? status;

    CitiesModel({this.data, this.status});

    CitiesModel.fromJson(Map<String, dynamic> json) {
        data = json["data"]==null ? null : (json["data"] as List).map((e)=>CityModel.fromJson(e)).toList();
        status = json["status"];
    }

    Map<String, dynamic> toJson() {
        final  data = <String, dynamic>{};
        if(this.data != null){
            data["data"] = this.data?.map((e)=>e.toJson()).toList();
        }
        data["status"] = status;
        return data;
    }
}

class CityModel {
    int? id;
    String? name;

    CityModel({this.id, this.name});

    CityModel.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        name = json["name"];
    }

    Map<String, dynamic> toJson() {
        final data = <String, dynamic>{};
        data["id"] = id;
        data["name"] = name;
        return data;
    }
}