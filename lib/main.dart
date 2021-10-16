import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_test/bloc/weather_bloc.dart';
import 'package:weather_app_test/bloc/weather_repository.dart';
import 'package:weather_app_test/helper/api_request.dart';
import 'package:weather_app_test/screens/my_home_page.dart';

void main() {
  final repository = WeatherRepository(ApiRequest());

  runApp(MyApp(
    repository: repository,
  ));
}

class MyApp extends StatelessWidget {
  final WeatherRepository repository;
  const MyApp({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home: BlocProvider(
        create: (context) =>
            WeatherBloc(repository)..add(GetWeatherEvent('Украина')),
        child: const MyHomePage(),
      ),
    );
  }
}
