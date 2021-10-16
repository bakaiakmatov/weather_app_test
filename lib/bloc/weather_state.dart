part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}


class WeatherIsLoading extends WeatherState {}


class WeatherLoaded extends WeatherState {
  final WeatherModel model;
  WeatherLoaded(this.model);

}
class WeatherError extends WeatherState {
  final WeatherException message;
  WeatherError(this.message);
    
}

