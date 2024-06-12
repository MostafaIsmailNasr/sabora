import 'dart:io';

class CommentRequest {
  CommentRequest({
    this.commentId,
    this.itemId,
    this.itemName,
    this.commentImag,
    this.commentSound,
    this.comment,
    this.comment_id
  });

  // CommentRequest.fromJson(dynamic json) {
  //   comment = json['comment'];
  //   commentImag = json['image'];
  //   commentSound = json['voice'];
  //   commentId = json['id'];
  // }

  String? itemId;
  String? itemName;
  String? commentId;
  File? commentImag;
  String? commentSound;
  String? comment;
  String? comment_id;

  Map<String, String> toJson() {
    final map = <String, String>{};
    map['item_id'] = itemId??"";
    map['item_name'] = itemName??"";
    map['comment'] = comment??"";
    map['comment_id'] =comment_id??"";
    // map['image'] = commentImag;
    // map['voice'] = commentSound;
    // map['id'] = commentId;
    return map;
  }
}
