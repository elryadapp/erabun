
class LoginResponseModel {
    bool? status;
    String? message;
    Response? data;

    LoginResponseModel({this.status, this.message, this.data});

    LoginResponseModel.fromJson(Map<String, dynamic> json) {
        status = json["status"];
        message = json["message"];
        data = json["data"] == null ? null : Response.fromJson(json["data"]);
    }

    Map<String, dynamic> toJson() {
        final  data = <String, dynamic>{};
        data["status"] = status;
        data["message"] = message;
        if(this.data != null){
            data["data"] = this.data?.toJson();
        }
        return data;
    }
}

class Response {
    String? token;
    UserLoginResData? data;

    Response({this.token, this.data});

    Response.fromJson(Map<String, dynamic> json) {
        token = json["token"];
        data = json["data"] == null ? null : UserLoginResData.fromJson(json["data"]);
    }

    Map<String, dynamic> toJson() {
        final  data = <String, dynamic>{};
        data["token"] = token;
        if(this.data != null){
            data["data"] = this.data?.toJson();
        }
        return data;
    }
}

class UserLoginResData {
    int? id;
    String? name;
    String? email;
    String? phone;
    String? examinationCenterOwnerName;
    int? cityId;
    String? neighborhood;
    String? street;
    String? image;
    String? examinationCenterState;
    String? commercialRegisterNumber;
    String? longitude;
    String? latitude;
    int? examinationCenterActive;
    dynamic rate;
    int? reviewsNum;
    List<dynamic>? reviews;
    dynamic refuessReason;
    int? isVerified;
    int? twoFactorSecretSendNum;
    int? twoFactorSecretTryNum;

    UserLoginResData({this.id, this.name, this.email, this.phone, this.examinationCenterOwnerName, this.cityId, this.neighborhood, this.street, this.image, this.examinationCenterState, this.commercialRegisterNumber, this.longitude, this.latitude, this.examinationCenterActive, this.rate, this.reviewsNum, this.reviews, this.refuessReason, this.isVerified, this.twoFactorSecretSendNum, this.twoFactorSecretTryNum});

    UserLoginResData.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        name = json["name"];
        email = json["email"];
        phone = json["phone"];
        examinationCenterOwnerName = json["examination_center_owner_name"];
        cityId = json["city_id"];
        neighborhood = json["neighborhood"];
        street = json["street"];
        image = json["image"];
        examinationCenterState = json["examination_center_state"];
        commercialRegisterNumber = json["commercial_register_number"];
        longitude = json["longitude"];
        latitude = json["latitude"];
        examinationCenterActive = json["examination_center_active"];
        rate = json["rate"];
        reviewsNum = json["reviews_num"];
        reviews = json["reviews"] ?? [];
        refuessReason = json["refuess_reason"];
        isVerified = json["is_verified"];
        twoFactorSecretSendNum = json["two_factor_secret_send_num"];
        twoFactorSecretTryNum = json["two_factor_secret_try_num"];
    }

    Map<String, dynamic> toJson() {
        final data = <String, dynamic>{};
        data["id"] = id;
        data["name"] = name;
        data["email"] = email;
        data["phone"] = phone;
        data["examination_center_owner_name"] = examinationCenterOwnerName;
        data["city_id"] = cityId;
        data["neighborhood"] = neighborhood;
        data["street"] = street;
        data["image"] = image;
        data["examination_center_state"] = examinationCenterState;
        data["commercial_register_number"] = commercialRegisterNumber;
        data["longitude"] = longitude;
        data["latitude"] = latitude;
        data["examination_center_active"] = examinationCenterActive;
        data["rate"] = rate;
        data["reviews_num"] = reviewsNum;
        if(reviews != null){
            data["reviews"] = reviews;
        }
        data["refuess_reason"] = refuessReason;
        data["is_verified"] = isVerified;
        data["two_factor_secret_send_num"] = twoFactorSecretSendNum;
        data["two_factor_secret_try_num"] = twoFactorSecretTryNum;
        return data;
    }
}