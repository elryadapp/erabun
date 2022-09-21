
class UserDataModel {
    bool? status;
    UserModel? data;

    UserDataModel({this.status, this.data});

    UserDataModel.fromJson(Map<String, dynamic> json) {
        status = json["status"];
        data = json["data"] == null ? null : UserModel.fromJson(json["data"]);
    }

    Map<String, dynamic> toJson() {
        final  data = <String, dynamic>{};
        data["status"] = status;
        if(this.data != null){
            data["data"] = this.data?.toJson();
        }
        return data;
    }
}

class UserModel {
    String? token;
    ProfileDataModel? data;

    UserModel({this.token, this.data});

    UserModel.fromJson(Map<String, dynamic> json) {
        token = json["token"];
        data = json["data"] == null ? null : ProfileDataModel.fromJson(json["data"]);
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

class ProfileDataModel {
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
    List<Reviews>? reviews;
    dynamic refuessReason;
    int? isVerified;
    dynamic twoFactorSecretSendNum;
    int? twoFactorSecretTryNum;
    String? password;
    String? passwordConfirmation;

    ProfileDataModel({this.id,this.password,this.passwordConfirmation, this.name, this.email, this.phone, this.examinationCenterOwnerName, this.cityId, this.neighborhood, this.street, this.image, this.examinationCenterState, this.commercialRegisterNumber, this.longitude, this.latitude, this.examinationCenterActive, this.rate, this.reviewsNum, this.reviews, this.refuessReason, this.isVerified, this.twoFactorSecretSendNum, this.twoFactorSecretTryNum});

    ProfileDataModel.fromJson(Map<String, dynamic> json) {
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
        reviews = json["reviews"]==null ? null : (json["reviews"] as List).map((e)=>Reviews.fromJson(e)).toList();
        refuessReason = json["refuess_reason"];
        isVerified = json["is_verified"];
        twoFactorSecretSendNum = json["two_factor_secret_send_num"];
        twoFactorSecretTryNum = json["two_factor_secret_try_num"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["id"] = id;
        data["name"] = name;
        data['password_confirmation']=passwordConfirmation;
        data['password']=password;
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
            data["reviews"] = reviews?.map((e)=>e.toJson()).toList();
        }
        data["refuess_reason"] = refuessReason;
        data["is_verified"] = isVerified;
        data["two_factor_secret_send_num"] = twoFactorSecretSendNum;
        data["two_factor_secret_try_num"] = twoFactorSecretTryNum;
        return data;
    }
}

class Reviews {
    String? userName;
    dynamic userImage;
    int? rate;
    String? message;

    Reviews({this.userName, this.userImage, this.rate, this.message});

    Reviews.fromJson(Map<String, dynamic> json) {
        userName = json["userName"];
        userImage = json["userImage"];
        rate = json["rate"];
        message = json["message"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["userName"] = userName;
        data["userImage"] = userImage;
        data["rate"] = rate;
        data["message"] = message;
        return data;
    }
}