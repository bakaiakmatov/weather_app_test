import 'package:dio/dio.dart';
import 'package:weather_app_test/helper/weather_exception.dart';

class ApiRequest {
  static String url = 'https://api.openweathermap.org/data/2.5/weather';
  Future<Dio> initDio() async {
    return Dio(
      BaseOptions(
        baseUrl: url,
        responseType: ResponseType.json,
        receiveTimeout: 15000,
        connectTimeout: 15000,
      ),
    );
  }

  Future<Response> toGet(String url, {Map<String, dynamic>? param}) async {
    Dio dio = await initDio();
    try {
      return dio.get(url, queryParameters: param);
    } catch(e) {
      throw WeatherException.catchError(e);
    }
  }
}
