import 'Webinars.dart';
import 'Users.dart';
import 'Teachers.dart';
import 'Organizations.dart';

class Searchdata {
  Searchdata({
      this.webinars, 
      this.users, 
      this.teachers, 
      this.organizations,});

  Searchdata.fromJson(dynamic json) {
    webinars = json['webinars'] != null ? Webinars.fromJson(json['webinars']) : null;
    users = json['users'] != null ? Users.fromJson(json['users']) : null;
    teachers = json['teachers'] != null ? TeachersSearch.fromJson(json['teachers']) : null;
    organizations = json['organizations'] != null ? Organizations.fromJson(json['organizations']) : null;
  }
  Webinars? webinars;
  Users? users;
  TeachersSearch? teachers;
  Organizations? organizations;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (webinars != null) {
      map['webinars'] = webinars!.toJson();
    }
    if (users != null) {
      map['users'] = users!.toJson();
    }
    if (teachers != null) {
      map['teachers'] = teachers!.toJson();
    }
    if (organizations != null) {
      map['organizations'] = organizations!.toJson();
    }
    return map;
  }

}