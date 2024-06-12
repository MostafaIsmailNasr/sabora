import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../../../../app/services/local_storage.dart';
import '../../../models/editComentModel/EditRequest.dart';
import '../../../models/my_comments/CommentRequest.dart';
import '../../../models/quiz/quiz_answer/QuizAnswer.dart';
import '../../../models/rate/RateRequest.dart';
import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_representable.dart';

enum ApiType {
  checkCart,
  addToCart,
  checkoutCourse,
  deleteCart,
  validateCourse,
  myCourses,
  myQuizResults,
  myNotPQuizes,
  startQuiz,
  submitQuizResult,
  quizResult,
  listTeachers,
  teachersDetails,
  followTeacher,
  categories,
  myFavourits,
  toggleFavourits,
  suggestedCourses,
  search,
  myComments,
  editComment,
  deleteComment,
  addComment,
  supportTickets,
  supportContact,
  addCourseRate,
  addTicketReply,
  departments,
  addTicket,
  courseDetails,
  courseContent,
  sendFileView,
  courseReviews,
  quizDetails,
  addFreeCourse,
  closeTicket
}

class CourseAPI implements APIRequestRepresentable {
  final ApiType type;
  final storage = Get.find<LocalStorageService>();

  Map<String, dynamic>? loginRequest;

  String? courseID;
  String? coupon;
  String? discountID;
  String? cartID;
  String? groupID;
  String? organID;
  String? quizID;
  String? teacherID;
  String? searchText;
  int? followStatus;
  QuizAnswer? quizAnswer;
  String? commentType;
  String? fileID;
  String? commentId;
  CommentRequest? commentRequest;
  RateRequest? rateRequest;
  String? ticketMessage;
  File? attachedFile;
  String? ticketId;
  String? ticketTitle;
  String? departmentID;
  int? page;
  int? pageSize;
  EditRequest? editRequest;

  CourseAPI._(
      {required this.type,
      this.courseID,
      this.groupID,
      this.organID,
      this.followStatus,
      this.teacherID,
      this.coupon,
      this.discountID,
      this.cartID,
      this.quizID,
      this.quizAnswer,
      this.searchText,
      this.commentType,
      this.fileID,
      this.commentRequest,
      this.commentId,
      this.rateRequest,
      this.ticketMessage,
      this.attachedFile,
      this.page,
      this.pageSize,
      this.ticketTitle,
      this.departmentID,
      this.ticketId,
      this.editRequest});

  CourseAPI.checkCartData(int? groupID)
      : this._(groupID: groupID.toString(), type: ApiType.checkCart);

  CourseAPI.addCourseToCart(String courseID)
      : this._(courseID: courseID, type: ApiType.addToCart);

  CourseAPI.checkoutCourse(String coupon, String discountID)
      : this._(
            coupon: coupon,
            discountID: discountID,
            type: ApiType.checkoutCourse);

  CourseAPI.deleteCart(String cartID)
      : this._(cartID: cartID, type: ApiType.deleteCart);

  CourseAPI.validateCourseCoupon(String coupon)
      : this._(coupon: coupon, type: ApiType.validateCourse);

  CourseAPI.getMyCourses() : this._(type: ApiType.myCourses);

  CourseAPI.getMyQuizesResult() : this._(type: ApiType.myQuizResults);

  CourseAPI.getMyNotPQuizes() : this._(type: ApiType.myNotPQuizes);

  CourseAPI.startQuiz(String quizID)
      : this._(quizID: quizID, type: ApiType.startQuiz);

  CourseAPI.submitQuizResult(QuizAnswer quizAnswer, String quizID)
      : this._(
            quizAnswer: quizAnswer,
            quizID: quizID,
            type: ApiType.submitQuizResult);

  CourseAPI.getQuizResult(String quizID)
      : this._(quizID: quizID, type: ApiType.quizResult);

  CourseAPI.getTeacherDetails(
      String? teacherID, String? groupID, String? organID)
      : this._(
            teacherID: teacherID,
            groupID: groupID,
            organID: organID,
            type: ApiType.teachersDetails);

  CourseAPI.getTeachers(String? groupID)
      : this._(groupID: groupID, type: ApiType.listTeachers);

  CourseAPI.followTeacher(String? teacherID, int followStatus)
      : this._(
            teacherID: teacherID,
            followStatus: followStatus,
            type: ApiType.followTeacher);

