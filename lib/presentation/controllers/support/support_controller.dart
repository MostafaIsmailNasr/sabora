import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:ui'; // You need to import these 2 libraries besides another libraries to work with this code

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/base/base_controller/BaseController.dart';
import '../../../data/models/BaseResponse.dart';
import '../../../data/models/support/Ticketsdata.dart';
import '../../../domain/usecases/support_use_case.dart';
import '../../widgets/custom_toast/custom_toast.dart';
class SupportController extends BaseController {
  SupportController(this._supportUseCase);

  final ReceivePort _port = ReceivePort();
  final ScrollController scrollController = ScrollController();

  final SupportUseCase _supportUseCase;
  Rx<Ticketsdata> ticket = Ticketsdata().obs;
  RxList supportTicketsList = [].obs;
  RxList departmentsList = [].obs;
  RxList supportList = [].obs;

  @override
  void onInit() async {
    super.onInit();
    supportTicketsList.value = [];
    initDownloadPost();
  }

  // This is what you're looking for!
  void scrollDown() {
    if (scrollController.hasClients)
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
      );
  }

  initDownloadPost() {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      if (status.value == DownloadTaskStatus.complete.value) {
        showToast("File Downloaded", gravity: Toast.bottom);
      }
      // setState((){ });
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  String getFileNameFromUrl(String url) {
    final uri = Uri.parse(url);
    return File(uri.pathSegments.last).path;
  }

  // void openFile(String filePath) async {
  //   try {
  //     File file = File(filePath);
  //     if (await file.exists()) {
  //       String contents = await file.readAsString();
  //       print('File contents: $contents');
  //     } else {
  //       print('File does not exist');
  //     }
  //   } catch (e) {
  //     print('Error while opening the file: $e');
  //   }
  // }

  void openAndDisplayImage(String filePath) async {
    try {
      File file = File(filePath);
      if (await file.exists()) {
        List<int> bytes = await file.readAsBytes();
        Uint8List imageBytes = Uint8List.fromList(bytes);

        Get.to(Scaffold(
          // appBar: AppBar(
          //   title: Text('Image Viewer'),
          //
          // ),
          body: Center(
            child: Image.memory(imageBytes),
          ),
        ));
      } else {
        print('File does not exist');
      }
    } catch (e) {
      print('Error while opening the file: $e');
    }
  }

  downloadFile(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
    // final status = await Permission.storage.request();
    //
    // if (status.isGranted) {
    //   var savePath = await Utils.createFolder("eclassesFiles");
    //   savePath=savePath+"/${getFileNameFromUrl(url)}";
    //   final response = await http.get(Uri.parse(url));
    //
    //   if (response.statusCode == 200) {
    //     final file = File(savePath);
    //     await file.writeAsBytes(response.bodyBytes);
    //     print('File downloaded to: $savePath');
    //     showToast("File downloaded to: $savePath");
    //     //openAndDisplayImage((savePath));
    //     Utils.viewFile(Uri.parse(savePath));
    //   } else {
    //     print('Error downloading file: ${response.statusCode}');
    //   }
    //   // final taskId = await FlutterDownloader.enqueue(
    //   //   url: url,
    //   //   headers: {},
    //   //   // optional: header send with url (auth token etc)
    //   //   savedDir: dir,
    //   //   showNotification: true,
    //   //   saveInPublicStorage: true,
    //   //
    //   //   // show download progress in status bar (for Android)
    //   //   openFileFromNotification:
    //   //       true, // click on notification to open downloaded file (for Android)
    //   // );
    //   // final externalDir = await getExternalStorageDirectory();
    //   //
    //   // final id = await FlutterDownloader.enqueue(
    //   //   url: url,
    //   //   savedDir: externalDir!.path,
    //   //   showNotification: true,
    //   //   openFileFromNotification: true,
    //   // );
    // } else {
    //   print('Permission Denied');
    // }

    // await FlutterDownloader.registerCallback(downlaodCallBack); // callback is a top-level or static function
  }
  getDepartments() async {
    departmentsList.value = [];
    try {
      RxStatus.loading();
      isLoading.value = true;
      final _departmentsResponse = await _supportUseCase.getDepartments();
      isLoading.value = false;
      print("_departmentsResponse");
      if(_departmentsResponse is BaseResponse){
      switch ((_departmentsResponse).success) {
        case false:
          dismissLoading();
          showToast(_departmentsResponse.message.toString(), gravity: Toast.bottom,isSuccess: false);
          break;
      }
      }else{
        departmentsList.value = _departmentsResponse as List;
      }
    } catch (error) {
      print(error);
      getDepartments();
      // showToast(error.toString(), gravity: Toast.bottom);
    }
  }
  getSupportTickets() async {
    supportTicketsList.value = [];
    try {
      RxStatus.loading();
      isLoading.value = true;
      final _ticketsResponse = await _supportUseCase.getSupportTickets();
      isLoading.value = false;
      print("_ticketsResponse");
      print(_ticketsResponse.toJson());
      switch ((_ticketsResponse).success) {
        case true:
          supportTicketsList.value = _ticketsResponse.ticketsdata as List;
          if (ticket.value.id != null) {
            ticket.value = supportTicketsList.value.firstWhere((element) =>
                element.id.toString() == ticket.value.id.toString());
          }
          scrollDown();
          break;
        case false:
          dismissLoading();
          showToast(_ticketsResponse.message.toString(), gravity: Toast.bottom,isSuccess: false);
          break;
      }
    } catch (error) {
      print(error);
      getSupportTickets();
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  getSupportContacts() async {
    supportList.value = [];
    try {
      RxStatus.loading();
      isLoading.value = true;
      final _supportContactResponse = await _supportUseCase.getSupportContact();
      isLoading.value = false;
      print("_supportContactResponse");
      print(_supportContactResponse.toJson());
      switch ((_supportContactResponse).success) {
        case true:
          supportList.value = _supportContactResponse.supportdata as List;
          break;
        case false:
          dismissLoading();
          showToast(_supportContactResponse.message.toString(),
              gravity: Toast.bottom,isSuccess: false);
          break;
      }
    } catch (error) {
      print(error);
      getSupportContacts();
      // showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  addNewTicket(
      String departmentID,  String ticketTitle,String ticketMessage, File? attachedFile) async {
    try {
      loading();
      final _addTicketResponse = await _supportUseCase.addNewTicket(
          departmentID, ticketTitle,ticketMessage, attachedFile);
      isLoading.value = false;
      print("_addTicketResponse");
      print(_addTicketResponse.toJson());
      switch ((_addTicketResponse).success) {
        case true:
          getSupportTickets();
          dismissLoading();
          showToast(getLocale().sent_succesfully,
              gravity: Toast.bottom);
          break;
        case false:
          dismissLoading();
          showToast(_addTicketResponse.message.toString(),
              gravity: Toast.bottom,isSuccess: false);
          break;
      }
    } catch (error) {
      print(error);
      addNewTicket(departmentID, ticketTitle, ticketMessage, attachedFile);
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  addTicketReply(
      String ticketId, String ticketMessage, File? attachedFile) async {
    try {
      loading();
      final _addTicketReplyResponse = await _supportUseCase.addTicketReply(
          ticketId, ticketMessage, attachedFile);
      isLoading.value = false;
      print("_addTicketReplyResponse");
      print(_addTicketReplyResponse.toJson());
      switch ((_addTicketReplyResponse).success) {
        case true:
          getSupportTickets();
          dismissLoading();
          showToast(getLocale().sent_succesfully,
              gravity: Toast.bottom);
          break;
        case false:
          dismissLoading();
          showToast(_addTicketReplyResponse.message.toString(),
              gravity: Toast.bottom,isSuccess: false);
          break;
      }
    } catch (error) {
      print(error);
      addTicketReply(ticketId, ticketMessage, attachedFile);
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }



  closeTicket(String ticketId) async {
    try {
      loading();
      final _closeTicketResponse = await _supportUseCase.closeTicket(ticketId);
      isLoading.value = false;
      print("_closeTicketResponse");
      print(_closeTicketResponse.toJson());
      switch ((_closeTicketResponse).success) {
        case true:
          dismissLoading();
          getSupportTickets();
          showToast(getLocale().the_conversation_has_closed_successfully,
              gravity: Toast.bottom);
          break;
        case false:
          dismissLoading();
          showToast(_closeTicketResponse.message.toString(),
              gravity: Toast.bottom,isSuccess: false);
          break;
      }
    } catch (error) {
      print(error);
      closeTicket(ticketId);
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }



}
