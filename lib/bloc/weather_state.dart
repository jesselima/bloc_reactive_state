import 'package:bloc_reactive_state/data/model/weather.dart';
import 'package:equatable/equatable.dart';


// TODO -> 2 - Implement the State classes. Each state must be a class that extends Equatable.

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitialState extends WeatherState {
  const WeatherInitialState();

  @override
  List<Object> get props => [];
}


class WeatherLoadingState extends WeatherState {
  const WeatherLoadingState();

  @override
  List<Object> get props => [];
}


class WeatherLoadedState extends WeatherState {
  // Loaded state receives a weather instance because we need to show it on UI
  final Weather weather;
  const WeatherLoadedState(this.weather);

  @override
  List<Object> get props => [weather];
}


class WeatherErrorState extends WeatherState {

  final String message;
  const WeatherErrorState(this.message);

  @override
  List<Object> get props => [];
}