  CourseAPI.getCategories(String? groupID)
      : this._(groupID: groupID, type: ApiType.categories);

  CourseAPI.getFavourits(String? organID)
      : this._(organID: organID, type: ApiType.myFavourits);

  CourseAPI.toggleFavourite(String? courseID)
      : this._(courseID: courseID, type: ApiType.toggleFavourits);

  CourseAPI.getCourseDetails(String? courseID)
      : this._(courseID: courseID, type: ApiType.courseDetails);

  CourseAPI.getCourseContents(String? courseID)
      : this._(courseID: courseID, type: ApiType.courseContent);

  CourseAPI.getSuggestedCourses(String? organID, String? groupID)
      : this._(
            organID: organID, groupID: groupID, type: ApiType.suggestedCourses);

  CourseAPI.search(String searchText, String? organID, String? groupID)
      : this._(
            searchText: searchText,
            organID: organID,
            groupID: groupID,
            type: ApiType.search);

  CourseAPI.getMyComments(
      String? commentType, String? fileID, int? page, int? pageSize)
      : this._(
            commentType: commentType,
            fileID: fileID,
            page: page,
            pageSize: pageSize,
            type: ApiType.myComments);

  CourseAPI.editComment(EditRequest? commentRequest)
      : this._(editRequest: commentRequest, type: ApiType.editComment);

  CourseAPI.deleteComment(String? commentId)
      : this._(commentId: commentId, type: ApiType.deleteComment);

  CourseAPI.addCourseComment(CommentRequest? commentRequest)
      : this._(commentRequest: commentRequest, type: ApiType.addComment);

  CourseAPI.addCourseRate(RateRequest? rateRequest)
      : this._(rateRequest: rateRequest, type: ApiType.addCourseRate);

  CourseAPI.getSupportTickets() : this._(type: ApiType.supportTickets);

  CourseAPI.getSupportContact() : this._(type: ApiType.supportContact);

  CourseAPI.addTicketReply(
      String ticketId, String ticketMessage, File? attachedFile)
      : this._(
            ticketId: ticketId,
            ticketMessage: ticketMessage,
            attachedFile: attachedFile,
            type: ApiType.addTicketReply);

  CourseAPI.closeTicket(String ticketId)
      : this._(ticketId: ticketId, type: ApiType.closeTicket);

  CourseAPI.getDepartments() : this._(type: ApiType.departments);

  CourseAPI.addNewTicket(String departmentID, String ticketTitle,
      String ticketMessage, File? attachedFile)
      : this._(
            departmentID: departmentID,
            ticketTitle: ticketTitle,
            ticketMessage: ticketMessage,
            attachedFile: attachedFile,
            type: ApiType.addTicket);

  CourseAPI.sendUserViewToServer(String? fileID, String? courseID)
      : this._(fileID: fileID, courseID: courseID, type: ApiType.sendFileView);

  CourseAPI.getCourseReviews(String? courseID)
      : this._(courseID: courseID, type: ApiType.courseReviews);

  CourseAPI.getQuizDetails(String? quizID)
      : this._(quizID: quizID, type: ApiType.quizDetails);

  CourseAPI.addFreeCourse(String? courseID)
      : this._(courseID: courseID, type: ApiType.addFreeCourse);

  @override
  String get endpoint => APIEndpoint.apiURL;

