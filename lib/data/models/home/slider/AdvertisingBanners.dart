class AdvertisingBanners {
  AdvertisingBanners({
      this.id, 
      this.title, 
      this.image, 
      this.link, 
      this.orderBy, 
      this.position, 
      this.source, 
      this.categoryId, 
      this.instructorId, 
      this.courseId, 
      this.groupId, 
      this.cityIds,});

  AdvertisingBanners.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    link = json['link'];
    orderBy = json['order_by'];
    position = json['position'];
    source = json['source'];
    categoryId = json['category_id'];
    instructorId = json['instructor_id'];
    courseId = json['course_id'];
    groupId = json['group_id'];
    if (json['city_ids'] != null) {
      cityIds = [];
      json['city_ids'].forEach((v) {
        //cityIds!.add(Dynamic.fromJson(v));
      });
    }
  }
  int? id;
  String? title;
  String? image;
  String? link;
  int? orderBy;
  String? position;
  String? source;
  dynamic categoryId;
  dynamic instructorId;
  dynamic courseId;
  int? groupId;
  List<dynamic>? cityIds;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['image'] = image;
    map['link'] = link;
    map['order_by'] = orderBy;
    map['position'] = position;
    map['source'] = source;
    map['category_id'] = categoryId;
    map['instructor_id'] = instructorId;
    map['course_id'] = courseId;
    map['group_id'] = groupId;
    if (cityIds != null) {
      //map['city_ids'] = cityIds.map((v) => v.toJson()).toList();
    }
    return map;
  }

}