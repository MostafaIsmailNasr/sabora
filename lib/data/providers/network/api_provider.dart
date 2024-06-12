import 'dart:async';
import 'dart:io';

import 'package:get/get_connect/connect.dart';

import 'api_request_representable.dart';

class APIProvider {
  static const requestTimeOut = Duration(seconds: 100);
  final _client =
      GetConnect(timeout: requestTimeOut, allowAutoSignedCert: true);

  static final _singleton = APIProvider();

  static APIProvider get instance => _singleton;

  Future request(APIRequestRepresentable request, {int? type}) async {
    print("================>");
    print(request.url);
    print(request.method.string);
    print(request.headers);
    print(request.query);
    //print(request.body);
    print("=================");

    late final response;
    try {
      switch (type) {
        case 1:

        //  var response = await request.send();
//           var dio = dioo.Dio();
//           dio.options.headers = request.headers;
//           response = await dio.post(
//               request.url,
//               data: request.body);
// print("response=====>");
// print(response);
          break;
        default:
          response = await _client.request(request.url, request.method.string,
              headers: request.headers,
              query: request.query,
              body: request.body,
              contentType: request.contentType);
      }
      return returnResponse(response);
    } on TimeoutException catch (_) {
      throw TimeOutException(null);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  dynamic returnResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
        return response.body;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw BadRequestException('Not found');
      case 500:
        throw FetchDataException('Internal Server Error');
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.bodyString}');
    }
  }
}

class AppException implements Exception {
  final code;
  final message;
  final details;

  AppException({this.code, this.message, this.details});

  String toString() {
    return "[$code]: $message \n $details";
  }
}

class FetchDataException extends AppException {
  FetchDataException(String? details)
      : super(
          code: "fetch-data",
          message: "Error During Communication",
          details: details,
        );
}

class BadRequestException extends AppException {
  BadRequestException(String? details)
      : super(
          code: "invalid-request",
          message: "Invalid Request",
          details: details,
        );
}

class UnauthorisedException extends AppException {
  UnauthorisedException(String? details)
      : super(
          code: "unauthorised",
          message: "Unauthorised",
          details: details,
        );
}

class InvalidInputException extends AppException {
  InvalidInputException(String? details)
      : super(
          code: "invalid-input",
          message: "Invalid Input",
          details: details,
        );
}

class AuthenticationException extends AppException {
  AuthenticationException(String? details)
      : super(
          code: "authentication-failed",
          message: "Authentication Failed",
          details: details,
        );
}

class TimeOutException extends AppException {
  TimeOutException(String? details)
      : super(
          code: "request-timeout",
          message: "Request TimeOut",
          details: details,
        );
}
