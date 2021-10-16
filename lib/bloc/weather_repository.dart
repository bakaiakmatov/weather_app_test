import 'package:weather_app_test/model/weather_model.dart';
import 'package:weather_app_test/helper/api_request.dart';
import 'package:dio/dio.dart';
import 'package:weather_app_test/helper/exception.dart';

class WeatherRepository {
  final ApiRequest api;
  WeatherRepository(this.api);
  Future<WeatherModel> getWeather(String city) async {
    try {
      Response response = await api.toGet(
          '?appid=f222858fb5b0a062ac655c8e692eb066&units=metric&lang=ru',
          param: {
            'q': city,
          });
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      }
      throw WeatherException.catchError(Response);
    } catch (e) {
      throw WeatherException.catchError(e);
    }
  }
}
