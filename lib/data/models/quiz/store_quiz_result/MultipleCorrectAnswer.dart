class MultipleCorrectAnswer {
  MultipleCorrectAnswer({
      this.id, 
      this.title, 
      this.correct, 
      this.image, 
      this.createdAt, 
      this.updatedAt,});

  MultipleCorrectAnswer.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    correct = json['correct'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? title;
  int? correct;
  dynamic image;
  int? createdAt;
  dynamic updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['correct'] = correct;
    map['image'] = image;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}