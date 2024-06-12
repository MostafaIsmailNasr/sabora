import 'Sender.dart';

class Conversations {
  Conversations({
      this.message, 
      this.sender, 
      this.supporter, 
      this.attach, 
      this.createdAt,});

  Conversations.fromJson(dynamic json) {
    message = json['message'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    supporter = json['supporter'] != null ? Sender.fromJson(json['supporter']) : null;
    attach = json['attach'];
    createdAt = json['created_at'];
  }
  String? message;
  Sender? sender;
  Sender? supporter;
  dynamic attach;
  int? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (sender != null) {
      map['sender'] = sender!.toJson();
    }
    if (supporter != null) {
      map['supporter'] = supporter!.toJson();
    }

    map['attach'] = attach;
    map['created_at'] = createdAt;
    return map;
  }

}