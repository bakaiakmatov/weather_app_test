// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class WeatherException implements Exception {
  String? message;
  String? code;

  WeatherException({this.message, this.code});
  static WeatherException catchError(dynamic error) {
    if (error is DioError) {
      print('Error');
      switch (error.type) {
        case DioErrorType.response:
          {
            print(error.type);
            if (error.response!.statusCode == 404) {
              return WeatherException(
                message: error.response!.data['message'],
              );
            }
            return WeatherException(
              message: error.response!.data['message'],
            );
          }

        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
          {
            return WeatherException(message: 'Истекло время ожидания операции');
          }
        case DioErrorType.other:
          {
            return WeatherException(
                message: 'Проверьте соединение с интернетом');
          }

        case DioErrorType.cancel:
          {
            return WeatherException(message: 'Запрос отменен');
          }
        default:
          {
            return WeatherException(
                message: 'Произошла ошибка при ожидании операции');
          }
      }
    } else {
      print(error);
      return WeatherException(message: 'Произошла системная ошибка');
    }
  }
}
