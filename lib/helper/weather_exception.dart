import 'package:dio/dio.dart';

class WeatherException {
  String? message;

  WeatherException({this.message});

  static WeatherException catchError(dynamic error) {
    if (error is DioError) {
      if (error.type == DioErrorType.connectTimeout) {
        return WeatherException(message: 'Время запроса истек');
      } else if (error.type == DioErrorType.response) {
        return WeatherException(message: 'Произошла ошибка системы');
      }
    } else {
      return WeatherException(message: 'Произошла системная ошибка');
    }
    return WeatherException(message: 'Произошла ошибка сервера');
  }
}