  String get path {
    switch (type) {
      // case ApiType.slider:
      //   return "/development/advertising-banner";
      case ApiType.checkCart:
        return "/development/panel/cart/list";
      case ApiType.addToCart:
        return "/development/panel/cart/store";
      case ApiType.checkoutCourse:
        return "/development/panel/cart/checkout";
      case ApiType.validateCourse:
        return "/development/panel/cart/coupon/validate";
      case ApiType.deleteCart:
        return "/development/panel/cart/${cartID}";
      case ApiType.myCourses:
        return "/development/panel/webinars/purchases";
      case ApiType.myQuizResults:
        return "/development/panel/quizzes/results/my-results";
      case ApiType.myNotPQuizes:
        return "/development/panel/quizzes/not_participated";
      case ApiType.startQuiz:
        return "/development/panel/quizzes/${quizID}/start";
      case ApiType.submitQuizResult:
        return "/development/panel/quizzes/${quizID}/store-result";
      case ApiType.quizResult:
        return "/development/panel/quizzes/${quizID}/result";
      case ApiType.listTeachers:
        return "/development/providers/instructors";
      case ApiType.teachersDetails:
        return "/development/users/${teacherID}/profile";

      case ApiType.followTeacher:
        return "/development/panel/users/${teacherID}/follow";

      case ApiType.categories:
        return "/development/categories";

      case ApiType.myFavourits:
        return "/development/panel/favorites";

      case ApiType.toggleFavourits:
        return "/development/panel/favorites/toggle/${courseID}";
      case ApiType.courseDetails:
        return "/development/courses/${courseID}";

      case ApiType.suggestedCourses:
        return "/development/courses";

      case ApiType.search:
        return "/development/search";

      case ApiType.myComments:
        return "/development/panel/comments";

      case ApiType.deleteComment:
        return "/development/panel/comments/${commentId}";

      case ApiType.editComment:
        return "/development/panel/comments";//"/development/panel/comments/${commentRequest?.commentId}";
      case ApiType.addComment:
        return "/development/panel/comments";

      case ApiType.addCourseRate:
        return "/development/panel/reviews";

      case ApiType.supportTickets:
        return "/development/panel/support/tickets";

      case ApiType.supportContact:
        return "/development/contacts/support";

      case ApiType.addTicketReply:
        return "/development/panel/support/${ticketId}/conversations";

      case ApiType.closeTicket:
        return "/development/panel/support/${ticketId}/close";

      case ApiType.departments:
        return "/development/panel/support/departments";

      case ApiType.addTicket:
        return "/development/panel/support";

      case ApiType.courseContent:
        return "/development/courses/content/${courseID}";
      case ApiType.sendFileView:
        return "/development/views-code";

      case ApiType.courseReviews:
        return "/development/courses/reviews/${courseID}";

      case ApiType.quizDetails:
        return "/development/courses/quiz_details/${quizID}";

      case ApiType.addFreeCourse:
        return "/development/panel/webinars/${courseID}/free";

      default:
        return "";
    }
  }

  @override
  HTTPMethod get method {
    switch (type) {
      case ApiType.checkCart:
      // case ApiType.slider:
      case ApiType.myCourses:
      case ApiType.myQuizResults:
      case ApiType.myNotPQuizes:
      case ApiType.startQuiz:
      case ApiType.quizResult:
      case ApiType.listTeachers:
      case ApiType.teachersDetails:
      case ApiType.categories:
      case ApiType.myFavourits:
      case ApiType.suggestedCourses:
      case ApiType.search:
      case ApiType.myComments:
      case ApiType.supportTickets:
      case ApiType.supportContact:
      case ApiType.closeTicket:
      case ApiType.departments:
      case ApiType.courseDetails:
      case ApiType.courseContent:
      case ApiType.courseReviews:
      case ApiType.quizDetails:
        return HTTPMethod.get;
      case ApiType.deleteCart:
      case ApiType.deleteComment:
        return HTTPMethod.delete;
      case ApiType.editComment:
         return HTTPMethod.post;

      default:
        return HTTPMethod.post;
    }
  }

  Map<String, String> get headers => {
        HttpHeaders.contentTypeHeader: 'application/json',
        'x-api-key': '1234321',
        "User-Agent": "PostmanRuntime/7.31.3",
        "Accept": "*/*",
        "X-Locale": storage.lang ?? "ar",
        "Connection": "keep-alive",
        "Authorization":
            "Bearer " + (storage.apiToken == null ? "" : storage.apiToken!)
      };

  Map<String, String> get query {
    switch (type) {
      case ApiType.checkCart:
      case ApiType.categories:
        return {
          HttpHeaders.contentTypeHeader: 'application/json',
          "group_id": groupID.toString()
        };
      case ApiType.myFavourits:
        return {
          HttpHeaders.contentTypeHeader: 'application/json',
          "organ_id": organID.toString()
        };
      case ApiType.suggestedCourses:
        return {
          HttpHeaders.contentTypeHeader: 'application/json',
          "organ_id": organID.toString(),
          "group_id": groupID.toString()
        };
      case ApiType.search:
        return {
          HttpHeaders.contentTypeHeader: 'application/json',
          "organ_id": organID.toString(),
          "group_id": groupID.toString(),
          "search": searchText.toString()
        };
      case ApiType.myComments:
        return {
          HttpHeaders.contentTypeHeader: 'application/json',
          "type": commentType.toString(),
          "file_id": fileID.toString(),
          "offset": page.toString(),
          "limit": pageSize.toString(),
        };
      case ApiType.sendFileView:
        return {
          HttpHeaders.contentTypeHeader: 'application/json',
          "webinar_id": courseID.toString(),
          "video_id": fileID.toString()
        };
      case ApiType.teachersDetails:
        return {
          HttpHeaders.contentTypeHeader: 'application/json',
          "group_id": groupID.toString(),
          "organ_id": organID.toString()
        };
      case ApiType.listTeachers:
        return {
          HttpHeaders.contentTypeHeader: 'application/json',
          "group_id": groupID.toString(),
        };


      default:
        return {HttpHeaders.contentTypeHeader: 'application/json'};
    }
  }

