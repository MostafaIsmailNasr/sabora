import 'dart:io';

import '../../data/models/BaseResponse.dart';
import '../../data/models/support/SupportContactResponse.dart';
import '../../data/models/support/TicketsResponse.dart';

abstract class SupportRepository {
  Future<TicketsResponse> getSupportTickets();

  Future<SupportContactResponse> getSupportContact();

  Future<BaseResponse> addTicketReply(String ticketId,String ticketMessage, File? attachedFile);
 // Future<TicketsResponse> getClassSupportTickets();



  Future<BaseResponse> closeTicket(String ticketId);

  Future<dynamic> getDepartments() ;

  Future<BaseResponse> addNewTicket(String departmentID, String ticketTitle, String ticketMessage, File? attachedFile);


}
