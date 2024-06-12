import 'ReviewsData.dart';

class CourseReviewResponse {
  CourseReviewResponse({
      this.success, 
      this.status, 
      this.message, 
      this.reviewsData,});

  CourseReviewResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      reviewsData = [];
      json['data'].forEach((v) {
        reviewsData!.add(ReviewsData.fromJson(v));
      });
    }
  }
  bool? success;
  String? status;
  String? message;
  List<ReviewsData>? reviewsData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (reviewsData != null) {
      map['data'] = reviewsData!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}