  @override
  dynamic get body {
    switch (type) {
      case ApiType.addToCart:
        return <String, dynamic>{"webinar_id": courseID};
      case ApiType.checkoutCourse:
        return <String, dynamic>{"coupon": coupon, "discount_id": discountID};
      case ApiType.validateCourse:
        return <String, dynamic>{"coupon": coupon};
      case ApiType.deleteCart:
        return <String, dynamic>{"webinar_id": courseID};
      case ApiType.submitQuizResult:
        return quizAnswer!.toJson();
      case ApiType.followTeacher:
        return <String, dynamic>{"status": followStatus};
      case ApiType.addCourseRate:
        print(rateRequest!.toJson());
        return rateRequest!.toJson();

      default:
        return null;
    }
  }

  Future request() {
    switch (type) {
      case ApiType.addComment:
        return addCommentRequest();
      case ApiType.editComment:
        return editCommentRequest();
      case ApiType.addTicketReply:
        return addTicketReplyRequest();
      case ApiType.addTicket:
        return addTicketRequest();

      default:
        return APIProvider.instance.request(this, type: 0);
    }
  }

  @override
  String get url => endpoint + path;

  @override
  // TODO: implement contentType
  String? get contentType {
    switch (type) {
      case ApiType.editComment:
        return "application/x-www-form-urlencoded; charset=UTF-8";
      case ApiType.addComment:
        return "application/x-www-form-urlencoded; charset=UTF-8";
      default:
        return null;
    }
  }

  Future addCommentRequest() async {
    // var imagefile;
    // var soundfile;
    var multipartFile;
    var multipartFileVoice;
    if (commentRequest?.commentImag != null) {
      var imagefile = File(commentRequest!.commentImag.toString());
      // open a bytestream
      var stream =
          new http.ByteStream(DelegatingStream.typed(imagefile.openRead()));
      // get file length
      var length = await imagefile.length();
      multipartFile = http.MultipartFile('image', stream, length,
          filename: basename(imagefile.path));
    }
    if (commentRequest?.commentSound != null) {
      var soundfile = File(commentRequest!.commentSound.toString());
      // open a bytestream
      var stream =
          new http.ByteStream(DelegatingStream.typed(soundfile.openRead()));
      // get file length
      var length = await soundfile.length();
      multipartFileVoice = http.MultipartFile('voice', stream, length,
          filename: basename(soundfile.path));
    }

    // string to uri
    var uri = Uri.parse(url);

    // create multipart request
    var request = http.MultipartRequest("POST", uri);

    // multipart that takes file
    // var multipartFile = new http.MultipartFile('file', stream, length,
    //     filename: basename(imageFile.path));
    print("addComment");
    print(commentRequest!.toJson());
    request.fields.addAll(commentRequest!.toJson());
    request.headers.addAll(headers);
    // add file to multipart
    if (multipartFile != null) request.files.add(multipartFile);
    if (multipartFileVoice != null) request.files.add(multipartFileVoice);

    // send
    var response = await request.send();
    print(response.statusCode);
    //return response;
    Completer completer = Completer();

    // listen for response
    var body;
    response.stream.transform(utf8.decoder).listen((value) {
      print("value");
      print(value);
      body = value;
      completer.complete(APIProvider.instance.returnResponse(Response(
          statusCode: response.statusCode,
          body: {"data": jsonDecode(body)}))["data"]);
    });
    return completer.future;
  }

