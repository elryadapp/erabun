
class TermesAndConditionModel {
    bool? status;
    TermesData? data;

    TermesAndConditionModel({this.status, this.data});

    TermesAndConditionModel.fromJson(Map<String, dynamic> json,{bool isPolicy=false}) {
        status = json["status"];
        data = json["data"] == null ? null : TermesData.fromJson(json["data"],isPolicy:isPolicy);
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

class TermesData {
    TermesItemData? data;

    TermesData({this.data});

    TermesData.fromJson(Map<String, dynamic> json,{isPolicy=false}) {
        data = json["data"] == null ? null : TermesItemData.fromJson(json["data"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data =<String, dynamic>{};
        if(this.data != null){
            data["data"] = this.data?.toJson();
        }
        return data;
    }
}

class TermesItemData {
    String? termsConditions;

    TermesItemData({this.termsConditions});

    TermesItemData.fromJson(Map<String, dynamic> json,{isPolicy=false}) {
        termsConditions =isPolicy? json["privacy_policy"]:json["termsConditions"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["privacy_policy"] = termsConditions;
        return data;
    }
}