import 'dart:io';

import '../../domain/repositories/support_repository.dart';
import '../models/BaseResponse.dart';
import '../models/support/SupportContactResponse.dart';
import '../models/support/TicketsResponse.dart';
import '../providers/network/apis/course_api.dart';

class SupportRepositoryIml extends SupportRepository {
  @override
  Future<TicketsResponse> getSupportTickets() async{
    var response = await CourseAPI.getSupportTickets().request();
    print(response);
    return TicketsResponse.fromJson(response);
  }

  @override
  Future<SupportContactResponse> getSupportContact() async{
    var response = await CourseAPI.getSupportContact().request();
    print(response);
    return SupportContactResponse.fromJson(response);
  }

  @override
  Future<BaseResponse> addTicketReply(String ticketId,String ticketMessage, File? attachedFile) async{
    var response = await CourseAPI.addTicketReply(ticketId,ticketMessage,attachedFile).request();
    print(response);
    return BaseResponse.fromJson(response);
  }

  @override
  Future<BaseResponse> closeTicket(String ticketId)async {
    var response = await CourseAPI.closeTicket(ticketId).request();
    print(response);
    return BaseResponse.fromJson(response);
  }

  @override
  Future<dynamic> getDepartments() async{
    var response = await CourseAPI.getDepartments().request();
    print("getDepartments");
    print(response);
    return (response);
  }

  @override
  Future<BaseResponse> addNewTicket(String departmentID, String ticketTitle, String ticketMessage, File? attachedFile)async {
    var response = await CourseAPI.addNewTicket(departmentID,ticketTitle,ticketMessage,attachedFile).request();
    print(response);
    return BaseResponse.fromJson(response);
  }


}