  Future editCommentRequest() async {
    // var imagefile;
    // var soundfile;
    var multipartFile;
    var multipartFileVoice;
    if (editRequest?.commentImag != null) {
      var imagefile = File(editRequest!.commentImag.toString());
      // open a bytestream
      var stream =
      new http.ByteStream(DelegatingStream.typed(imagefile.openRead()));
      // get file length
      var length = await imagefile.length();
      multipartFile = http.MultipartFile('image', stream, length,
          filename: basename(imagefile.path));
    }
    if (editRequest?.commentSound != null) {
      var soundfile = File(editRequest!.commentSound.toString());
      // open a bytestream
      var stream =
      new http.ByteStream(DelegatingStream.typed(soundfile.openRead()));
      // get file length
      var length = await soundfile.length();
      multipartFileVoice = http.MultipartFile('voice', stream, length,
          filename: basename(soundfile.path));
    }

    // string to uri
    var uri = Uri.parse(url);

    // create multipart request
    var request = http.MultipartRequest("Post", uri);

    // multipart that takes file
    // var multipartFile = new http.MultipartFile('file', stream, length,
    //     filename: basename(imageFile.path));
    print("editComment");
    print(editRequest!.toJson());
    request.fields.addAll(editRequest!.toJson());
    request.headers.addAll(headers);
    // add file to multipart
    if (multipartFile != null) request.files.add(multipartFile);
    if (multipartFileVoice != null) request.files.add(multipartFileVoice);

    // send
    var response = await request.send();
    print(response.statusCode);
    //return response;
    Completer completer = Completer();

    // listen for response
    var body;
    response.stream.transform(utf8.decoder).listen((value) {
      print("value");
      print(value);
      body = value;
      completer.complete(APIProvider.instance.returnResponse(Response(
          statusCode: response.statusCode,
          body: {"data": jsonDecode(body)}))["data"]);
    });
    return completer.future;
  }

  Future addTicketReplyRequest() async {
    var multipartFile;
    print("attachedFile55");
    print(attachedFile);
    if (attachedFile != null) {
      // open a bytestream
      var stream =
          http.ByteStream(DelegatingStream.typed(attachedFile!.openRead()));
      // get file length
      var length = await attachedFile!.length();
      multipartFile = http.MultipartFile('attach', stream, length,
          filename: basename(attachedFile!.path));
      print("attachedFile55");
      print(multipartFile);
    }

    // string to uri
    var uri = Uri.parse(url);

    // create multipart request
    var request = http.MultipartRequest("POST", uri);

    // multipart that takes file
    // var multipartFile = new http.MultipartFile('file', stream, length,
    //     filename: basename(imageFile.path));
    request.fields.addAll({"message": ticketMessage.toString()});
    request.headers.addAll(headers);
    // add file to multipart
    if (multipartFile != null) request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);
    //return response;
    Completer completer = Completer();

    // listen for response
    var body;
    response.stream.transform(utf8.decoder).listen((value) {
      print("value");
      print(value);
      body = value;
      completer.complete(APIProvider.instance.returnResponse(Response(
          statusCode: response.statusCode,
          body: {"data": jsonDecode(body)}))["data"]);
    });
    return completer.future;
  }

  Future addTicketRequest() async {
    var multipartFile;
    print("attachedFile55");
    print(attachedFile);
    if (attachedFile != null) {
      // open a bytestream
      var stream =
          http.ByteStream(DelegatingStream.typed(attachedFile!.openRead()));
      // get file length
      var length = await attachedFile!.length();
      multipartFile = http.MultipartFile('attach', stream, length,
          filename: basename(attachedFile!.path));
      print("attachedFile55");
      print(multipartFile);
    }

    // string to uri
    var uri = Uri.parse(url);

    // create multipart request
    var request = http.MultipartRequest("POST", uri);

    // multipart that takes file
    // var multipartFile = new http.MultipartFile('file', stream, length,
    //     filename: basename(imageFile.path));
    request.fields.addAll({
      "title": ticketTitle.toString(),
      "department_id": departmentID.toString(),
      "type": "platform_support",
      "message": ticketMessage.toString()
    });
    request.headers.addAll(headers);
    // add file to multipart
    if (multipartFile != null) request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);
    //return response;
    Completer completer = Completer();

    // listen for response
    var body;
    response.stream.transform(utf8.decoder).listen((value) {
      print("value");
      print(value);
      body = value;
      completer.complete(APIProvider.instance.returnResponse(Response(
          statusCode: response.statusCode,
          body: {"data": jsonDecode(body)}))["data"]);
    });
    return completer.future;
  }
}
