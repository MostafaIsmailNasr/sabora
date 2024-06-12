import 'dart:io';

import '../../data/models/BaseResponse.dart';
import '../../data/models/support/SupportContactResponse.dart';
import '../../data/models/support/TicketsResponse.dart';
import '../repositories/support_repository.dart';

class SupportUseCase  {
  final SupportRepository _repo;
  SupportUseCase(this._repo);

  Future<TicketsResponse> getSupportTickets() {
    return _repo.getSupportTickets();
  }

  Future<SupportContactResponse> getSupportContact() {
    return _repo.getSupportContact();
  }

  Future<BaseResponse> addTicketReply(String ticketId,String ticketMessage,File? attachedFile) {
    return _repo.addTicketReply(ticketId,ticketMessage,attachedFile);
  }

  Future<BaseResponse> closeTicket(String ticketId) {
    return _repo.closeTicket(ticketId);
  }

  Future<dynamic> getDepartments() {
    return _repo.getDepartments();
  }

  Future<BaseResponse>  addNewTicket(String departmentID, String ticketTitle, String ticketMessage, File? attachedFile)  {
    return _repo.addNewTicket(departmentID,ticketTitle,ticketMessage,attachedFile);
  }
}
