import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app_test/bloc/weather_repository.dart';
import 'package:weather_app_test/helper/api_request.dart';
import 'package:weather_app_test/helper/exception.dart';
import 'package:weather_app_test/model/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  final WeatherRepository repository;
 
  WeatherBloc(this.repository) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    try{
      if(event is GetWeatherEvent) {
        yield WeatherIsLoading();
        WeatherModel data = await repository.getWeather(event.city);
        yield WeatherLoaded(data);
      }
    }catch(e){
      yield WeatherError(WeatherException.catchError(e));
    }

  }
}
