class MarketModel {
  bool? ok;
  List<MarketplaceRequest>? marketplaceRequests;
  Pagination? pagination;

  MarketModel({this.ok, this.marketplaceRequests, this.pagination});

  MarketModel.fromJson(Map<String, dynamic> json) {
    ok = json["ok"];
    marketplaceRequests = json["marketplace_requests"] == null ? null
        : (json["marketplace_requests"] as List).map((e) => MarketplaceRequest.fromJson(e)).toList();
    pagination = json["pagination"] == null ? null
        : Pagination.fromJson(json["pagination"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ok"] = ok;
    if (marketplaceRequests != null) {
      _data["marketplace_requests"] = marketplaceRequests?.map((e) => e.toJson()).toList();
    }
    if (pagination != null) {
      _data["pagination"] = pagination?.toJson();
    }
    return _data;
  }
}

class MarketplaceRequest {
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

  MarketplaceRequest({
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

  MarketplaceRequest.fromJson(Map<String, dynamic> json) {
    idHash = json["id_hash"];
    userDetails = json["user_details"] == null ? null
        : UserDetails.fromJson(json["user_details"]);
    isHighValue = json["is_high_value"];
    createdAt = json["created_at"];
    description = json["description"];
    requestDetails = json["request_details"] == null ? null
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
    profileImage = json["profile_image"] ?? "https://sproutsocial.com/glossary/profile-picture/";
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
  int? creatorCountMin;
  int? creatorCountMax;
  String? budget;
  String? brand;
  String? gender;

  RequestDetails({
    this.cities,
    this.followersRange,
    this.categories,
    this.languages,
    this.platform,
    this.creatorCountMin,
    this.creatorCountMax,
    this.budget,
    this.brand,
    this.gender,
  });

  RequestDetails.fromJson(Map<String, dynamic> json) {
    cities = json["cities"] == null ? null : List<String>.from(json["cities"]);
    followersRange = json["followers_range"] == null ? null
        : FollowersRange.fromJson(json["followers_range"]);
    categories = json["categories"] == null ? null
        : List<String>.from(json["categories"]);
    languages = json["languages"] == null ? null
        : List<String>.from(json["languages"]);
    platform =
    json["platform"] == null ? null : List<String>.from(json["platform"]);
    creatorCountMin = json["creator_count_min"];
    creatorCountMax = json["creator_count_max"];
    budget = json["budget"];
    brand = json["brand"];
    gender = json["gender"];
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
    _data["creator_count_min"] = creatorCountMin;
    _data["creator_count_max"] = creatorCountMax;
    _data["budget"] = budget;
    _data["brand"] = brand;
    _data["gender"] = gender;
    return _data;
  }
}

class FollowersRange {
  String? igFollowersMin;
  String? igFollowersMax;
  String? ytSubscribersMin;
  String? ytSubscribersMax;

  FollowersRange({
    this.igFollowersMin,
    this.igFollowersMax,
    this.ytSubscribersMin,
    this.ytSubscribersMax,
  });

  FollowersRange.fromJson(Map<String, dynamic> json) {
    igFollowersMin = json["ig_followers_min"];
    igFollowersMax = json["ig_followers_max"];
    ytSubscribersMin = json["yt_subscribers_min"];
    ytSubscribersMax = json["yt_subscribers_max"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ig_followers_min"] = igFollowersMin;
    _data["ig_followers_max"] = igFollowersMax;
    _data["yt_subscribers_min"] = ytSubscribersMin;
    _data["yt_subscribers_max"] = ytSubscribersMax;
    return _data;
  }
}

class Pagination {
  bool? hasMore;
  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;
  String? nextPageUrl;
  String? previousPageUrl;
  String? url;

  Pagination({
    this.hasMore,
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
    this.nextPageUrl,
    this.previousPageUrl,
    this.url,
  });

  Pagination.fromJson(Map<String, dynamic> json) {
    hasMore = json["has_more"];
    total = json["total"];
    count = json["count"];
    perPage = json["per_page"];
    currentPage = json["current_page"];
    totalPages = json["total_pages"];
    nextPageUrl = json["next_page_url"];
    previousPageUrl = json["previous_page_url"];
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["has_more"] = hasMore;
    _data["total"] = total;
    _data["count"] = count;
    _data["per_page"] = perPage;
    _data["current_page"] = currentPage;
    _data["total_pages"] = totalPages;
    _data["next_page_url"] = nextPageUrl;
    _data["previous_page_url"] = previousPageUrl;
    _data["url"] = url;
    return _data;
  }
}
