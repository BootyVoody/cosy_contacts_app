import 'package:cosy_contacts/domain/model/response_model.dart';
import 'package:dio/dio.dart';

ResponseModel<T> handleHttpError<T>(DioError e) {
  switch (e.type) {
    case DioErrorType.connectTimeout:
      return ResponseModel(
          errorMessage: 'Время подключения к серверу вышло )^:');
    case DioErrorType.sendTimeout:
      return ResponseModel(
          errorMessage: 'Время отправления данных на сервер вышло )^:');
    case DioErrorType.receiveTimeout:
      return ResponseModel(
          errorMessage: 'Время ожидания ответа от сервера вышло )^:');
    case DioErrorType.response:
      return ResponseModel(
          errorMessage: e.response?.statusCode == 400
              ? 'Запрос выполнен неправильно. Проверьте '
              : '');
    case DioErrorType.cancel:
      // TODO: Handle this case.
      break;
    case DioErrorType.other:
      // TODO: Handle this case.
      break;
  }
}
