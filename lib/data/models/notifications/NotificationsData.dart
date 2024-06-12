import 'Notifications.dart';

class NotificationsData {
  NotificationsData({
      this.count, 
      this.notifications,});

  NotificationsData.fromJson(dynamic json) {
    count = json['count'];
    if (json['notifications'] != null) {
      notifications = [];
      json['notifications'].forEach((v) {
        notifications!.add(Notifications.fromJson(v));
      });
    }
  }
  int? count;
  List<Notifications>? notifications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    if (notifications != null) {
      map['notifications'] = notifications!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}