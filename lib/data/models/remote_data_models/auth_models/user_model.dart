
class UserDate {
    UserData? userData;

    UserDate({this.userData});

    UserDate.fromJson(Map<String, dynamic> json) {
        userData = json["user_data"] == null ? null : UserData.fromJson(json["user_data"]);
    }

    Map<String, dynamic> toJson() {
        final  data = <String, dynamic>{};
        if(userData != null){
            data["user_data"] = userData?.toJson();
        }
        return data;
    }
}

class UserData {
    String? name;
    String? phone;
    String? email;
    String? password;
    String? passwordConfirmation;
    String? examinationCenterOwnerName;
    int? cityId;
    String? neighborhood;
    String? street;
    String? commercialRegisterNumber;
    double? latitude;
    double? longitude;
    String? image;

    UserData({this.name, this.phone, this.email, this.password, this.passwordConfirmation, this.examinationCenterOwnerName, this.cityId, this.neighborhood, this.street, this.commercialRegisterNumber, this.latitude, this.longitude, this.image, });

    UserData.fromJson(Map<String, dynamic> json) {
        name = json["name"];
        phone = json["phone"];
        email = json["email"];
        password = json["password"];
        passwordConfirmation = json["password_confirmation"];
        examinationCenterOwnerName = json["examination_center_owner_name"];
        cityId = json["city_id"];
        neighborhood = json["neighborhood"];
        street = json["street"];
        commercialRegisterNumber = json["commercial_register_number"];
        latitude = json["latitude"];
        longitude = json["longitude"];
        image = json["image"];
    }

    Map<String, dynamic> toJson() {
        final  data = <String, dynamic>{};
        data["name"] = name;
        data["phone"] = phone;
        data["email"] = email;
        data["password"] = password;
        data["password_confirmation"] = passwordConfirmation;
        data["examination_center_owner_name"] = examinationCenterOwnerName;
        data["city_id"] = cityId;
        data["neighborhood"] = neighborhood;
        data["street"] = street;
        data["commercial_register_number"] = commercialRegisterNumber;
        data["latitude"] = latitude;
        data["longitude"] = longitude;
        data["image"] = image;
        return data;
    }
}