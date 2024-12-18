import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import '../resources/string_manager.dart';



class ErrorHandler implements Exception {
  late String failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioExceptionType) {
      failure = _handleError(error);
    } else {
      failure = DataSource.defaultText.getFailure();
    }
  }

  String _handleError(DioExceptionType error) {
    if(error is SocketException){
      return DataSource.noInternetConnection.getFailure();
    }
    switch (error) {
      case DioExceptionType.unknown:
        {
          return DataSource.defaultText.getFailure();
        }
      case DioExceptionType.connectionTimeout:
        return DataSource.connectTimeOut.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.sendTimeOut.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSource.recieveTimeOut.getFailure();
    // check if the response itself coming with null!!
      case DioExceptionType.badResponse:
        return DataSource.badRequest.getFailure();
      case DioExceptionType.cancel:
        return DataSource.cancel.getFailure();

      case DioExceptionType.badCertificate:
        return DataSource.defaultText.getFailure();
      case DioExceptionType.connectionError:
        return DataSource.defaultText.getFailure();
    }
  }
}




enum DataSource {
  successText,
  noContent,
  badRequest,
  forbidden,
  unAuthorised,
  notFound,
  internalServerError,
  connectTimeOut,
  cancel,
  recieveTimeOut,
  sendTimeOut,
  cacheError,
  noInternetConnection,
  defaultText
}


class ResponseMessage {
  static String successText = StringsManager.success.tr(); // success with data
  static String noContent =
  StringsManager.noContent.tr(); // success with no data (no content)
  static String badRequest =
  StringsManager.badRequestError.tr(); // failure, API rejected request
  static String unAuthorised =
  StringsManager.unauthorizedError.tr(); // failure, user is not authorised
  static String forbidden =
  StringsManager.forbiddenError.tr(); //  failure, API rejected request
  static String internalServerError =
  StringsManager.internalServerError.tr(); // failure, crash in server side
  static String notFound =
  StringsManager.notFoundError.tr(); // failure, crash in server side

  // local status code
  static String connectTimeOut = StringsManager.timeoutError.tr();
  static String cancel = StringsManager.defaultError.tr();
  static String recieveTimeOut = StringsManager.timeoutError.tr();
  static String sendTimeOut = StringsManager.timeoutError.tr();
  static String cacheError = StringsManager.cacheError.tr();
  static String neInternetConnection = StringsManager.noInternetError.tr();
  static String defaultText = StringsManager.defaultError.tr();
}
class ResponseCode {
  // remote status code
  static const int successText = 200; // success with data
  static const int noContent = 201; // success with no data (no content)
  static const int badRequest = 400; // failure, API rejected request
  static const int unAuthorised = 401; // failure, user is not authorised
  static const int forbidden = 403; //  failure, API rejected request
  static const int notFound = 404; // failure, not found
  static const int internalServerError = 500; // failure, crash in server side

  // local status code
  static const int connectTimeOut = -1;
  static const int cancel = -2;
  static const int recieverTimeOut = -3;
  static const int sendTimeOut = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int defaultText = -7;
}
extension DataSourceExtension on DataSource {
  String getFailure() {
    switch (this) {
      case DataSource.successText:
        return (ResponseMessage.successText);
      case DataSource.noContent:
        return (ResponseMessage.noContent);
      case DataSource.badRequest:
        return ( ResponseMessage.badRequest);
      case DataSource.forbidden:
        return (ResponseMessage.forbidden);
      case DataSource.unAuthorised:
        return (ResponseMessage.unAuthorised);
      case DataSource.notFound:
        return (ResponseMessage.notFound);
      case DataSource.internalServerError:
        return (
            ResponseMessage.internalServerError);
      case DataSource.connectTimeOut:
        return (ResponseMessage.connectTimeOut);
      case DataSource.cancel:
        return ( ResponseMessage.cancel);
      case DataSource.recieveTimeOut:
        return (ResponseMessage.recieveTimeOut);
      case DataSource.sendTimeOut:
        return ( ResponseMessage.sendTimeOut);
      case DataSource.cacheError:
        return (ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return (ResponseMessage.neInternetConnection);
      case DataSource.defaultText:
        return (ResponseMessage.defaultText);
    }
  }
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}