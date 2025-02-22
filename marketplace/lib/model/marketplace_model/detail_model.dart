class MarketModelDetail {
  bool? ok;
  WebMarketplaceRequest? webMarketplaceRequests;

  MarketModelDetail({this.ok, this.webMarketplaceRequests});

  MarketModelDetail.fromJson(Map<String, dynamic> json) {
    ok = json["ok"];
    webMarketplaceRequests = json["web_marketplace_requests"] == null
        ? null
        : WebMarketplaceRequest.fromJson(json["web_marketplace_requests"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ok"] = ok;
    if (webMarketplaceRequests != null) {
      _data["web_marketplace_requests"] = webMarketplaceRequests?.toJson();
    }
    return _data;
  }
}

class WebMarketplaceRequest {
  String? idHash;
  UserDetails? userDetails;
  bool? isHighValue;
  String? createdAt;
  String? description;
  RequestDetails? requestDetails;
  String? status;
  String? serviceType;
  String? targetAudience;
  bool? isOpen;
  bool? isPanIndia;
  bool? anyLanguage;
  bool? isDealClosed;
  String? slug;

  WebMarketplaceRequest({
    this.idHash,
    this.userDetails,
    this.isHighValue,
    this.createdAt,
    this.description,
    this.requestDetails,
    this.status,
    this.serviceType,
    this.targetAudience,
    this.isOpen,
    this.isPanIndia,
    this.anyLanguage,
    this.isDealClosed,
    this.slug,
  });

  WebMarketplaceRequest.fromJson(Map<String, dynamic> json) {
    idHash = json["id_hash"];
    userDetails = json["user_details"] == null
        ? null
        : UserDetails.fromJson(json["user_details"]);
    isHighValue = json["is_high_value"];
    createdAt = json["created_at"];
    description = json["description"];
    requestDetails = json["request_details"] == null
        ? null
        : RequestDetails.fromJson(json["request_details"]);
    status = json["status"];
    serviceType = json["service_type"];
    targetAudience = json["target_audience"];
    isOpen = json["is_open"];
    isPanIndia = json["is_pan_india"];
    anyLanguage = json["any_language"];
    isDealClosed = json["is_deal_closed"];
    slug = json["slug"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id_hash"] = idHash;
    if (userDetails != null) {
      _data["user_details"] = userDetails?.toJson();
    }
    _data["is_high_value"] = isHighValue;
    _data["created_at"] = createdAt;
    _data["description"] = description;
    if (requestDetails != null) {
      _data["request_details"] = requestDetails?.toJson();
    }
    _data["status"] = status;
    _data["service_type"] = serviceType;
    _data["target_audience"] = targetAudience;
    _data["is_open"] = isOpen;
    _data["is_pan_india"] = isPanIndia;
    _data["any_language"] = anyLanguage;
    _data["is_deal_closed"] = isDealClosed;
    _data["slug"] = slug;
    return _data;
  }
}

class UserDetails {
  String? name;
  String? profileImage;
  String? company;
  String? designation;

  UserDetails({
    this.name,
    this.profileImage,
    this.company,
    this.designation,
  });

  UserDetails.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    profileImage = json["profile_image"];
    company = json["company"];
    designation = json["designation"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["profile_image"] = profileImage;
    _data["company"] = company;
    _data["designation"] = designation;
    return _data;
  }
}

class RequestDetails {
  List<String>? cities;
  FollowersRange? followersRange;
  List<String>? categories;
  List<String>? languages;
  List<String>? platform;

  RequestDetails({
    this.cities,
    this.followersRange,
    this.categories,
    this.languages,
    this.platform,
  });

  RequestDetails.fromJson(Map<String, dynamic> json) {
    cities = json["cities"] == null ? null : List<String>.from(json["cities"]);
    followersRange = json["followers_range"] == null
        ? null
        : FollowersRange.fromJson(json["followers_range"]);
    categories = json["categories"] == null
        ? null
        : List<String>.from(json["categories"]);
    languages = json["languages"] == null
        ? null
        : List<String>.from(json["languages"]);
    platform =
    json["platform"] == null ? null : List<String>.from(json["platform"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (cities != null) {
      _data["cities"] = cities;
    }
    if (followersRange != null) {
      _data["followers_range"] = followersRange?.toJson();
    }
    if (categories != null) {
      _data["categories"] = categories;
    }
    if (languages != null) {
      _data["languages"] = languages;
    }
    if (platform != null) {
      _data["platform"] = platform;
    }
    return _data;
  }
}

class FollowersRange {
  String? igFollowersMin;
  String? igFollowersMax;

  FollowersRange({
    this.igFollowersMin,
    this.igFollowersMax,
  });

  FollowersRange.fromJson(Map<String, dynamic> json) {
    igFollowersMin = json["ig_followers_min"];
    igFollowersMax = json["ig_followers_max"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ig_followers_min"] = igFollowersMin;
    _data["ig_followers_max"] = igFollowersMax;
    return _data;
  }
}