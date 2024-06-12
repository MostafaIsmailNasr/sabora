
import '../../home/course_details/Course.dart';

class Items {
  Items({
      this.id, 
      this.user, 
      this.webinar, 
      this.price, 
      this.discount, 
      this.meeting,});

  Items.fromJson(dynamic json) {
    id = json['id'];
    user = json['user'];
    webinar = json['webinar'] != null ? Course.fromJson(json['webinar']) : null;
    price = json['price'];
    discount = json['discount'];
    meeting = json['meeting'];
  }
  int? id;
  dynamic user;
  Course? webinar;
  dynamic price;
  dynamic discount;
  dynamic meeting;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user'] = user;
    if (webinar != null) {
      map['webinar'] = webinar!.toJson();
    }
    map['price'] = price;
    map['discount'] = discount;
    map['meeting'] = meeting;
    return map;
  }

}