
class CenterReviewsModel {
    List<ReviewerData>? data;
    Links? links;
    Meta? meta;
    bool? status;
    String? token;

    CenterReviewsModel({this.data, this.links, this.meta, this.status, this.token});

    CenterReviewsModel.fromJson(Map<String, dynamic> json) {
        data = json["data"]==null ? null : (json["data"] as List).map((e)=>ReviewerData.fromJson(e)).toList();
        links = json["links"] == null ? null : Links.fromJson(json["links"]);
        meta = json["meta"] == null ? null : Meta.fromJson(json["meta"]);
        status = json["status"];
        token = json["token"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        if(this.data != null){
            data["data"] = this.data?.map((e)=>e.toJson()).toList();
        }
        if(links != null)
        {
            data["links"] = links?.toJson();
        }
        if(meta != null)
        {
            data["meta"] = meta?.toJson();
        }
        data["status"] = status;
        data["token"] = token;
        return data;
    }
}

class Meta {
    int? currentPage;
    int? from;
    int? lastPage;
    List<LinksDetails>? links;
    String? path;
    int? perPage;
    int? to;
    int? total;

    Meta({this.currentPage, this.from, this.lastPage, this.links, this.path, this.perPage, this.to, this.total});

    Meta.fromJson(Map<String, dynamic> json) {
        currentPage = json["current_page"];
        from = json["from"];
        lastPage = json["last_page"];
        links = json["links"]==null ? null : (json["links"] as List).map((e)=>LinksDetails.fromJson(e)).toList();
        path = json["path"];
        perPage = json["per_page"];
        to = json["to"];
        total = json["total"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["current_page"] = currentPage;
        data["from"] = from;
        data["last_page"] = lastPage;
        if(links != null){
            data["links"] = links?.map((e)=>e.toJson()).toList();
        }
        data["path"] = path;
        data["per_page"] = perPage;
        data["to"] = to;
        data["total"] = total;
        return data;
    }
}

class LinksDetails {
    dynamic url;
    String? label;
    bool? active;

    LinksDetails({this.url, this.label, this.active});

    LinksDetails.fromJson(Map<String, dynamic> json) {
        url = json["url"];
        label = json["label"];
        active = json["active"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["url"] = url;
        data["label"] = label;
        data["active"] = active;
        return data;
    }
}

class Links {
    String? first;
    String? last;
    dynamic prev;
    dynamic next;

    Links({this.first, this.last, this.prev, this.next});

    Links.fromJson(Map<String, dynamic> json) {
        first = json["first"];
        last = json["last"];
        prev = json["prev"];
        next = json["next"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data["first"] = first;
        data["last"] = last;
        data["prev"] = prev;
        data["next"] = next;
        return data;
    }
}

class ReviewerData {
    String? userName;
    dynamic userImage;
    int? rate;
    String? message;

    ReviewerData({this.userName, this.userImage, this.rate, this.message});

    ReviewerData.fromJson(Map<String, dynamic> json) {
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