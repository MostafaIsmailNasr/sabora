import 'Ticketsdata.dart';

class TicketsResponse {
  TicketsResponse({
      this.success, 
      this.status, 
      this.message, 
      this.ticketsdata,});

  TicketsResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      ticketsdata = [];
      json['data'].forEach((v) {
        ticketsdata!.add(Ticketsdata.fromJson(v));
      });
    }
  }
  bool? success;
  String? status;
  String? message;
  List<Ticketsdata>? ticketsdata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (ticketsdata != null) {
      map['data'] = ticketsdata!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}