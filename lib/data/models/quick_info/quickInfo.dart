import '../notifications/Notifications.dart';

class QuickInfoResponse {
  dynamic offline;
  dynamic spentPodynamics;
  dynamic totalPodynamics;
  dynamic availablePodynamics;
  String? roleName;
  String? fullName;
  dynamic financialApproval;
  UnreadNotifications? unreadNotifications;
  List<UnreadNoticeboards>? unreadNoticeboards;
  dynamic balance;
  bool? canDrawable;
  Badges? badges;
  dynamic countCartItems;
  dynamic pendingAppodynamicments;
  dynamic monthlySalesCount;
  MonthlyChart? monthlyChart;
  dynamic webinarsCount;
  dynamic reserveMeetingsCount;
  dynamic supportsCount;
  dynamic commentsCount;

  QuickInfoResponse(
      {this.offline,
      this.spentPodynamics,
      this.totalPodynamics,
      this.availablePodynamics,
      this.roleName,
      this.fullName,
      this.financialApproval,
      this.unreadNotifications,
      this.unreadNoticeboards,
      this.balance,
      this.canDrawable,
      this.badges,
      this.countCartItems,
      this.pendingAppodynamicments,
      this.monthlySalesCount,
      this.monthlyChart,
      this.webinarsCount,
      this.reserveMeetingsCount,
      this.supportsCount,
      this.commentsCount});

  QuickInfoResponse.fromJson(Map<String, dynamic> json) {
    offline = json['offline'];
    spentPodynamics = json['spent_podynamics'];
    totalPodynamics = json['total_podynamics'];
    availablePodynamics = json['available_podynamics'];
    roleName = json['role_name'];
    fullName = json['full_name'];
    financialApproval = json['financial_approval'];
    unreadNotifications = json['unread_notifications'] != null
        ? UnreadNotifications.fromJson(json['unread_notifications'])
        : null;
    if (json['unread_noticeboards'] != null) {
      unreadNoticeboards = <UnreadNoticeboards>[];
      json['unread_noticeboards'].forEach((v) {
        unreadNoticeboards!.add(UnreadNoticeboards.fromJson(v));
      });
    }
    balance = json['balance'];
    canDrawable = json['can_drawable'];
    badges = json['badges'] != null ? Badges.fromJson(json['badges']) : null;
    countCartItems = json['count_cart_items'];
    pendingAppodynamicments = json['pendingAppodynamicments'];
    monthlySalesCount = json['monthlySalesCount'];
    monthlyChart = json['monthlyChart'] != null
        ? MonthlyChart.fromJson(json['monthlyChart'])
        : null;
    webinarsCount = json['webinarsCount'];
    reserveMeetingsCount = json['reserveMeetingsCount'];
    supportsCount = json['supportsCount'];
    commentsCount = json['commentsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['offline'] = offline;
    data['spent_podynamics'] = spentPodynamics;
    data['total_podynamics'] = totalPodynamics;
    data['available_podynamics'] = availablePodynamics;
    data['role_name'] = roleName;
    data['full_name'] = fullName;
    data['financial_approval'] = financialApproval;
    if (unreadNotifications != null) {
      data['unread_notifications'] = unreadNotifications!.toJson();
    }
    if (unreadNoticeboards != null) {
      data['unread_noticeboards'] =
          unreadNoticeboards!.map((v) => v.toJson()).toList();
    }
    data['balance'] = balance;
    data['can_drawable'] = canDrawable;
    if (badges != null) {
      data['badges'] = badges!.toJson();
    }
    data['count_cart_items'] = countCartItems;
    data['pendingAppodynamicments'] = pendingAppodynamicments;
    data['monthlySalesCount'] = monthlySalesCount;
    if (monthlyChart != null) {
      data['monthlyChart'] = monthlyChart!.toJson();
    }
    data['webinarsCount'] = webinarsCount;
    data['reserveMeetingsCount'] = reserveMeetingsCount;
    data['supportsCount'] = supportsCount;
    data['commentsCount'] = commentsCount;
    return data;
  }
}

class UnreadNotifications {
  dynamic count;
  List<Notifications>? notifications;

  UnreadNotifications({this.count, this.notifications});

  UnreadNotifications.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (notifications != null) {
      data['notifications'] = notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UnreadNoticeboards {
  dynamic id;
  dynamic organId;
  dynamic userId;
  String? type;
  String? sender;
  String? title;
  String? message;
  dynamic createdAt;

  UnreadNoticeboards(
      {this.id,
      this.organId,
      this.userId,
      this.type,
      this.sender,
      this.title,
      this.message,
      this.createdAt});

  UnreadNoticeboards.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organId = json['organ_id'];
    userId = json['user_id'];
    type = json['type'];
    sender = json['sender'];
    title = json['title'];
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['organ_id'] = organId;
    data['user_id'] = userId;
    data['type'] = type;
    data['sender'] = sender;
    data['title'] = title;
    data['message'] = message;
    data['created_at'] = createdAt;
    return data;
  }
}

class Badges {
  String? nextBadge;
  dynamic percent;
  String? earned;

  Badges({this.nextBadge, this.percent, this.earned});

  Badges.fromJson(Map<String, dynamic> json) {
    nextBadge = json['next_badge'];
    percent = json['percent'];
    earned = json['earned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['next_badge'] = nextBadge;
    data['percent'] = percent;
    data['earned'] = earned;
    return data;
  }
}

class MonthlyChart {
  List<String>? months;
  List<dynamic>? data;

  MonthlyChart({this.months, this.data});

  MonthlyChart.fromJson(Map<String, dynamic> json) {
    months = json['months'].cast<String>();
    data = json['data'].cast<dynamic>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['months'] = months;
    data['data'] = this.data;
    return data;
  }
}
