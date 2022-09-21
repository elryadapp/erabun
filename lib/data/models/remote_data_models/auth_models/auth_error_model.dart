
class AuthErrorModel {
    bool? status;
    String? message;
    Errors? errors;

    AuthErrorModel({this.status, this.message, this.errors});

    AuthErrorModel.fromJson(Map<String, dynamic> json) {
        status = json["status"];
        message = json["message"];
        errors = json["errors"] == null ? null : Errors.fromJson(json["errors"]);
    }

    Map<String, dynamic> toJson() {
        final  data =<String, dynamic>{};
        data["status"] = status;
        data["message"] = message;
        if(errors != null){
            data["errors"] = errors?.toJson();
        }
        return data;
    }
}

class Errors {
    List<String>? name;
    List<String>? phone;
    List<String>? password;
    List<String>? examinationCenterOwnerName;
    List<String>? cityId;
    List<String>? neighborhood;
    List<String>? street;
    List<String>? commercialRegisterNumber;
    List<String>? image;
    List<String>? latitude;
    List<String>? longitude;

    Errors({this.name, this.phone, this.password, this.examinationCenterOwnerName, this.cityId, this.neighborhood, this.street, this.commercialRegisterNumber, this.image, this.latitude, this.longitude});

    Errors.fromJson(Map<String, dynamic> json) {
        name = json["name"]==null ? null : List<String>.from(json["name"]);
        phone = json["phone"]==null ? null : List<String>.from(json["phone"]);
        password = json["password"]==null ? null : List<String>.from(json["password"]);
        examinationCenterOwnerName = json["examination_center_owner_name"]==null ? null : List<String>.from(json["examination_center_owner_name"]);
        cityId = json["city_id"]==null ? null : List<String>.from(json["city_id"]);
        neighborhood = json["neighborhood"]==null ? null : List<String>.from(json["neighborhood"]);
        street = json["street"]==null ? null : List<String>.from(json["street"]);
        commercialRegisterNumber = json["commercial_register_number"]==null ? null : List<String>.from(json["commercial_register_number"]);
        image = json["image"]==null ? null : List<String>.from(json["image"]);
        latitude = json["latitude"]==null ? null : List<String>.from(json["latitude"]);
        longitude = json["longitude"]==null ? null : List<String>.from(json["longitude"]);
    }

    Map<String, dynamic> toJson() {
        final  data =<String, dynamic>{};
        if(name != null){
            data["name"] = name;
        }
        if(phone != null){
            data["phone"] = phone;
        }
        if(password != null){
            data["password"] = password;
        }
        if(examinationCenterOwnerName != null){
            data["examination_center_owner_name"] = examinationCenterOwnerName;}
        if(cityId != null){
            data["city_id"] = cityId;}
        if(neighborhood != null){
            data["neighborhood"] = neighborhood;
        }
        if(street != null){
            data["street"] = street;
        }
        if(commercialRegisterNumber != null)
        {
            data["commercial_register_number"] = commercialRegisterNumber;}
        if(image != null){
            data["image"] = image;}
        if(latitude != null){
            data["latitude"] = latitude;
        }
        if(longitude != null){
            data["longitude"] = longitude;}
        return data;
    }
}