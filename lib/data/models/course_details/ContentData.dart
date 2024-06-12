import 'dart:convert';
/// type : "file"
/// id : 288
/// order_number : 288
/// chapter_id : 186
/// title : "الدرس الاول"
/// position : null
/// file_id : 288
/// quiz_id : 178
/// must_pass : 0
/// auth_status : null
/// chapter_name : "الباب الاول"
/// webinar_id : 2136
/// video_duration : "10 sec"
/// percentage : 0
/// view_count : 0
/// accessibility : "paid"
/// file : "/store/1/e-classes - Made with Clipchamp (2).mp4"
/// zoom_password : null
/// file_type : "mp4"

ContentData contentDataFromJson(String str) => ContentData.fromJson(json.decode(str));
String contentDataToJson(ContentData data) => json.encode(data.toJson());
class ContentData {
  ContentData({
      String? type, 
      dynamic id, 
      dynamic orderNumber, 
      dynamic chapterId, 
      String? title, 
      dynamic position, 
      dynamic fileId, 
      dynamic quizId, 
      dynamic mustPass, 
      dynamic authStatus, 
      String? chapterName, 
      dynamic webinarId, 
      String? videoDuration, 
      dynamic percentage, 
      dynamic viewCount, 
      dynamic codeUsableTime,
      String? accessibility,
      String? file, 
      dynamic zoomPassword, 
      String? fileType,}){
    _type = type;
    _id = id;
    _orderNumber = orderNumber;
    _chapterId = chapterId;
    _title = title;
    _position = position;
    _fileId = fileId;
    _quizId = quizId;
    _mustPass = mustPass;
    _authStatus = authStatus;
    _chapterName = chapterName;
    _webinarId = webinarId;
    _videoDuration = videoDuration;
    _percentage = percentage;
    _viewCount = viewCount;
    _codeUsableTime = codeUsableTime;
    _accessibility = accessibility;
    _file = file;
    _zoomPassword = zoomPassword;
    _fileType = fileType;
}

  ContentData.fromJson(dynamic json) {
    _type = json['type'];
    _id = json['id'];
    _orderNumber = json['order_number'];
    _chapterId = json['chapter_id'];
    _title = json['title'];
    _position = json['position'];
    _fileId = json['file_id'];
    _quizId = json['quiz_id'];
    _mustPass = json['must_pass'];
    _authStatus = json['auth_status'];
    _chapterName = json['chapter_name'];
    _webinarId = json['webinar_id'];
    _videoDuration = json['video_duration'];
    _percentage = json['percentage'];
    _viewCount = json['views_count'];
    _codeUsableTime = json['code_usable_time'];
    _accessibility = json['accessibility'];
    _file = json['file'];
    _zoomPassword = json['zoom_password'];
    _fileType = json['file_type'];
  }
  String? _type;
  dynamic _id;
  dynamic _orderNumber;
  dynamic _chapterId;
  String? _title;
  dynamic _position;
  dynamic _fileId;
  dynamic _quizId;
  dynamic _mustPass;
  dynamic _authStatus;
  String? _chapterName;
  dynamic _webinarId;
  String? _videoDuration;
  dynamic _percentage;
  dynamic _viewCount;
  dynamic _codeUsableTime;
  String? _accessibility;
  bool? _locked;
  String? _file;
  dynamic _zoomPassword;
  String? _fileType;
ContentData copyWith({  String? type,
  dynamic id,
  dynamic orderNumber,
  dynamic chapterId,
  String? title,
  dynamic position,
  dynamic fileId,
  dynamic quizId,
  dynamic mustPass,
  dynamic authStatus,
  String? chapterName,
  dynamic webinarId,
  String? videoDuration,
  dynamic percentage,
  dynamic viewCount,
  dynamic codeUsableTime,
  String? accessibility,
  String? file,
  dynamic zoomPassword,
  String? fileType,
}) => ContentData(  type: type ?? _type,
  id: id ?? _id,
  orderNumber: orderNumber ?? _orderNumber,
  chapterId: chapterId ?? _chapterId,
  title: title ?? _title,
  position: position ?? _position,
  fileId: fileId ?? _fileId,
  quizId: quizId ?? _quizId,
  mustPass: mustPass ?? _mustPass,
  authStatus: authStatus ?? _authStatus,
  chapterName: chapterName ?? _chapterName,
  webinarId: webinarId ?? _webinarId,
  videoDuration: videoDuration ?? _videoDuration,
  percentage: percentage ?? _percentage,
  viewCount: viewCount ?? _viewCount,
  codeUsableTime:  codeUsableTime?? _codeUsableTime,
  accessibility: accessibility ?? _accessibility,
  file: file ?? _file,
  zoomPassword: zoomPassword ?? _zoomPassword,
  fileType: fileType ?? _fileType,
);
  String? get type => _type;
  dynamic get id => _id;
  dynamic get orderNumber => _orderNumber;
  dynamic get chapterId => _chapterId;
  String? get title => _title;
  dynamic get position => _position;
  dynamic get fileId => _fileId;
  dynamic get quizId => _quizId;
  dynamic get mustPass => _mustPass;
  dynamic get authStatus => _authStatus;
  String? get chapterName => _chapterName;
  dynamic get webinarId => _webinarId;
  String? get videoDuration => _videoDuration;
  dynamic get percentage => _percentage;
  dynamic get viewCount => _viewCount;
  dynamic get codeUsableTime => _codeUsableTime;
  String? get accessibility => _accessibility;
  bool? get locked => _locked??false;
  String? get file => _file;
  dynamic get zoomPassword => _zoomPassword;
  String? get fileType => _fileType;



  void setLocked(bool value) {
    _locked = value;
  }

  void setPercentage(double value) {
    _percentage = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['id'] = _id;
    map['order_number'] = _orderNumber;
    map['chapter_id'] = _chapterId;
    map['title'] = _title;
    map['position'] = _position;
    map['file_id'] = _fileId;
    map['quiz_id'] = _quizId;
    map['must_pass'] = _mustPass;
    map['auth_status'] = _authStatus;
    map['chapter_name'] = _chapterName;
    map['webinar_id'] = _webinarId;
    map['video_duration'] = _videoDuration;
    map['percentage'] = _percentage;
    map['view_count'] = _viewCount;
    map['code_usable_time'] = _codeUsableTime;
    map['accessibility'] = _accessibility;
    map['file'] = _file;
    map['zoom_password'] = _zoomPassword;
    map['file_type'] = _fileType;
    return map;
  }


}