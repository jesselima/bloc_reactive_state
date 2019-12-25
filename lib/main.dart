/*
 * Tutorial link: https://www.youtube.com/watch?v=hTExlt1nJZI
 */

import 'package:bloc_reactive_state/bloc/bloc.dart';
import 'package:bloc_reactive_state/data/weather_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/weather_search_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: BlocProvider(
        builder: (context) => WeatherBloc(WeatherRepositoryImpl()),
        child: WeatherSearchPage(),
      ),
    );
  }
}