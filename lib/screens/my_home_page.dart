import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_test/bloc/weather_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  late final WeatherBloc wBloc;
  String city = 'Украина';

  @override
  void initState() {
    super.initState();
    wBloc = BlocProvider.of<WeatherBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Узнай погоду в своем городе'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: BlocListener<WeatherBloc, WeatherState>(
                bloc: wBloc,
                child: BlocBuilder(
                  bloc: wBloc,
                  builder: (context, state) {
                    debugPrint(state.toString());

                    if (state is WeatherIsLoading || state is WeatherInitial) {
                      return const CircularProgressIndicator();
                    } else if (state is WeatherLoaded) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Image.asset(
                              'assets/1_1.png',
                              height: 200,
                            ),
                            Text(
                              state.model.name.toString(),
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32),
                            ),
                            const SizedBox(height: 26),
                            Text(
                              'Температура:' +
                                  state.model.main!.temp.toString() +
                                  '°C',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            const SizedBox(height: 26),
                            Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.blue, width: 2.0),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16.0),
                                ), //
                              ),
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: _controller,
                                decoration: const InputDecoration(
                                  hintText: 'Введите город',
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                minLines: 1,
                                maxLines: 1,
                              ),
                            )
                          ],
                        ),
                      );
                    } else if (state is WeatherError) {
                      return Text(state.message.message.toString());
                    }
                    return const SizedBox();
                  },
                ),
                listener: (context, state) {
                  debugPrint(state.toString());

                  if (state is WeatherError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.message.message.toString())));
                  } else if (state is WeatherLoaded) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Загружено успешно')));
                  }
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          city = _controller.text;
          wBloc.add(GetWeatherEvent(city));
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
