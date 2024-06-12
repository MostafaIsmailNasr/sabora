import '../../course_details/enroll_course/RateType.dart';
import '../../teachers/Teachers.dart';


class Course {
  Course({
    this.image,
    this.groupId,
    this.organId,
    this.cityId,
    this.id,
    this.status,
    this.codeUsableTime,
    this.title,
    this.type,
    this.link,
    this.liveWebinarStatus,
    this.authHasBought,
    this.isFavorite,
    this.appLink,
    this.priceString,
    this.bestTicketString,
    this.price,
    this.discountPercent,
    this.activeSpecialOffer,
    this.duration,
    this.teacher,
    this.studentsCount,
    this.filesCount,
    this.chaptersCount,
    this.rate,
    this.createdAt,
    this.startDate,
    this.reviewsCount,
    this.points,
    this.progressPercent,
    this.category,
    this.capacity,
    this.shareLink,
    this.support,
    this.subscribe,
    this.description,
    this.prerequisites,
    this.videoDemo,
    this.videoDemoSource,
    this.imageCover,
    this.rateType,
    this.isDownloadable,
    this.authHasSubscription,
    this.canAddToCart,
    this.canBuyWithPoints,});

  Course.fromJson(dynamic json) {
    image = json['image'];
    groupId = json['group_id'];
    organId = json['organ_id'];
    cityId = json['city_id'];
    id = json['id'];
    status = json['status'];
    codeUsableTime = json['code_usable_time'];
    title = json['title'];
    type = json['type'];
    link = json['link'];
    liveWebinarStatus = json['live_webinar_status'];
    authHasBought = json['auth_has_bought'];
    isFavorite = json['is_favorite'];
    appLink = json['app_link'];
    priceString = json['price_string'];
    bestTicketString = json['best_ticket_string'];
    price = json['price'];
    discountPercent = json['discount_percent'];
    activeSpecialOffer = json['active_special_offer'];
    duration = json['duration'];
    teacher = json['teacher'] != null ? Teachers.fromJson(json['teacher']) : null;
    rateType = json['rate_type'] != null ? RateType.fromJson(json['rate_type']) : null;
    studentsCount = json['students_count'];
    filesCount = json['files_count'];
    chaptersCount = json['chapters_count'];
    rate = json['rate'];
    createdAt = json['created_at'];
    startDate = json['start_date'];
    reviewsCount = json['reviews_count'];
    points = json['points'];
    progressPercent = json['progress_percent'];
    category = json['category'];
    capacity = json['capacity'];
    shareLink = json['share_link'];
    support = json['support'];
    subscribe = json['subscribe'];
    description = json['description'];
    // if (json['prerequisites'] != null) {
    //   prerequisites = [];
    //   json['prerequisites'].forEach((v) {
    //     prerequisites.add(Dynamic.fromJson(v));
    //   });
    // }
    videoDemo = json['video_demo'];
    videoDemoSource = json['video_demo_source'];
    imageCover = json['image_cover'];
    isDownloadable = json['isDownloadable'];
    authHasSubscription = json['auth_has_subscription'];
    canAddToCart = json['can_add_to_cart'];
    canBuyWithPoints = json['can_buy_with_points'];
  }
  String? image;
  int? groupId;
  int? organId;
  dynamic cityId;
  int? id;
  String? status;
  int? codeUsableTime;
  String? title;
  String? type;
  String? link;
  dynamic liveWebinarStatus;
  bool? authHasBought;
  bool? isFavorite;
  String? appLink;
  int? priceString;
  dynamic bestTicketString;
  RateType? rateType;
  int? price;
  int? discountPercent;
  dynamic activeSpecialOffer;
  int? duration;
  Teachers? teacher;
  int? studentsCount;
  int? filesCount;
  int? chaptersCount;
  String? rate;
  int? createdAt;
  dynamic startDate;
  int? reviewsCount;
  dynamic points;
  int? progressPercent;
  String? category;
  dynamic capacity;
  bool? shareLink;
  bool? support;
  bool? subscribe;
  dynamic description;
  List<dynamic>? prerequisites;
  dynamic videoDemo;
  dynamic videoDemoSource;
  String? imageCover;
  bool? isDownloadable;
  bool? authHasSubscription;
  String? canAddToCart;
  bool? canBuyWithPoints;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = image;
    map['group_id'] = groupId;
    map['organ_id'] = organId;
    map['city_id'] = cityId;
    map['id'] = id;
    map['status'] = status;
    map['code_usable_time'] = codeUsableTime;
    map['title'] = title;
    map['type'] = type;
    map['link'] = link;
    map['live_webinar_status'] = liveWebinarStatus;
    map['auth_has_bought'] = authHasBought;
    map['is_favorite'] = isFavorite;
    map['app_link'] = appLink;
    map['price_string'] = priceString;
    map['best_ticket_string'] = bestTicketString;
    map['price'] = price;
    map['discount_percent'] = discountPercent;
    map['active_special_offer'] = activeSpecialOffer;
    map['duration'] = duration;
    if (teacher != null) {
      map['teacher'] = teacher!.toJson();
    }
    map['students_count'] = studentsCount;
    map['files_count'] = filesCount;
    map['chapters_count'] = chaptersCount;
    map['rate'] = rate;
    map['created_at'] = createdAt;
    map['start_date'] = startDate;
    map['reviews_count'] = reviewsCount;
    map['points'] = points;
    map['progress_percent'] = progressPercent;
    map['category'] = category;
    map['capacity'] = capacity;
    map['share_link'] = shareLink;
    map['support'] = support;
    map['subscribe'] = subscribe;
    map['description'] = description;
    if (rateType != null) {
      map['rate_type'] = rateType!.toJson();
    }
    // if (prerequisites != null) {
    //   map['prerequisites'] = prerequisites.map((v) => v.toJson()).toList();
    // }
    map['video_demo'] = videoDemo;
    map['video_demo_source'] = videoDemoSource;
    map['image_cover'] = imageCover;
    map['isDownloadable'] = isDownloadable;
    map['auth_has_subscription'] = authHasSubscription;
    map['can_add_to_cart'] = canAddToCart;
    map['can_buy_with_points'] = canBuyWithPoints;
    return map;
  }

}